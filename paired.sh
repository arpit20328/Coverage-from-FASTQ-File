#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path_of_read_counts_with_paths_bases_coverage.txt> <path_of_paired_read_count_with_paths_bases_coverage.txt>"
    exit 1
fi

# Input and output file paths
input_file="$1"
output_file="$2"

# Temporary associative array to store combined coverage by path
declare -A coverage_map

# Read the input file line by line
while IFS=$'\t' read -r file_path read_count base_count coverage; do
    # Extract the path (ignoring the file part, e.g., R1 or R2)
    path=$(dirname "$file_path")
    
    # Convert coverage to numeric type (if needed) for summing
    coverage=$(echo $coverage | sed 's/[[:space:]]//g')

    # Add coverage to the map for that path
    if [[ -z "${coverage_map[$path]}" ]]; then
        coverage_map[$path]=$coverage
    else
        coverage_map[$path]=$(echo "${coverage_map[$path]} + $coverage" | bc)
    fi
done < "$input_file"

# Write the output to the new file
echo -e "Location\tAdded_Coverage" > "$output_file"
for path in "${!coverage_map[@]}"; do
    # Output the result in the format: path and combined coverage
    echo -e "$path\t${coverage_map[$path]}" >> "$output_file"
done

echo "Processing complete. Results saved to $output_file."
