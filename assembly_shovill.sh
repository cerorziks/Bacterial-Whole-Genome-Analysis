#!/bin/bash

# Define input and output directories
input_dir="/home/genomic/WGS/fastq/trimmed"
output_dir="/home/genomic/WGS/Shovill_assembly"

# Create output directory if it doesn't exist
mkdir -p "${output_dir}"

# Loop through all R1 trimmed files
for r1 in "${input_dir}"/*_R1_trimmed.fastq.gz; do
    # Extract sample name by removing _R1_trimmed.fastq.gz
    base=$(basename "${r1}" _R1_trimmed.fastq.gz)

    # Define matching R2 file
    r2="${input_dir}/${base}_R2_trimmed.fastq.gz"

    # Check if R2 file exists
    if [ ! -f "${r2}" ]; then
        echo "Skipping ${base}: R2 pair not found."
        continue
    fi

    echo "Running Shovill for sample: ${base}"

    # Set output directory for current sample
    sample_out="${output_dir}/${base}_shovill"

    # Run Shovill with paired-end reads
    shovill \
        --R1 "${r1}" \
        --R2 "${r2}" \
        --outdir "${sample_out}" \
        --cpus 8

    echo "Finished: ${base}"
done

echo "All Shovill assemblies completed."
