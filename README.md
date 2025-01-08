# Coverage_from_FASTQ
Bash Script to find Reads, Bases and Coverage from FASTQ file 

# It works for both Illumina Short Read FASTQ or Pac-Bio or ONT Long Read FASTQ files 

## Usage

For Single end read FASTQ files 
To run the script, use the following command:

```bash
bash main.sh <input_directory path> <output_directory path> <bases_in_your_region_of_interest>

If your data is paried end, then run paired.sh after you have run main.sh

```bash
bash paired.sh <path of your read_counts_with_paths_bases_coverage.txt> <path of your reguired output file with its name>

