def read_patterns_from_file(pattern_file):
    """
    Read patterns from a text file and return as a list.
    """
    patterns = []
    with open(pattern_file, 'r') as file:
        for line in file:
            patterns.append(line.strip())
    return patterns

def filter_fasta(input_fasta, output_fasta, patterns):
    """
    Filter sequences from the input FASTA file based on the given patterns
    and write the filtered sequences to the output FASTA file.
    """
    with open(input_fasta, 'r') as infile, open(output_fasta, 'w') as outfile:
        write_sequence = False
        for line in infile:
            if line.startswith('>'):
                header = line.strip()
                write_sequence = any(pattern in header for pattern in patterns)
            if write_sequence:
                outfile.write(line)

if __name__ == "__main__":
    # Paths to input and output files
    input_fasta_file = "Data/mature.fa"
    output_fasta_file = "output.fasta"
    pattern_file = "Data/mirs_amanda.txt"

    # Read patterns from the pattern file
    patterns = read_patterns_from_file(pattern_file)

    # Filter the FASTA file based on patterns and write to output
    filter_fasta(input_fasta_file, output_fasta_file, patterns)

    print("Filtered sequences have been written to", output_fasta_file)
