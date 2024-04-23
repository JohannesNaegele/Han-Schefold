# TODO: ensure that the techs have all the same length
struct Envelope{T, R}
    ids::Dict{Int64, Vector{T}} # map technologies to ids
    tech_dict::Dict{R, Int64} # map profit rates to ids
    reverse::Dict{Int64, Set{R}} # map ids to profit rates
    Envelope(profit_rates, initial_tech) = new{Int64, eltype(profit_rates)}(
        Dict(1 => initial_tech),
        Dict(profit_rates .=> 1),
        Dict(1 => Set(profit_rates))
        # Dict(v => Set(findall(==(v), tech_dict)) for (_, v) in tech_dict)
    )
end

# initial
initial_technology = collect(1:33)
profit_rates = 0:0.1:1
envelope = Envelope(profit_rates, initial_technology)

# Update the envelope with a new technology
function update_envelope(envelope, r, technology)
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

update_envelope(envelope, 0.0, [1, 2])

""" Compute the envelope for the book-of-blueprints A with the VFZ algorithm.

It might make sense to at least sometimes use the Sherman-Morrison formula to update the inverse.

Bear in mind that the columns of A describe the technology of one sector.
Therefore all objects have permuted dimensions compared to the usual ``(1 + r)Ap + wl = p`` formula!!
"""
function compute_vfz(; A, B, l, d, R, step, verbose = false, save_all=true)
    wages = zeros(length(profit_rates))
    tech_dict = zeros(size(A, 2), length(profit_rates))

    found_all = false
    while !found_all
        for r in 0:step:R
            w = compute_w(A, B, d, l, r)
            if w < 0
                found_all = false
                d = d + 0.01
                break
            end
        end
        found_all = true
    end
end