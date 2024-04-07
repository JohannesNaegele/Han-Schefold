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
end

# hl_v = LatexHighlighter((data, i, j) -> (j == 3) && data[i, 3] > 9, ["color{blue}","textbf"]);
# pretty_table(can1990_deu1990_replication, backend = Val(:latex))
# Generate LaTeX table and format nicely