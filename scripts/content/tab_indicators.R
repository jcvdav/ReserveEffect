######################
##  tab_indicators  ##
######################

###################################
# Create a table of indicators used
###################################

## Load packages
library(here)
library(knitr)
library(kableExtra)
library(tidyverse)

# Create a dataframe and export as tex table
data.frame(Indicator = c("Lobster density",
                         "Invertebrate density",
                         "Fish density",
                         "Fish biomass",
                         "Income from target species",
                         "Landings from target species"),
           Units = c("org $\\mathrm{m}^{-2}$",
                     "org $\\mathrm{m}^{-2}$",
                     "org $\\mathrm{m}^{-2}$",
                     "Kg $\\mathrm{m}^{-2}$",
                     "M MXP",
                     "Metric Tonnes")) %>% 
  knitr::kable(caption = "\\label{table:indicators}List of indicators used to evaluate the effectiveness of marine reserves, grouped by category.",
               format = "latex",
               escape = F) %>% 
  kable_styling(latex_options = "HOLD_position") %>% 
  group_rows(group_label = "Biological", start_row = 1, end_row = 4) %>% 
  group_rows(group_label = "Socioeconomic", start_row = 5, end_row = 6) %>% 
  cat(file = here("docs", "tab", "indicators.tex"))
