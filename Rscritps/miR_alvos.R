library(tidyverse)
library(multiMiR)

miR_pmp <- c("Hsa-miR-7-5p","Hsa-miR-361-3p","Hsa-miR-361-5p","Hsa-miR-128",
             "Hsa-miR-149-3p","Hsa-miR-195-5p","Hsa-miR-424-5p","Hsa-miR-30e-3p",
             "Hsa-miR-34a-5p","Hsa-miR-181b-5p","Hsa-miR-940","Hsa-miR-4665-3p",
             "Hsa-miR-33b-3p","Hsa-miR-4433-3p","Hsa-miR-3162-3p","Hsa-miR-365a-3p",
             "Hsa-miR-1260a","Hsa-miR-1587","Hsa-miR-6515-3p","Hsa-miR-4286")
(
miR_pmp <- unique(tolower(miR_pmp))
)

target1 <- multiMiR::get_multimir(org = "hsa",
                                  mirna = miR_pmp,
                                  table = "validated")

target1@data %>% 
  select(mature_mirna_id,target_symbol) %>% 
  distinct()


unique(target1@data$target_symbol)
