#!/bin/bash

# Define the input files
consensus_file="Data/HOTTIP_consensus.fasta"
mir_seqs_file="Data/mir_seq.fasta"

# Check if the consensus file exists
if [ ! -f "$consensus_file" ]; then
    echo "Consensus FASTA file not found: $consensus_file"
    exit 1
fi

# Check if the miRs sequences file exists
if [ ! -f "$mir_seqs_file" ]; then
    echo "MiRs sequences FASTA file not found: $mir_seqs_file"
    exit 1
fi

# Extract the consensus sequence
consensus_header=$(head -n 1 "$consensus_file")
consensus_seq=$(tail -n +2 "$consensus_file" | tr -d '\n')

# Check if the consensus sequence is not empty
if [ -z "$consensus_seq" ]; then
    echo "Consensus sequence is empty in $consensus_file"
    exit 1
fi

# Loop through each sequence in the miRs file
while IFS= read -r line; do
    if [[ $line == ">"* ]]; then
        # If it's a header line, extract the sequence ID
        seq_id=$(echo "$line")
        # Extract the sequence
        seq=$(grep -A 1 "$seq_id" "$mir_seqs_file" | tail -n 1 | tr -d '\n')
        # Check if the sequence is not empty
        if [ -n "$seq" ]; then
            # Write the header and sequences to a .seq file
            echo "$consensus_header" > "${seq_id:1}.seq"
            echo "$consensus_seq" >> "${seq_id:1}.seq"
            echo "$seq" >> "${seq_id:1}.seq"
            echo "Created ${seq_id:1}.seq"
        else
            echo "Sequence not found for $seq_id"
        fi
    fi
done < "$mir_seqs_file"