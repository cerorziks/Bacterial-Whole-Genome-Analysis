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
| Genome assembly  | Shovill       | Shovill is a pipeline which uses SPAdes at its core, but alters the steps before and after the primary assembly step to get similar results in less time |
| Assembly QC      | QUAST & BUSCO | Evaluate assembly metrics and completeness  |
| Annotation       | Prokka        |Prokka is a software tool to annotate bacterial, archaeal and viral genomes quickly and produce standards-compliant output files. |
| Sequence Typing  | MLST          | Scan contig files against traditional PubMLST typing schemes |
| AMR and Virulence Typing       | ABRicate      | Mass screening of contigs for antimicrobial resistance or virulence genes. |
| AMR Typing       | abritamR      | abriTAMR is an AMR gene detection pipeline |

---

## Requirements

Make sure the following tools are installed and accessible in your `$PATH`:

- [fastp](https://github.com/OpenGene/fastp)
- [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)
- [SPAdes](http://cab.spbu.ru/software/spades/)
- [Shovill](https://github.com/tseemann/shovill)
- [QUAST](http://quast.sourceforge.net/)
- [BUSCO](https://busco.ezlab.org/)
- [Prokka](https://github.com/tseemann/prokka)
- [MLST](https://github.com/tseemann/mlst)
- [ABRicate ](https://github.com/tseemann/abricate)
- [abritamR ](https://github.com/MDU-PHL/abritamr)


Additional dependencies:
- Java (for Trimmomatic)
- Python 3 (for BUSCO)
- Appropriate BUSCO lineage datasets downloaded (e.g., `bacteria_odb10`)
  
---

## Steps Summary

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




