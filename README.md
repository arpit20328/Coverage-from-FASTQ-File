# Coverage Calculator from FASTQ

Bash Script to find Reads, Bases, and Coverage from FASTQ files.

It works for both Illumina Short Read FASTQ or Pac-Bio or ONT Long Read FASTQ files.
Program takes by default fastq.gz format files.

## Usage

### For Single End Read FASTQ Files

To run the script, use the following command:

```bash
bash main.sh <input_directory_path> <output_directory_path> <Enter of region of interest bases>

### For Paired End Read FASTQ Files

After main.sh is run, and once you get <read_counts_with_paths_bases_coverage.txt> file, run the following script:

bash paired.sh <path of read_counts_with_paths_bases_coverage.txt> <path of paired_read_count_with_paths_bases_coverage.txt>

