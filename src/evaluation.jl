""" Return total number of switches over all countries. """
function multicountry_n_switches(results_pairs)
    switches = 0
    total_comparisons = 0
    for (_, val1) in results_pairs
        for (_, val2) in val1
            total_comparisons += 1
            switches += n_switches(val2)
        end
    end
    println("There are $total_comparisons pairwise comparisons.")
    return switches
end

""" Return total number of reswitches over all countries. """
function multicountry_reswitches(results_pairs)
    num = 0
    for (country1, val1) in results_pairs
        for (country2, val2) in val1
            reswitches = n_reswitches(val2)
            num += length(reswitches)
            map(
                r -> println(
                    "Reswitching in: ", "$country1", "/", "$country2",
                    ", r = $r"
                ),
                reswitches
            )
        end
    end
    return num
end

function multicountry_switch_cases(results_pairs)
    κ_down_labour_up = κ_down_labour_down = κ_up_labour_up = κ_up_labour_down = 0
    sum_of_multiple_switches = 0
    temp = [
        sum_of_multiple_switches,
        κ_down_labour_up,
        κ_down_labour_down,
        κ_up_labour_up,
        κ_up_labour_down
    ]
    for (_, val1) in results_pairs
        for (_, val2) in val1
            temp .+= switch_cases(val2)
        end
    end
    return temp
end

function multicountry_info(results)
   # Replication number of switches
   num_switches = multicountry_n_switches(results)
   println("Number of switches: ", num_switches)

   # Replication number of reswitches
   println("Number of reswitches: ", multicountry_reswitches(results))

   # Replication intensity cases
   found_cases = multicountry_switch_cases(results)
   println("There have been $(found_cases[1]) instances of switches that are not piecemeal.")
   cases_perc = round.(found_cases ./ num_switches .* 100, digits = 2)
   println("Capital intensity-reducing, labour-increasing: $(found_cases[2]) cases ($(cases_perc[2])%)")
   println("Capital intensity-reducing, labour-reducing: $(found_cases[3]) cases ($(cases_perc[3])%)")
   println("Capital intensity-increasing, labour-increasing: $(found_cases[4]) cases ($(cases_perc[4])%)")
   println("Capital intensity-increasing, labour-reducing: $(found_cases[5]) cases ($(cases_perc[5])%)")
end

""" Print the relevant replication results for a pair of countries. """
function replicate_intensities(results_pairs, country1, country2, filter_cond)
    # Construct the key for accessing results
    result_key = country1 * "/" * country2
    println("Replicate $(result_key):")

    # Access results for the specified country pair
    country_results = results_pairs[country1][country2]

    # Filtering columns based on profit rates
    filtered_cols = map(
        r -> country_results["names"][r],
        filter(filter_cond, country_results["profit_rates"])
    )

    # Constructing the replication data
    replication_data = country_results["intensities"][
        !, ["Country"; "Sector"; filtered_cols]
    ]

    # Pretty print the table
    println(replication_data)
    return replication_data
end

""" Print the relevant replication results for a pair of countries. """
function replicate_trunc(results_pairs, country1, country2, r)
    # Construct the key for accessing results
    result_key = country1 * "/" * country2
    println("Replicate $(result_key):")

    # Access results for the specified country pair
    country_results = results_pairs[country1][country2]

    # Filtering columns based on profit rates
    filter_cond = x -> x == r
    filtered_col = findfirst(
        filter_cond ∘ (x -> x[1].first), country_results["switches"]["capital_intensities"])

    # Constructing the replication data
    cap = country_results["switches"]["capital_intensities"][filtered_col]
    pA = country_results["switches"]["pA"][filtered_col]
    lx = country_results["switches"]["lx"][filtered_col]
    r₁ = country_results["names"][pA[1].first]
    r₂ = country_results["names"][pA[2].first]
    prices = country_results["switches"]["prices"][filtered_col]
    q = country_results["switches"]["intensities"][filtered_col]

    replication_data = DataFrame(
        hcat(
            [lx[1].second; "pAq/lq, r=" * r₁; cap[1].second; fill(missing, 30)],
            pA[1].second,
            pA[2].second,
            [lx[2].second; "pAq/lq, r=" * r₂; cap[2].second; fill(missing, 30)],
            prices.second,
            q[1].second,
            q[2].second
        ),
        vcat(
            "lq, r=" * r₁,
            "pA, r=" * r₁,
            "pA, r=" * r₂,
            "lq, r=" * r₂,
            "p, r=" * r₁,
            "q, r=" * r₁,
            "q, r=" * r₂
        )
    )
    println(replication_data)
    return replication_data
end