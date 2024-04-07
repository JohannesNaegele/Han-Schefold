# Initialize vector with all considered countries
ids = [
    "aus1968", "aus1974", "aus1986", "aus1989",
    "can1971", "can1976", "can1981", "can1986", "can1990",
    "deu1978", "deu1986", "deu1988", "deu1990",
    "dnk1972", "dnk1977", "dnk1980", "dnk1985", "dnk1990",
    "fra1980", "fra1985", "fra1990",
    "gbr1968", "gbr1979", "gbr1984", "gbr1990",
    "ita1985",
    "jpn1970", "jpn1975", "jpn1980", "jpn1985", "jpn1990",
    "usa1982"
]

# Initialize DataFrame to store all input data later
df = DataFrame(country = String[], labour = DataFrame[], demand = DataFrame[],
    output = DataFrame[], io_table = DataFrame[])

# Fill data into df
for id in ids
    country_path = "data/1995/" * id * "c.xls"
    labour = DataFrame() # Compensation of employees
    insertcols!(labour, 1,
        readxl(country_path, "total!B43:B43") => Vector{Float64}(vec(readxl(
            country_path, "total!C43:AL43")))
    )
    output = DataFrame() # Gross output
    insertcols!(output, 1,
        readxl(country_path, "total!AU4:AU4") => Vector{Float64}(vec(readxl(
            country_path, "total!AU6:AU41")))
    )
    demand = DataFrame() # Total final demand
    insertcols!(demand, 1,
        readxl(country_path, "total!AS4:AS4") => Vector{Float64}(vec(readxl(
            country_path, "total!AS6:AS41")))
    )
    io_table = DataFrame( # Input-output table
        Matrix{Float64}(readxl(country_path, "total!C6:AL41")), vec(readxl(
            country_path, "total!C4:AL4"))
    )
    push!(df,
        (country = id, labour = labour, output = output,
            demand = demand, io_table = io_table))
end

# Group by country (this whole structure is a bit of an overkill since only one row per group, but works)
df = groupby(df, "country")