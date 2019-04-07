#########################
##  fig_bio_results    ##
#########################

####################################################
# Fit the ecological models and create a termplot
####################################################



## Load packages
library(cowplot)
library(here)
library(tidyverse)

## Load custom functions
# Load indicator functions
source(file = here("scripts", "functions", "abundance.R")) #Calculate abundance per transect
source(file = here("scripts", "functions", "biomass.R")) # Calculate fish biomass per transect

# Load analysis functions
source(file = here("scripts", "functions", "model.R")) #fits the model
source(file = here("scripts", "functions", "robust_se.R")) #calculates heteroskedastic-robust Standard Errors
# source(file = here("scripts", "robust_se_list.R")) #heteroskedastic-robust Standard Errors for stargazer
source(file = here("scripts", "functions", "plot_model.R")) #plots effect sizes for Bio
# source(file = here("scripts", "plot_socioeco.R")) #plots effect sizes for Socioeco

# Load data
# # Invertebrate data
invert <- read.csv(file = here("data", "invertebrates.csv"),
                   stringsAsFactors = F)
# Fish data
fish <- read.csv(file = here("data", "fish.csv"),
                 stringsAsFactors = F)

###### Analyses ######################################################
# Invertebrates ###################################
## Lobsters
### Natividad
L_IN <- invert %>% 
  spread(generoespecie, abundancia, fill = 0) %>% 
  gather(generoespecie,
         abundancia,
         -c("comunidad", "ano", "year", "rc", "sitio", "zona", "transecto")) %>%
  filter(generoespecie == "Panulirus interruptus") %>% 
  abundance(com = "Isla Natividad") %>% 
  model(sfe = F, spfe = F)
### Maria Elena
L_ME <- invert %>% 
  spread(generoespecie, abundancia, fill = 0) %>% 
  gather(generoespecie,
         abundancia,
         -c("comunidad", "ano", "year", "rc", "sitio", "zona", "transecto")) %>% 
  filter(generoespecie == "Panulirus argus") %>% 
  abundance(com = "Maria Elena") %>% 
  model(sfe = F, spfe = F)
### Punta Herrero
L_PH <- invert %>% 
  spread(generoespecie, abundancia, fill = 0) %>% 
  gather(generoespecie,
         abundancia,
         -c("comunidad", "ano", "year", "rc", "sitio", "zona", "transecto")) %>% 
  filter(generoespecie == "Panulirus argus") %>% 
  abundance(com = "Punta Herrero") %>% 
  model(sfe = F, spfe = F)

## Abundance
### Natividad
Ni_IN <- invert %>% 
  abundance(com = "Isla Natividad") %>% 
  model(sfe = F, spfe = F)
### Maria Elena
Ni_ME <- invert %>% 
  abundance(com = "Maria Elena") %>% 
  model(sfe = F, spfe = F)
### Punta Herrero
Ni_PH <- invert %>% 
  abundance(com = "Punta Herrero") %>% 
  model(sfe = F, spfe = F)

# Fish ##################################################
## Biomass
### Isla Natividad
B_IN <- fish %>% 
  biomass(com = "Isla Natividad") %>% 
  model(sfe = F, spfe = F)
### Maria Elena
B_ME <- fish %>% 
  biomass(com = "Maria Elena") %>% 
  model(sfe = F, spfe = F)
### Punta Herrero
B_PH <- fish %>% 
  biomass(com = "Punta Herrero") %>% 
  model(sfe = F, spfe = F)

## Abundance
N_IN <- fish %>% 
  abundance(com = "Isla Natividad") %>% 
  model(sfe = F, spfe = F)

N_ME <- fish %>% 
  abundance(com = "Maria Elena") %>% 
  model(sfe = F, spfe = F)

N_PH <- fish %>% 
  abundance(com = "Punta Herrero") %>% 
  model(sfe = F, spfe = F)

# Ploting #########################################################################
# Invert plots ##################################################
## Lobsters
L_plot <- plot_model(model = list(L_IN, L_ME, L_PH),
                     model_names = c("IS", "ME", "PH"))

## Abundance
I_N <- plot_model(model = list(Ni_IN, Ni_ME, Ni_PH),
                  model_names = c("IN", "ME", "PH"))

# Fish plots ####################################################
## Biomass
F_B <- plot_model(model = list(B_IN, B_ME, B_PH),
                  model_names = c("IS", "ME", "PH"))

## Abundance
F_N <- plot_model(model = list(N_IN, N_ME, N_PH),
                  model_names = c("IN", "ME", "PH")) +
  theme(legend.justification = c(1, 0.1),
        legend.position = c(1, 0),
        legend.text = element_text(size = 8),
        legend.title = element_text(size = 8),
        legend.direction = "horizontal")

# Combine plots
plot <- cowplot::plot_grid(plotlist = list(L_plot, F_B, I_N, F_N),
                            labels = "AUTO",
                            ncol = 2)

# Export figure
ggsave(plot = plot,
       filename = here("docs", "img", "fig_bio_results.pdf"),
       width = 6.5,
       height = 4)

# Export figure
ggsave(plot = plot,
       filename = here("docs", "img", "fig_bio_results.tiff"),
       width = 6.5,
       height = 4)

# Save all model output
save(L_IN,
     L_ME,
     L_PH,
     B_IN,
     B_ME,
     B_PH,
     Ni_IN,
     Ni_ME,
     Ni_PH,
     N_IN,
     N_ME,
     N_PH,
     file = here("data", "results", "bio_results.RData"))




