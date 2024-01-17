mica <- get_multimir(target = 'MICA',org = "hsa",table = "validated")

unique(mica@data$mature_mirna_id)


micb <- get_multimir(target = 'MICB',org = "hsa",table = "validated")

unique(micb@data$mature_mirna_id)



(
  syn_data <- tibble(x = 1:1000,
                     #y = rgamma(1000,shape = 1),
                     val1 = stringi::stri_rand_strings(1000,
                                                       length = 1,
                                                       pattern = "[A-E]"),
                     val2 = rbinom(n = 1000,size = 1,prob = .75)
                     )
  )

syn_data %>% 
  mutate(y = sin(x)) %>% 
  ggplot(aes(x = x, y = y, color = factor(val2))) +
  geom_point() +
  ggrepel::geom_label_repel(aes(label = val1))
  theme_bw()
