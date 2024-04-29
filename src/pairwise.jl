""" Compute the pairwise envelope and associated numerical results. """
function pairwise_comparisons(ids; step = 0.01, save_all = true, n_goods = 36)

    # Dict for results
    results = Dict(
        [id1 => Dict(
             [id2 => Dict()
              for (j, id2) in enumerate(ids)
              if j > i]
         )
         for (i, id1) in enumerate(ids)]
    )
    solver = optimizer_with_attributes(HiGHS.Optimizer, "log_to_console" => false)

    iteration = Threads.Atomic{Int}(0);
    Threads.@threads :dynamic for i in eachindex(ids)
        # Preallocate solver variables
        l = zeros(2 * n_goods)'
        A = zeros(n_goods, 2 * n_goods)
        B = [I(n_goods) I(n_goods)]
        d = zeros(n_goods)
        lb = zeros(2 * n_goods)
        l_trunc = zeros(n_goods)'
        C_trunc = zeros(n_goods, n_goods)
        # Initialize solvers
        model_x = create_intensities_r_solver(solver, l, A, B, d, lb)
        model_x_trunc = create_intensities_solver(
            solver, l_trunc, C_trunc, ones(n_goods), lb[1:n_goods])
        model_p = create_prices_solver(
            solver, l_trunc, C_trunc, ones(n_goods), lb[1:n_goods])
        set_optimizer_attributes.([model_x, model_x_trunc, model_p])
        set_silent.([model_x, model_x_trunc, model_p])

        # Solve for pairs of countries
        country1 = ids[i]
        A1, l1, d1 = preprocess_data(country1)
        n_goods = size(A1, 1)
        for country2 in view(ids, (i + 1):length(ids))

            Threads.atomic_add!(iteration, 1)
            println(country1, country2, ", iteration: $(iteration[])")

            A2, l2, d2 = preprocess_data(country2)
            d .= vec((d1 + d2) / 2)
            A = [A1 A2]
            l .= [l1 l2]
            R = compute_R(maximum.(real_eigvals.([A1, A2])))
            modify_A!(model_x, A, B, d)
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
                save_all = save_all
            )
            n_countries = div(size(A, 2), n_goods)
            insertcols!(df_q, 1, "Sector" => repeat(sectors, n_countries))
            insertcols!(df_q,
                1,
                "Country" => reduce(
                    vcat, fill(country, n_goods) for country in [country1, country2]))
            if save_all
                results[country1][country2] = Dict(
                    "intensities" => df_q,
                    "names" => profit_rates_to_names,
                    "profit_rates" => profit_rates,
                    "switches" => switches
                )
            else
                results[country1][country2] = Dict(
                    "names" => profit_rates_to_names,
                    "profit_rates" => profit_rates,
                    "switches" => switches
                )
            end
        end
    end
    # TODO: copy results in dict in symmetry
    return results
end