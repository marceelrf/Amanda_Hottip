while IFS= read -r line; do

RNAup -b < $line
done < dup_files.txt