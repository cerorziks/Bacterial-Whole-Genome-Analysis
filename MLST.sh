#!/bin/bash

# ==== CONFIGURATION ====
assembly_dir="/home/Shovill_assembly"
mlst_out_dir="/home/mlst_results"
mlst_db=""      
mlst_scheme=""
combined_csv="${mlst_out_dir}/mlst_all_results.csv"

# ========================
mkdir -p "${mlst_out_dir}"

# Header for combined CSV
echo "Sample,Scheme,ST,Alleles" > "${combined_csv}"

# Loop through all Shovill assemblies
for contigs in "${assembly_dir}"/*_shovill/contigs.fa; do
    if [ ! -f "${contigs}" ]; then
        echo "No contigs.fa in $(dirname "$contigs"), skipping."
        continue
    fi

    sample=$(basename "$(dirname "${contigs}")" _shovill)
    output_file="${mlst_out_dir}/${sample}_mlst.txt"

    echo "Running MLST for sample: ${sample}"

    # Build mlst command
    cmd="mlst"
    [ -n "${mlst_db}" ] && cmd+=" --datadir ${mlst_db}"
    [ -n "${mlst_scheme}" ] && cmd+=" --scheme ${mlst_scheme}"
    cmd+=" ${contigs}"

    # Run and save to individual and combined outputs
    result=$(${cmd})
    echo "${result}" > "${output_file}"

    # Append to combined CSV (convert tabs to commas)
    echo "${sample},$(echo "${result}" | cut -f2- | tr '\t' ',')" >> "${combined_csv}"

    echo "Finished MLST: ${sample}"
done

echo "All MLST analyses completed. Combined CSV: ${combined_csv}"
