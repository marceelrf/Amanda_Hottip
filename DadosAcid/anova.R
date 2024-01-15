#BAIXANDO OS PACOTIN
library(tidyverse)
library(metafor)
library(ggthemes)
library(cowplot)
library(scales)
library(broom)
library(dplyr)
library(readxl)
library(gsheet)
library(janitor)

#LENDO O ARQUIVO, escreve como voce quer o arquivo "leafspot"
leafspot <- read.csv("anovinha.csv")


#separando os dados 
leafspot %>%
  group_by(trial)

#checando as paradas de comprimento
length(unique(leafspot$trial))
glimpse(leafspot)
str(leafspot)
leafspot <- leafspot %>%
  mutate(sev = as.numeric(sev))
#sumarizando dados de media 
leafspot1<- leafspot %>%
  group_by(trial, year, location, state, n_spray, brand_name) %>% 
  summarise(mean_sev = mean(sev),
            mean_yield = mean(yield))
## o passo que da merda
leafspot_sev <- leafspot %>%
  group_by(trial, year) %>%
  select(brand_name, treatments, sev) %>%
  group_by(trial, year) %>%
  do(tidy(aov(sev~brand_name + factor(.$treatments)))) %>%
  filter(term == "Residuals") %>% 
  select(1,2,6) %>% 
  set_names(c("study", "year", "v_sev"))

str(leafspot)





##usando os dados do mano
rust <- gsheet2tbl("https://docs.google.com/spreadsheets/d/1Xx_gK6ERLLhQGIrOPB_ZYs9LoHTmsv030s30Dc_TPzg/edit#gid=287066174", sheetid = "2015-2020")
rust %>% 
  group_by(study)
length(unique(rust$study))
rust1 <- rust %>% 
  group_by(study, year, location, state, n_spray, brand_name) %>% 
  summarise(mean_sev = mean(sev),
            mean_yld = mean(yld))

rust_sev <- rust %>% 
  group_by(study, year) %>%  
  select(brand_name, rep, sev) %>%
  filter(!is.na(sev)) %>%  # Remover linhas com valores NA em 'sev'
  mutate(rep = as.numeric(rep)) %>%  # Converter níveis de 'rep' para numéricos
  group_by(study, year) %>% 
  do(tidy(aov(sev ~ brand_name + factor(rep)))) %>% 
  filter(term == "Residuals") %>% 
  select(1, 2, 6) %>% 
  set_names(c("study", "year", "v_sev"))
