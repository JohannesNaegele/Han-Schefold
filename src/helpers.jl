# Get the names of all sectors from input-output table
const sectors = names(df[(ids[1],)][1, "io_table"])

""" Compute the real valued eigenvalues. """
get_data(country, indicator) = Matrix(df[(country,)][1, indicator])

function normalize_data(data, output)
    for i in eachindex(output)
        if output[i] != 0.0
            data[:, i] /= output[i]
        end
    end
end

# FIXME: ensure that if output is zero, only allow 0.0 to be set if no labour
# safe_divide(x, y) = y == 0 ? (x == 0 ? 0.0 : Inf) : x / y
safe_divide(x, y) = y == 0 ? (x == 0 ? 0.0 : 0.0) : x / y

""" Return normalized data for a country. """
function preprocess_data(country)
    io_table = get_data(country, "io_table")
    output = get_data(country, "output")
    labour = get_data(country, "labour")'
    demand = get_data(country, "demand")

    demand = map(safe_divide, demand, output)
    normalize_data(io_table, output)
    normalize_data(labour, output)

    return io_table, labour, demand
end

""" Compute the real valued eigenvalues. """
real_eigvals(x) = real.(filter(e -> imag(e) == 0, eigvals(x)))

"""
Compute the highest sensible profit rate for given eigenvalues of the input-output matrix.

Briefly stated, an application of the Perron-Frobenius theorem gives the existence of ???
"""
function compute_R(eigenvalues)
    return minimum((1.0 .- eigenvalues) ./ eigenvalues)
end

replace_with_zero(x) = x == 1.0 ? 0.0 : x

""" Setup and return a solver for our linear problem with intensities. """
function create_intensities_r_solver(solver, l, A, B, d, lb)
    model = direct_model(solver)
    @variable(model, x[i = eachindex(lb)] >= lb[i])
    @variable(model, y[i = eachindex(lb)])
    @objective(model, Min, l * x)
    @constraint(model, con[i = eachindex(lb)], 1 * x[i] - y[i] == 0)
    @constraint(model, d, B * x - A * y .>= d)
    return model
end

""" Setup and return a solver for our linear problem with intensities. """
function create_intensities_solver(solver, l, C, d, lb)
    model = direct_model(solver)
    @variable(model, x[i = eachindex(lb)].>=lb[i])
    @objective(model, Min, sum(x[i] * l[i] for i in eachindex(lb)))
    @constraint(model, con, C * x.≥d)
    return model
end

""" Setup and return a solver for our linear problem with prices. """
function create_prices_solver(solver, l, C, d, lb)
    model = direct_model(solver)
    @variable(model, p[i = eachindex(lb)].>=lb[i])
    @objective(model, Max, sum(p[i] * d[i] for i in eachindex(lb)))
    @constraint(model, con, C' * p.≤vec(l))
    return model
end

""" ??? """
function modify_A!(model, A, B, d)
    delete(model, model[:d])
    unregister(model, :d)
    @constraint(model, d, B * model[:x] - A * model[:y] .>= d)
end

""" Set the coefficient of variable[j] in the i-th constraint to C[i, j]. """
function modify_C!(model, variable, C)
    for j in axes(C, 2)  # Loop over the columns of C (each variable)
        set_normalized_coefficient.(model[:con], variable[j], vec(C[:, j]))
    end
end

""" ??? """
function modify_r!(model, r)
    set_normalized_coefficient(model[:con], model[:x], fill(1 + r, length(model[:x])))
end