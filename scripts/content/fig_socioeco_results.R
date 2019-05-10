###############################
##  fig_socioeco_results    ##
##############################

####################################################
# Fit the socioeconomic models and create a termplot
####################################################

## Load packages
library(kableExtra)
library(broom)
library(cowplot)
library(here)
library(tidyverse)

## Load custom functions
source(file = here("scripts", "functions", "robust_se.R")) #calculates heteroskedastic-robust Standard Errors
source(file = here("scripts", "functions", "plot_socioeco.R")) #plots effect sizes for Socioeco

# Load data
conapesca <- read.csv(file = here("data", "conapesca.csv"),
                      stringsAsFactors = F) %>% 
  mutate(years_centered = as.factor(years_centered),
         year = fct_relevel(years_centered, "0"),
         peso_vivo = peso_vivo/1e3,
         valor = valor/1e6,
         loc = zona,
         zona = ifelse(grupo == "Treated", "Reserva", "Control"),
         grupo = loc)

# Fit models
C_IN <- conapesca %>% 
  filter(comunidad == "Isla Natividad" | is.na(comunidad)) %>% 
  filter(grupo == "PN") %>%
  lm(peso_vivo ~ zona * year, data = .)

C_ME <- conapesca %>% 
  filter(comunidad == "Maria Elena" | is.na(comunidad)) %>% 
  filter(grupo == "MC") %>%
  lm(peso_vivo ~ zona * year, data = .)

V_IN <- conapesca %>% 
  filter(comunidad == "Isla Natividad" | is.na(comunidad)) %>% 
  filter(grupo == "PN") %>%
  lm(valor ~ zona * year, data = .)

V_ME <- conapesca %>% 
  filter(comunidad == "Maria Elena" | is.na(comunidad)) %>% 
  filter(grupo == "MC") %>%
  lm(valor ~ zona * year, data = .)

# Plot terms
c_plot <- plot_socioeco(model_list = list(C_IN, C_ME),
                        model_names = list("IN", "ME"),
                        ylab = quo(lambda[t])) +
  theme(legend.justification = c(0, 0),
        legend.position = c(0, 0.55),
        legend.title = element_blank()) +
  ggtitle("Lobster catches")

v_plot <- plot_socioeco(model_list = list(V_IN, V_ME),
                        model_names = list("IN", "ME"),
                        ylab = quo(lambda[t])) +
  theme(legend.position = "none") +
  ggtitle("Revenues from lobster catches")

plot <- plot_grid(c_plot,
                  v_plot,
                  ncol = 1)

# Export figures
ggsave(plot = plot,
       filename = here("docs", "img", "fig_socioeco_results.pdf"),
       width = 6,
       height = 4.4)

ggsave(plot = plot,
       filename = here("docs", "img", "fig_socioeco_results.tiff"),
       width = 6,
       height = 4.4)

# Save the models
save(C_IN,
     C_ME,
     V_IN,
     V_ME,
     file = here("data", "results", "socioeco_results.RData"))
