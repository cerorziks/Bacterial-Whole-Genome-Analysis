#!/bin/bash

# Set the base directory where your assemblies are
assembly_dir="/home/path/Shovill_assembly"
output_dir="/home/path/Prokka_results"

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Loop through all *_shovill directories and find contigs.fa
for contigs in "${assembly_dir}"/*_shovill/contigs.fa; do
    if [ ! -f "$contigs" ]; then
        echo "No contigs.fa found in $(dirname "$contigs"), skipping."
        continue
    fi

    # Extract sample name from path
    sample=$(basename "$(dirname "$contigs")")
    
    # Define output directory for Prokka results
    prokka_outdir="${output_dir}/${sample}_prokka"
    
    # Check if Prokka output directory already exists
    if [ -d "$prokka_outdir" ]; then
        echo "Prokka output directory for $sample already exists, skipping."
        continue
    fi

    # Run Prokka with minimal and default parameters
    echo "Running Prokka on $sample..."
    prokka \
        --outdir "$prokka_outdir" \
        --prefix "$sample" \
        --cpus 8 \
        "$contigs"
done

echo "Prokka annotation completed."
