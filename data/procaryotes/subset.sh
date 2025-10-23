#!/bin/bash

mkdir -p fastq_subset
rm -f fastq_subset/*
mkdir -p tmp

for f in fastq_files/*_R1_*.fastq.gz; do
    base=$(basename "$f" .fastq.gz)
    prefix=${base%%_R1_*}
    echo $prefix
    seqtk sample -s100 fastq_files/${prefix}_R1_001.fastq.gz 2000 | gzip > "fastq_subset/${prefix}_R1_001.fastq.gz"
    seqtk sample -s100 fastq_files/${prefix}_R2_001.fastq.gz 2000 | gzip > "fastq_subset/${prefix}_R2_001.fastq.gz"
    zcat fastq_subset/${prefix}_R1_001.fastq.gz | awk 'NR%4==1 {print substr($0,2)}'  > tmp/${prefix}_R1.txt
    zcat fastq_subset/${prefix}_R2_001.fastq.gz | awk 'NR%4==1 {print substr($0,2)}'  > tmp/${prefix}_R2.txt
done
