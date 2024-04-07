using DataFrames
using JLD2
using PrettyTables
using StatsBase

include("evaluation.jl")
include("export.jl")
results_pairs, results_pairs_fine, results_simul = load.(
    "results_fine.jld2", ["results_pairs", "results_pairs_fine", "results_simul"]
);
results_simul_wrapped = Dict("foo" => Dict("bar" => results_simul))

switch_info(results_pairs)
switch_info(results_simul_wrapped)

# Replication can1990/deu1990: identical to Han and Han/Schefold
println("Replicate can1990/deu1990:")
can1990_deu1990_replication = replicate_intensities(results_pairs, "can1990", "deu1990", x -> x in 0.62:0.01:0.7)
# You can export to Markdown like this
pretty_table(can1990_deu1990_replication, backend=Val(:markdown))
# You can export to LaTeX like this
can1990_deu1990_table = process_latex_table(can1990_deu1990_replication, :Country)
println(can1990_deu1990_table)

# Replication can1981/can1990: identical to Han
can1981_can1990_replication = replicate_trunc(results_pairs, "can1981", "can1990", 0.52)
pretty_table(can1981_can1990_replication, backend=Val(:markdown))

# Replication deu1978/deu1990: identical to Han
replicate_intensities(results_pairs, "deu1978", "deu1990",
    x -> x in [0.0, 0.01, 0.02, 0.08, 0.25, 0.29, 0.3, 0.37, 0.38, 0.39, 0.4, 0.41, 0.42, 0.49]
)

# Replication deu1978/deu1986: identical to Han
replicate_intensities(results_pairs, "deu1978", "deu1986",
    x -> x in [0.14, 0.15, 0.17, 0.18, 0.19, 0.22, 0.24, 0.25, 0.28, 0.29, 0.3, 0.31, 0.32]
)
replicate_trunc(results_pairs, "deu1978", "deu1986", 0.31)

# Replication gbr1979/gbr1984: 0.79 from Han/Schefold is not a switchpoint but 0.81 is!
replicate_intensities(results_pairs, "gbr1979", "gbr1984",
    x -> x in [0.0, 0.01, 0.02, 0.08, 0.25, 0.29, 0.3, 0.37, 0.38, 0.39, 0.4, 0.41, 0.42, 0.49]
)
replicate_trunc(results_pairs, "gbr1979", "gbr1984", 0.81)

# Replication deu1986/gbr1979: intensities roughly match Han/Schefold (individual differences in the decimal places)
replicate_intensities(results_pairs, "deu1986", "gbr1979",
    x -> x in 0:0.01:0.15
)

