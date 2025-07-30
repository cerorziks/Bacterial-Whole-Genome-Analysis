#!/bin/bash

# Set path to assemblies
assembly_dir="/home/assembly_results"
# Set path to output BUSCO results
busco_output_dir="/home/busco_results"
# Set BUSCO lineage dataset
lineage_dataset="enterobacterales_odb10"
# Set mode to genome (other options: transcriptome, proteins)
mode="genome"
# Number of threads
threads=8

# Create output directory if it doesn't exist
mkdir -p "$busco_output_dir"

for sample_folder in "$assembly_dir"/*_spades; do
    # Check if contigs.fasta exists
    assembly_file="$sample_folder/contigs.fasta"
    if [ ! -f "$assembly_file" ]; then
        echo "No contigs.fasta found in $sample_folder, skipping..."
        continue
    fi

    # Get sample name from folder name
    sample_name=$(basename "$sample_folder" _spades)

    echo "Running BUSCO for $sample_name..."

    # Run BUSCO
    busco \
        -i "$assembly_file" \
        -o "${sample_name}_busco" \
        -m "$mode" \
        -l "$lineage_dataset" \
        -c "$threads" \
        --out_path "$busco_output_dir"

    echo "Finished BUSCO for $sample_name"
done

echo "All BUSCO analyses completed."
