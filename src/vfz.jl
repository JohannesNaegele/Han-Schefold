using IterTools: product
global precision_r_diff = 1e-6

# TODO: ensure that the techs have all the same length
struct Envelope{T, R}
    A
    B
    l
    d
    piecewise_iterator
    ids::Dict{Int64, Vector{T}} # map technologies to ids
    tech_dict::Dict{R, Int64} # map profit rates to ids
    reverse::Dict{Int64, Set{R}} # map ids to profit rates
    wages::Dict{R, Float64} # map to wages
    precision::Int64
    Envelope(; A, B, l, d, iterator, profit_rates, initial_tech, precision=6) = new{Int64, eltype(profit_rates)}(
        A,
        B,
        l,
        d,
        piecewise_iterator,
        product(1:n_countries, 1:n_goods)
        Dict(1 => initial_tech),
        Dict(profit_rates .=> 1),
        Dict(1 => Set(profit_rates))
        Dict(profit_rates .=> -Inf)
        precision
    )
end

# initial
initial_technology = collect(1:33)
profit_rates = 0:0.1:1
envelope = Envelope(profit_rates, initial_technology)

# Update the envelope with a new technology
function update_envelope(envelope, r, technology, w)
    old_id = envelope.tech_dict[r]
    new_id = findfirst(==(technology), envelope.ids)
    @assert old_id != new_id "You have to update with a different technology."
    println(new_id)
    if isnothing(new_id)
        new_id = length(envelope.ids) + 1
        envelope.ids[new_id] = technology
        envelope.reverse[new_id] = Set([r])
    end
    envelope.tech_dict[r] = new_id
    push!(envelope.reverse[new_id], r)
    # Remove the profit rate from the reverse dict
    println(old_id, new_id)
    pop!(envelope.reverse[old_id], r)
end

function try_piecewise_switches(envelope, r, l, d, w)
    for (country_tech, sector_tech) in piecewise_iterator
        w = compute_w(A, B, d, l, r)
        if w > envelope.wages[r]
            # set the new wage
            # set the new technology
            found_all = false
            break
        end
    end
end

function binary_search(envelope, start_r, end_r)
    # if tech transfer works: try behaviour in higher profit rates
    # als try behaviour in lower profit rates
    if try_start_tech(envelope, end_r)
        # compute_R(maximum.(real_eigvals.([A1, A2])))
        binary_search(envelope, r + 1/envelope.precision, end_r)
    # if it doesn't work: split in lower and upper half of the profit rates
    else
        r = ceil((start_r + end_r) / 2, digits=envelope.precision)
        try_piecewise_switches(envelope, end_r, l, d, w) # modify tech at end_r
        # if this is not working, mark as ready
        binary_search(envelope, start_r, r)
        binary_search(envelope, end_r, r + 1/envelope.precision)
    end
end
# after we finished, take the deepest level at r_* and start again from right to left with 0, r_*

update_envelope(envelope, 0.0, [1, 2], 1.0)

""" Compute the envelope for the book-of-blueprints A with the VFZ algorithm.

It might make sense to at least sometimes use the Sherman-Morrison formula to update the inverse.

This left-right stuff just means that we don't want to try out again all possibilities at the next higher/lower step but use the new best from above/below.
Left/right side are sufficient for induction since when they land on the envelope then we have piecewise switches guaranteed.
That is also the reason why numerical instability will not be a problem since the corners are checked piecewise.
The idea is that after left-to-right on the right we have better tech, therefore we go in the opposite direction.

My idea is to use something along the lines of binary search. We start with the lowest profit rate and then we try to find the best wage for piecewise switches.
Then we try this technology at the highest profit rate which maps to the same technology. If it doesn't work we try all possibilities there and then proceed to the profit rate in the middle.
For that we can again use Sherman-Morrison to update the inverse. This should also be numerically stable for strongly varying profit rates.
At the end we should check again at lowest and highest profit rate of one wage curve on the envelope for numerical instability and redo binary without Woodbury.

Bear in mind that the columns of A describe the technology of one sector.
Therefore all objects have permuted dimensions compared to the usual ``(1 + r)Ap + wl = p`` formula!!
"""
function compute_vfz(; A, B, l, d, R, step, verbose = false, save_all=true)
    # Number of goods
    n_goods = size(A, 1)
    # Number of countries
    n_countries = div(size(A, 2), n_goods)
    profit_rates = 0.0:step:R
    init_tech = A[:, 1:n_goods]

    envelope = Envelope(
        A=A,
        B=B,
        l=l,
        d=d,
        iterator=product(1:n_countries, 1:n_goods),
        profit_rates=profit_rates,
        initial_tech=init_tech
    )

    binary_search(envelope, 0.0, R)
    # get_highest_r(envelope, l, d, R)
    # test whether the Woodbury formula is stable; do this only at begin/start of tech choice
    test_at_corners(envelope, l, d, R)
end