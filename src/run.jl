
using Sraffa
using LinearAlgebra
using ExcelReaders
using DataFrames
using JuMP
using HiGHS
using JLD2

include("preprocess.jl")
include("helpers.jl")
include("pairwise.jl")
include("simultaneous.jl")

@time results_pairs = pairwise_comparisons(ids, stepsize = 0.01) # 11s
# Beware: This finer grid can take up to several hours to run
# Make sure to start Julia with multiple cores if possible,
# you also need around 16 GB RAM/Swap for this to work
@time results_pairs_fine = pairwise_comparisons(ids, stepsize = 0.00001, save_all = false)
@time results_simul = simultaneous_comparisons(ids, stepsize = 0.0001)
@profview results_simul = simultaneous_comparisons(ids, stepsize = 0.001)
@time jldsave("results.jld2"; results_pairs, results_pairs_fine, results_simul)