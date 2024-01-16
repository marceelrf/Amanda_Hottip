mica <- get_multimir(target = 'MICA',org = "hsa",table = "validated")

unique(mica@data$mature_mirna_id)


micb <- get_multimir(target = 'MICB',org = "hsa",table = "validated")

unique(micb@data$mature_mirna_id)
