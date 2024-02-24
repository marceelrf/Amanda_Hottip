HOTTIP <- seqinr::read.fasta(file = "Data/HOTTIP_consensus.fasta",
                   as.string = T,seqtype = "DNA")

HOTTIP_consensus <- toupper(HOTTIP$HOTTIP_consensus)

HOTTIP_consensus <- gsub(pattern = "T",replacement = "U",x = HOTTIP_consensus)


mirs <- seqinr::read.fasta(file = "Data/mir_seq.fasta",
                           as.string = T,seqtype = "DNA")

seq_tmp <- NULL
for(i in seq_along(mirs)) {
  
  mirs_seq <- toupper(mirs[[i]][1])
  mirs_name <- names(mirs[i])
  
  filename <- glue::glue("Duplex_files/{mirs_name}_dup.seq")
  
  seq_tmp <- (glue::glue(">HOTTIP_consensus\n{HOTTIP_consensus}\n>{mirs_name}\n{mirs_seq}"))
  
  readr::write_lines(x = seq_tmp,file = filename)
}
