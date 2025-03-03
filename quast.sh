#!/bin/bash


mkdir QC_ASSEMBLY
quast.py -o QC_ASSEMBLY -R genomes/reference_genome_file.fasta sample_name_SPADES_OUT/scaffolds.fasta sample_name.polished.fasta
