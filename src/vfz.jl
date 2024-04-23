struct Envelope{T}
    technologies::Set{Vector{T}}
    tech_dict::Dict{T, Vector{T}}
    reverse::Dict{Vector{T}, Set{T}}
    Envelope(tech_dict::Dict{T, Vector{T}}) where T = new{T}(
        Set(first(tech_dict).second), # get initial technology
        tech_dict, # get initial mapping
        Dict(v => Set(findall(==(v), tech_dict)) for (_, v) in tech_dict)
    )
end

# initial
envelope = Envelope{Float64}(Dict(r => initial_technology for r in profit_rates))

# update
function update_envelope(envelope, r, technology)
    old_technology = envelope.tech_dict[r]
    if technology in envelope.reverse
        push!(envelope.reverse[technology], r)
        # keep technology in reverse dict cause why not
        pop!(envelope.old_technology, r)
    else
        envelope.tech_dict[r] = technology
        push!(envelope.reverse, technology => Set([r]))
        # keep technology in reverse dict cause why not
        pop!(envelope.old_technology, r)
    end
end

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