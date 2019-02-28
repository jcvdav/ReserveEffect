###############
##  tab_ses  ##
###############

######################################
# Create a table with our SES analysis
######################################

## Load packages
library(here)
library(knitr)
library(kableExtra)
library(tidyverse)

# Read data and create table as tex file
read.csv(here::here("raw_data", "ses.csv")) %>% 
  select(-Dim) %>% 
  knitr::kable(caption = "\\label{table:ses}Variables for the Social-Ecological System analysis (IN = Isla Natividad, ME = Maria Elena, PH = Punta Herrero). Alphanumeric codes follow \\cite{basurto_2013-oq}; an asterisk (*) denotes variables incorporated based on \\cite{difranco_2016-Xw} and \\cite{edgar_2014-UO}. The presented narrative applies equally for all communities unless otherwise noted.",
               format = "latex",
               escape = F) %>% 
  kable_styling(latex_options = c("HOLD_position", "scale_down")) %>% 
  column_spec(column = 1, width = "6.5cm") %>% 
  column_spec(column = 2, width = "12.2cm") %>% 
  group_rows(group_label = "Resource System (RS)", start_row = 1, end_row = 5) %>% 
  group_rows(group_label = "Resource Unit (RU)", start_row = 6, end_row = 7) %>% 
  group_rows(group_label = "Actors (A)", start_row = 8, end_row = 9) %>% 
  group_rows(group_label = "Governance system (G)", start_row = 10, end_row = 13) %>% 
  cat(file = here("docs", "tab","ses.tex"))
