#!/bin/bash

# Define input and output directories
input_dir="/home/path/trimmed_fastq"  # Path to trimmed FastQ files
output_dir="/home/path/spades_output"  # Desired output directory for SPAdes results

# Create output directory if it doesn't exist
mkdir -p ${output_dir}

# Check if the input files exist
if [ ! -d "${input_dir}" ]; then
    echo "Input directory not found: ${input_dir}"
    exit 1
fi

# Loop through all _R1_001.fastq.gz files in the input directory and process each pair
for r1 in ${input_dir}/*_R1_trimmed.fastq.gz; do
    # Get corresponding R2 file
    r2="${r1/_R1_001.fastq.gz/_R2_trimmed.fastq.gz}"

    # Check if corresponding R2 file exists
    if [ ! -f "${r2}" ]; then
        echo "Warning: Corresponding R2 file not found for ${r1}. Skipping."
        continue
    fi

    # Extract sample base name
    base=$(basename ${r1} _R1_trimmed.fastq.gz)

    echo "Running SPAdes on: ${base}"

    # Run SPAdes with paired-end reads and advanced options
    spades.py --pe1-1 ${r1} --pe1-2 ${r2} \
              --careful \
              --checkpoints all \
              -o ${output_dir}/${base}_spades \
              --threads 8

done

echo "SPAdes assembly completed for all samples."
