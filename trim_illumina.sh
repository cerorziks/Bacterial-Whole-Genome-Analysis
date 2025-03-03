#!/bin/bash

# Define input and output directories
input_dir="/raw_fastq_file_path/raw_fastq"    # Change AS PER THE FILE PATH
output_dir="/output_file_path/trimmed_fastq"  # Change AS PER THE FILE PATH

# Adapter sequences file (Replace with actual adapter file path)
adapter_file="/filepath/NexteraPE-PE.fa" 

# Create output directory if it doesn't exist
mkdir -p ${output_dir}

# Loop through all _R1_001.fastq.gz files and extract the sample name
for file in ${input_dir}/*_R1_001.fastq.gz; do  # Change raw read names
    base=$(basename ${file} _R1_001.fastq.gz)  # Extract sample prefix

    echo "Processing sample: ${base}"

    trimmomatic PE -threads 8 -phred33 \
    ${input_dir}/${base}_R1_001.fastq.gz ${input_dir}/${base}_R2_001.fastq.gz \
    ${output_dir}/${base}_R1_trimmed.fastq.gz ${output_dir}/${base}_R1_unpaired.fastq.gz \
    ${output_dir}/${base}_R2_trimmed.fastq.gz ${output_dir}/${base}_R2_unpaired.fastq.gz \
    ILLUMINACLIP:${adapter_file}:2:30:10 \
    LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:36
done

echo "Trimming completed for all samples."
