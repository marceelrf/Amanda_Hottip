library(tidyverse)
dados_acid <- readr::read_csv(file = "DadosAcid/anovinha.csv")

dados_acid %>% 
  group_by(trial, year) %>%  
  select(brand_name, treatments, sev) %>% 
  mutate(treatments = factor(treatments)) %>% 
  nest() %>% 
  mutate(anova = map(data, ~aov(sev~brand_name + treatments,
                                data= .x))) %>% 
  mutate(anova_tidy = map(anova, broom::tidy)) %>% 
  unnest(anova_tidy) %>% 
  select(1,2,6) %>% 
  rename("study" = 1, "year" = 2, "v_sev" = 3)
