#!/bin/bash

mkdir -p fastq_subset
rm -f fastq_subset/*

for f in fastq_files/*.fastq.gz; do
    base=$(basename "$f" .fastq.gz)
    seqtk sample -s100 "$f" 2000 | gzip > "fastq_subset/${base}.fastq.gz"
done
