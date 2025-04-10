#!/bin/bash

# Set options
set -euo pipefail

# Run from the directory where this file is saved
cd "$(dirname "${BASH_SOURCE[0]}")"

# Read in variables
study_id="SRP255885"
run_id="SRR11518889"
fastq_r1="${run_id}_1.fastq.gz"
fastq_r2="${run_id}_2.fastq.gz"
fastq_url="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR115/089/${run_id}"
fastq_dest="../data/raw/fastq/SRP255885/${study_id}"

# Create raw file directory for FASTQs if it doesn't already exist
mkdir -p $fastq_dest

# Only download files if they don't exist
if [ ! -e "${fastq_dest}/${fastq_r1}" ]; then

    # Download files
    curl -O ${fastq_url}/${fastq_r1}
    # Move file to destination directiory
    mv $fastq_r1 $fastq_dest

fi

# Count lines in files
echo "The number of lines in SRR11518889_1.fastq.gz is:"

# decompress files and output into stdout
gunzip -c ${fastq_dest}/${fastq_r1} | wc -l

if [ ! -e "${fastq_dest}/${fastq_r2}" ]; then

    # Download files
    curl -O ${fastq_url}/${fastq_r2}

    # Move file to destination directory
    mv $fastq_r2 $fastq_dest

fi

echo "The number of lines in SRR11518889_2.fastq.gz is:"
gunzip -c ${fastq_dest}/SRR11518889_2.fastq.gz | wc -l
