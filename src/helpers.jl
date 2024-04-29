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