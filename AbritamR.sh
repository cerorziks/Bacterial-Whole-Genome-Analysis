#!/bin/bash
set -euo pipefail

# Directories
ASSEMBLY_DIR="/home/path/Shovill_assembly"
OUTPUT_DIR="/home/path/ABRITAMR_results"
mkdir -p "$OUTPUT_DIR"

# Parameters for abritamr
JOBS=4
IDENTITY=0.9
SPECIES="Escherichia" # Select based on the species

# Logging function
log() {
  echo "[INFO] $*"
}

shopt -s nullglob
contig_files=("$ASSEMBLY_DIR"/*_shovill/contigs.fa)

if [[ ${#contig_files[@]} -eq 0 ]]; then
  echo "[ERROR] No contigs.fa files found in $ASSEMBLY_DIR/*_shovill/"
  exit 1
fi

for contig in "${contig_files[@]}"; do
  sample_dir=$(dirname "$contig")
  sample_name=$(basename "$sample_dir")

  if [[ ! -f "$contig" ]]; then
    echo "[WARN] contigs.fa not found in $sample_dir — skipping."
    continue
  fi

  # Compose prefix as full output path + sample name
  prefix="${OUTPUT_DIR}/${sample_name}_abritamr"

  log "Running abritamr for sample: $sample_name (species=$SPECIES)"

  abritamr run \
    --contigs "$contig" \
    --prefix "$prefix" \
    --species "$SPECIES" \
    --jobs "$JOBS" \
    --identity "$IDENTITY"

  log "Finished abritamr run for sample: $sample_name"
done

log "All abritamr processing complete."
