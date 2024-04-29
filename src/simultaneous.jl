""" Compute the envelope for all countries at once. """
function simultaneous_comparisons(ids; step = 0.01, verbose = false, effects_sectors = 33)

    # Read in data
    data = preprocess_data.(ids)
    A = reduce(hcat, Aᵢ for (Aᵢ, lᵢ, dᵢ) in data)
    n_goods = size(A, 1)
    l = vec(reduce(hcat, lᵢ for (Aᵢ, lᵢ, dᵢ) in data))'
    d = vec(sum(lᵢ for (Aᵢ, lᵢ, dᵢ) in data) / length(ids))
    B = reduce(hcat, I(n_goods) for _ in eachindex(ids))

    # Preallocate solver variables
    lb = zeros(n_goods * length(ids))
    l_trunc = zeros(n_goods)'
    C_trunc = zeros(n_goods, n_goods)

    # Create LP solvers
    solver = optimizer_with_attributes(HiGHS.Optimizer, "log_to_console" => false)
    model_x = create_intensities_r_solver(solver, l, A, B, d, lb)
    model_x_trunc = create_intensities_solver(
        solver, l_trunc, C_trunc, ones(n_goods), lb[1:n_goods]
    )
    model_p = create_prices_solver(solver, l_trunc, C_trunc, ones(n_goods), lb[1:n_goods])

    R = compute_R(maximum.(real_eigvals.(Aᵢ for (Aᵢ, lᵢ, dᵢ) in data)))
    df_q, profit_rates_to_names, profit_rates, switches = compute_envelope(
        A = A,
        B = B,
        l = l,
        d = d,
        R = R,
        step = step,
        model_intensities = model_x,
        model_intensities_trunc = model_x_trunc,
        model_prices = model_p,
        verbose = verbose,
        effects_sectors = effects_sectors
    )
    n_switches = length(switches["technology"])
    labeled_tech = Matrix{String}(undef, effects_sectors, n_switches + 1)
    for i in eachindex(switches["technology"])
        country_index = div.(switches["technology"][i][1].second .- 1, n_goods) .+ 1
        labeled_tech[:, i] = map(j -> ids[j], country_index)
    end
    country_index = div.(switches["technology"][n_switches][2].second .- 1, n_goods) .+ 1
    labeled_tech[:, n_switches + 1] = map(j -> ids[j], country_index)
    return Dict(
        "A" => A,
        "B" => B,
        "l" => l,
        "d" => d,
        "intensities" => df_q,
        "names" => profit_rates_to_names,
        "profit_rates" => profit_rates,
        "switches" => switches,
        "labeled_technology" => labeled_tech,
        "max_R" => 0.0
    )
end