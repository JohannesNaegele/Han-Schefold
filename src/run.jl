using LinearAlgebra
using ExcelReaders
using DataFrames
using JuMP
using HiGHS
using JLD2

include("preprocess.jl")
include("helpers.jl")
include("envelope.jl")
include("pairwise.jl")
include("simultaneous.jl")

results_pairs = pairwise_comparisons(ids, step = 0.01)
results_pairs_fine = pairwise_comparisons(ids, step = 0.00001, save_q = false)
results_simul = simultaneous_comparisons(ids)
jldsave("results.jld2"; results_pairs, results_pairs_fine, results_simul)