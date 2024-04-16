""" Merge rows which have the same countries via the multicolumn package. """
function process_latex_table(df, country_column)
    # Generate the initial LaTeX table string
    latex_str = pretty_table(String, df, backend = Val(:latex))

    # Split the string into lines for processing
    lines = split(latex_str, '\n')

    # A dictionary to hold the number of occurrences of each country
    country_counts = countmap(df[!, country_column])

    # Process lines
    for (i, line) in enumerate(lines)
        for (country, count) in country_counts
            # Check if the line contains the country
            if occursin(country, line)
                if count > 1
                    # Replace the first occurrence with \multirow
                    line = replace(line, country => "\\multirow{$count}{*}{$country}")
                    country_counts[country] = 0  # Set count to 0 to avoid replacing again
                else
                    # Replace subsequent occurrences with empty space
                    line = replace(line, country => " ")
                end
                break  # Exit the inner loop after processing a country
            end
        end
        lines[i] = line  # Update the line
    end

    # Reconstruct the processed table
    join(lines, '\n')

    # hl_v = LatexHighlighter((data, i, j) -> (j == 3) && data[i, 3] > 9, ["color{blue}","textbf"]);
end

function format_simultaneous_results(results_simul)
    switches = [i[1].first for i in results_simul["switches"]["technology"]]
    switches = vcat(switches, results_simul["profit_rates"][end])
    switches = map(
        r -> results_simul["names"][r],
        filter(x -> x in switches, results_simul["profit_rates"])
    )
    tech = results_simul["labeled_technology"]
    
    hl_switch = LatexHighlighter(
        (data, i, j) -> (j < size(tech, 2) && (data[i, j] != data[i, j + 1])) || (j == size(tech, 2) && (data[i, j] != data[i, j - 1])) || (j > 1 && (data[i, j] != data[i, j - 1])),
        ["color{red}","textbf"]
    );
    return pretty_table(tech, header=switches, backend = Val(:latex), highlighters = hl_switch)
end