library(tidyverse)
library(stringi)

set.seed(42)

\# Tue Feb 20 14:52:15 2024 ------------------------------

rand_mirna <-
  stri_rand_strings(n=1000,length = 22,pattern = "[AUGC]")

names_rand_mirna <-
  paste0("rand_mirna_",1:1000)

tibble(rand_mirna,names_rand_mirna) %>% 
  mutate(seq = glue::glue(">{names_rand_mirna}\n{rand_mirna}")) %>% 
  pull(seq) %>% 
  write_lines(file = "rand_mirs.seq")
