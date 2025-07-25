#!/bin/bash

# Set input and output directories
INPUT_DIR="/home/path/fastq"
OUTPUT_DIR="/home/path/fastq/fastp_out"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop through all R1 files
for R1 in "$INPUT_DIR"/*_R1_001.fastq.gz; do
    # Get the matching R2 file
    R2="${R1/_R1_/_R2_}"

    # Extract sample name (e.g., DAM-021_S9 from full path)
    SAMPLE=$(basename "$R1" | cut -d'_' -f1,2)

    echo "Processing sample: $SAMPLE"

    fastp \
        -i "$R1" \
        -I "$R2" \
        -o "$OUTPUT_DIR/${SAMPLE}_clean_R1.fastq.gz" \
        -O "$OUTPUT_DIR/${SAMPLE}_clean_R2.fastq.gz" \
        -h "$OUTPUT_DIR/${SAMPLE}_fastp.html" \
        -j "$OUTPUT_DIR/${SAMPLE}_fastp.json" \
        --detect_adapter_for_pe \
        --thread 4
done
