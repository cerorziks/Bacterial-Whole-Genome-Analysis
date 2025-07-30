#!/bin/bash
set -euo pipefail

# Directories
ASSEMBLY_DIR="/home/path/WGS/Shovill_assembly"
ABRICATE_OUTDIR="/home/path/ABRICATE_results"
mkdir -p "$ABRICATE_OUTDIR"

# Choose ABRicate database
ABRICATE_DB="ncbi"  # You can also use resfinder, card, etc.

# Check ABRicate and database availability
abricate --check > /dev/null
if ! abricate --list | awk '{print $1}' | grep -qw "$ABRICATE_DB"; then
  echo "[ERROR] ABRicate database '$ABRICATE_DB' not found. Run: abricate --setupdb"
  exit 1
fi

echo "[INFO] Using ABRicate database: $ABRICATE_DB"

# Collect contig files
shopt -s nullglob
contig_files=("$ASSEMBLY_DIR"/*_shovill/contigs.fa)

if [[ ${#contig_files[@]} -eq 0 ]]; then
  echo "[ERROR] No contigs.fa files found."
  exit 1
fi

# Run abricate per sample
abricate_tab_files=()
for contig in "${contig_files[@]}"; do
  sample_dir=$(dirname "$contig")
  sample_name=$(basename "$sample_dir")
  out_file="${ABRICATE_OUTDIR}/${sample_name}_${ABRICATE_DB}.tab"
  abricate --db "$ABRICATE_DB" "$contig" > "$out_file"
  abricate_tab_files+=("$out_file")
  echo "[INFO] ABRicate completed for $sample_name"
done

# Combine using abricate --summary
SUMMARY_FILE="${ABRICATE_OUTDIR}/abricate_summary_${ABRICATE_DB}.tsv"
abricate --summary "${abricate_tab_files[@]}" > "$SUMMARY_FILE"
echo "[INFO] ABRicate summary written to $SUMMARY_FILE"
