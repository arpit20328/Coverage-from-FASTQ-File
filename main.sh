#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_directory> <output_directory>"
    exit 1
fi

# Define the input and output directories
INPUT_DIR="$1"
OUTPUT_DIR="$2"

# Create the output directory if it does not exist
mkdir -p "$OUTPUT_DIR"

# Output file
OUTPUT_FILE="$OUTPUT_DIR/read_counts_with_paths_bases_coverage.txt"

# Initialize the output file
echo -e "File_Path\tRead_Count\tBase_Count\tCoverage" > $OUTPUT_FILE

# Prompt the user to enter their region of interest bases
read -p "Enter your region of interest bases: " ROI_BASES

# Check if the ROI_BASES is a valid number
if ! [[ "$ROI_BASES" =~ ^[0-9]+$ ]]; then
    echo "Error: Region of interest bases must be a number."
    exit 1
fi

# Loop through all fastq files in the directory and its subdirectories
find "$INPUT_DIR" -type f \( -name "*.fastq.gz" -o -name "*.fastq" \) | while read -r file; do
    # Check if the file is a .fastq file and compress it to .fastq.gz
    if [[ "$file" == *.fastq ]]; then
        pigz -p 128 "$file"
        file="$file.gz" # Update the file path to the new .fastq.gz file
    fi

    # Count the number of reads (each read is represented by 4 lines in fastq format)
    count=$(zcat "$file" | wc -l)
    reads=$((count / 4))

    # Calculate the number of bases by summing the lengths of sequence lines
    bases=$(zcat "$file" | awk 'NR % 4 == 2 {total += length($0)} END {print total}')

    # Calculate coverage (bases divided by user-defined region of interest bases)
    coverage=$(awk "BEGIN {printf \"%.6f\", $bases / $ROI_BASES}")


    # Write the full file path, read count, base count, and coverage to the output file
    echo -e "$file\t$reads\t$bases\t$coverage" >> $OUTPUT_FILE
done

echo "Read counts, base counts, and coverage with file paths have been saved to $OUTPUT_FILE."
