# Whole Genome Sequencing (WGS) Analysis Pipeline for Bacterial Isolates

This repository contains a modular bash pipeline for processing paired-end Illumina WGS data from bacterial isolates. The pipeline includes:

- Quality control (QC) of raw reads using **fastp**
- Adapter and quality trimming with **Trimmomatic**
- De novo genome assembly using **SPAdes**
- Assembly quality assessment using **QUAST** and **BUSCO**

---

## Pipeline Overview

| Step             | Tool          | Description                                 |
|------------------|---------------|---------------------------------------------|
| Raw read QC      | fastp         | Filter and generate QC reports on raw reads |
| Read trimming    | Trimmomatic   | Remove adapters and low-quality bases       |
| Genome assembly  | SPAdes        | Assemble trimmed reads into contigs/scaffolds (using `--isolate` mode) |
| Assembly QC      | QUAST & BUSCO | Evaluate assembly metrics and completeness  |

---

## Requirements

Make sure the following tools are installed and accessible in your `$PATH`:

- [fastp](https://github.com/OpenGene/fastp)
- [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)
- [SPAdes](http://cab.spbu.ru/software/spades/)
- [QUAST](http://quast.sourceforge.net/)
- [BUSCO](https://busco.ezlab.org/)

Additional dependencies:
- Java (for Trimmomatic)
- Python 3 (for BUSCO)
- Appropriate BUSCO lineage datasets downloaded (e.g., `bacteria_odb10`)

---

---

## Usage

1. **Prepare your raw reads** in the `raw_reads/` directory, named as `<sample>_R1.fastq.gz` and `<sample>_R2.fastq.gz`.

2. **Configure parameters** in the main script (`run_pipeline.sh`), including input/output directories and number of threads.

3. **Run the pipeline**:

    ```bash
    bash scripts/run_pipeline.sh
    ```

4. Outputs will be organized by step in their respective directories (`qc_reports/`, `trimmed_reads/`, `assemblies/`, etc.).

---

## Pipeline Steps Summary

### 1. Quality Control with fastp

- Performs initial QC on raw reads.
- Generates HTML and JSON reports.

### 2. Trimming with Trimmomatic

- Removes Illumina adapters and low-quality bases.
- Outputs trimmed paired and unpaired reads.

### 3. Assembly with SPAdes

- Uses trimmed paired-end reads.
- Runs in `--isolate` mode for bacterial genomes.
- Outputs assemblies in FASTA format.

### 4. Assembly QC with QUAST and BUSCO

- QUAST provides assembly statistics (N50, contig count, GC content).
- BUSCO estimates genome completeness based on single-copy orthologs.

---




