############################
##    supp_information    ##
############################

####################################################
# Fit the ecological models and create a termplot
####################################################



## Load packages
library(here)
library(magrittr)
library(tidyverse)

# Load data
invert <- read.csv(file = here("data", "invertebrates.csv"),
                   stringsAsFactors = F) %>% 
  mutate(zona = ifelse(zona == "Reserva", "Reserve", zona))

fish <- read.csv(file = here("data", "fish.csv"),
                 stringsAsFactors = F) %>% 
  mutate(zona = ifelse(zona == "Reserva", "Reserve", zona))

conapesca <- read.csv(file = here("data", "conapesca.csv"),
                      stringsAsFactors = F) %>% 
  mutate(zona = ifelse(zona == "Reserva", "Reserve", zona))

# Table of sampling effort for invertebrates
invert %>% 
  group_by(ano, comunidad, zona, sitio, transecto) %>%
  count() %>% 
  ungroup() %>% 
  group_by(comunidad, zona) %>%
  count() %>% 
  ungroup() %>% 
  spread(zona, nn) %>% 
  mutate(age = c(10, 4, 4)) %>% 
  knitr::kable(col.names = c("Community", "Control", "Reserve", "Years of monitoring"),
               booktabs = T,
               format = "latex",
               caption = "{\\bf Invertebrate sampling effort.} Number of invertebrate transects performed in each site of each community.") %>% 
  cat(file = here("docs", "tab", "S1_table.tex"))

# Time series of lobster densities. Bars indicate standard errors
lobster_ts_plot <- invert %>%
  mutate(generoespecie = ifelse(
    generoespecie %in% c("Panulirus interruptus",
                         "Panulirus argus"),
    generoespecie,
    "any_invert")) %>% 
  group_by(rc, ano, year, comunidad, sitio, zona, transecto, generoespecie) %>% 
  summarize(abundancia = sum(abundancia)) %>% 
  spread(generoespecie, abundancia, fill = 0) %>% 
  gather(generoespecie, abundancia, -c(rc, ano, year, comunidad, sitio, zona, transecto)) %>% 
  filter(generoespecie %in% c("Panulirus interruptus","Panulirus argus")) %>% 
  group_by(rc, ano, year, comunidad, sitio, zona, transecto, generoespecie) %>% 
  summarize(indicador = sum(abundancia)/60) %>%
  ungroup() %>% 
  mutate(year = as.numeric(year)) %>% 
  ggplot(aes(x = year, y = indicador, color = zona)) +
  stat_summary(geom = "errorbar", fun.data = mean_se, width = 0.1, size = 1) +
  stat_summary(geom = "line", fun.y = mean) +
  stat_summary(geom = "point", fun.y = mean, size = 2) +
  theme_minimal() +
  facet_wrap(~comunidad, scales = "free", ncol = 2) +
  scale_color_brewer(palette = "Set1", direction = -1) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  ylab(bquote("Density (org m"^{-2}~")")) +
  xlab("Year since implementation") +
  theme(legend.justification = c(0,0),
        legend.position = c(0.5, 0.15)) +
  guides(color = guide_legend(title = "Zone"))

#Save plot
ggsave(plot = lobster_ts_plot,
       file = here("docs", "img", "S1_fig.pdf"),
       width = 6,
       height = 4.5)

ggsave(plot = lobster_ts_plot,
       file = here("docs", "img", "S1_fig.tiff"),
       width = 6,
       height = 4.5)


# Time series of invertebrate densities. Bars indicate standard errors
invert_ts_plot <- invert %>%
  filter(abundancia > 0) %>%
  group_by(rc, ano, year, comunidad, sitio, zona, transecto) %>% 
  summarize(indicador = sum(abundancia)/60) %>%
  ungroup() %>% 
  mutate(year = as.numeric(year)) %>% 
  ggplot(aes(x = year, y = indicador, color = zona)) +
  stat_summary(geom = "errorbar", fun.data = mean_se, width = 0.1, size = 1) +
  stat_summary(geom = "line", fun.y = mean) +
  stat_summary(geom = "point", fun.y = mean, size = 2) +
  theme_minimal() +
  facet_wrap(~comunidad, scales = "free", ncol = 2) +
  scale_color_brewer(palette = "Set1", direction = -1) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  ylab(bquote("Density (org m"^{-2}~")")) +
  xlab("Year since implementation") +
  theme(legend.justification = c(0,0),
        legend.position = c(0.5, 0.15)) +
  guides(color = guide_legend(title = "Zone"))

#Save plot
ggsave(plot = invert_ts_plot,
       file = here("docs", "img", "S2_fig.pdf"),
       width = 6,
       height = 4.5)

ggsave(plot = invert_ts_plot,
       file = here("docs", "img", "S2_fig.tiff"),
       width = 6,
       height = 4.5)


# Table of sampling effort for fish
fish %>% 
  group_by(ano, comunidad, zona, sitio, transecto) %>%
  count() %>% 
  ungroup() %>% 
  group_by(comunidad, zona) %>%
  count() %>% 
  ungroup() %>% 
  spread(zona, nn) %>% 
  mutate(age = c(10, 4, 4)) %>% 
  knitr::kable(col.names = c("Community", "Control", "Reserve", "Years of monitoring"),
               booktabs = T,
               format = "latex",
               caption = "{\\bf Fish sampling effort.} Number of invertebrate transects performed in each site of each community.") %>% 
  cat(file = here("docs", "tab", "S2_table.tex"))

#Time series of fish biomass. Bars indicate standard errors
fish_biomass_ts_plot <- fish %>%
  filter(abundancia > 0) %>% 
  group_by(rc, ano, year, comunidad, sitio, zona, transecto, generoespecie, talla, a, b) %>% 
  summarize(abundancia = sum(abundancia)) %>% 
  ungroup() %>% 
  mutate(year = as.numeric(year),
         biomass = abundancia * ((a * (talla^b))/1000))  %>% 
  group_by(rc, ano, year, comunidad, sitio, zona, transecto) %>% 
  summarize(biomass = sum(biomass)) %>% 
  ggplot(aes(x = year, y = biomass, color = zona)) +
  stat_summary(geom = "errorbar", fun.data = mean_se, width = 0.1, size = 1) +
  stat_summary(geom = "line", fun.y = mean) +
  stat_summary(geom = "point", fun.y = mean, size = 2) +
  theme_minimal() +
  facet_wrap(~comunidad, scales = "free", ncol = 2) +
  scale_color_brewer(palette = "Set1", direction = -1) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  ylab(bquote("Biomass (Kg m"^{-2}~")")) +
  xlab("Year since implementation") +
  theme(legend.justification = c(0,0),
        legend.position = c(0.5, 0.15)) +
  guides(color = guide_legend(title = "Zone"))

#Save plot
ggsave(plot = fish_biomass_ts_plot,
       file = here("docs", "img", "S3_fig.pdf"),
       width = 6,
       height = 4.5)

ggsave(plot = fish_biomass_ts_plot,
       file = here("docs", "img", "S3_fig.tiff"),
       width = 6,
       height = 4.5)


#Time series of fish densities. Bars indicate standard errors
fish_density_ts_plot <- fish %>%
  group_by(rc, ano, year, comunidad, sitio, zona, transecto) %>% 
  summarize(indicador = sum(abundancia)/60) %>%
  ungroup() %>% 
  mutate(year = as.numeric(year)) %>% 
  ggplot(aes(x = year, y = indicador, color = zona)) +
  stat_summary(geom = "errorbar", fun.data = mean_se, width = 0.1, size = 1) +
  stat_summary(geom = "line", fun.y = mean) +
  stat_summary(geom = "point", fun.y = mean, size = 2) +
  theme_minimal() +
  facet_wrap(~comunidad, scales = "free", ncol = 2) +
  scale_color_brewer(palette = "Set1", direction = -1) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  ylab(bquote("Density (org m"^{-2}~")")) +
  xlab("Year since implementation") +
  theme(legend.justification = c(0,0),
        legend.position = c(0.5, 0.15)) +
  guides(color = guide_legend(title = "Zone"))

#Save plot
ggsave(plot = fish_density_ts_plot,
       file = here("docs", "img", "S4_fig.pdf"),
       width = 6,
       height = 4.5)

ggsave(plot = fish_density_ts_plot,
       file = here("docs", "img", "S4_fig.tiff"),
       width = 6,
       height = 4.5)

# BACI of socioeconomic data
conapesca %>% 
  filter(!unidad_economica == "jose maria azcorra") %>% 
  mutate(price = valor / peso_vivo) %>% 
  group_by(zona, grupo, post, unidad_economica) %>% 
  summarize(price = mean(price, na.rm = T)) %>% 
  ungroup() %>% 
  spread(post, price) %>% 
  mutate(zona = ifelse(zona == "MC", "Yucatan Peninsula", "Baja California"),
         unidad_economica = taxize::taxize_capwords(unidad_economica)) %>% 
  knitr::kable(digits = 2,
               col.names = c("Community", "Group", "TURF", "Before", "After"),
               booktabs = T,
               format = "latex") %>% 
  cat(file = here("docs", "tab", "S3_table.tex"))

#Time series of landings and value of landings
peso <- conapesca %>% 
  filter(!unidad_economica == "jose maria azcorra") %>% 
  mutate(zona = ifelse(zona == "MC", "Yucatan Peninsula", "Baja California")) %>% 
  ggplot(aes(x = years_centered, y = peso_vivo / 1000, color = grupo)) +
  facet_wrap(~ zona, ncol = 2, scales = "free_y")  +
  stat_summary(geom = "errorbar", fun.data = mean_se, width = 0.1, size = 1) +
  stat_summary(geom = "line", fun.y = mean) +
  stat_summary(geom = "point", fun.y = mean, size = 2) +
  theme_minimal() +
  scale_color_brewer(palette = "Set1", direction = -1) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  ylab("Landings (Tones)") +
  xlab("Year since implementation") +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = "dashed", size = 1)

valor <- conapesca %>% 
  filter(!unidad_economica == "jose maria azcorra") %>% 
  mutate(zona = ifelse(zona == "MC", "Yucatan Peninsula", "Baja California")) %>% 
  ggplot(aes(x = years_centered, y = valor / 1000, color = grupo)) +
  facet_wrap(~ zona, ncol = 2, scales = "free_y")  +
  stat_summary(geom = "errorbar", fun.data = mean_se, width = 0.1, size = 1) +
  stat_summary(geom = "line", fun.y = mean) +
  stat_summary(geom = "point", fun.y = mean, size = 2) +
  theme_minimal() +
  scale_color_brewer(palette = "Set1", direction = -1) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  ylab("Value (K MXP)") +
  xlab("") +
  guides(color = guide_legend(title = "", ncol = 2)) +
  theme(legend.justification = c(0,0),
        legend.position = c(0.55, 0.7)) +
  geom_vline(xintercept = 0, linetype = "dashed", size = 1)

socioeco_ts_plot <- cowplot::plot_grid(peso, valor, ncol = 1, labels = "AUTO")

#Save plot
ggsave(plot = socioeco_ts_plot,
       file = here("docs", "img", "S5_fig.pdf"),
       width = 6,
       height = 4.5)

ggsave(plot = socioeco_ts_plot,
       file = here("docs", "img", "S5_fig.tiff"),
       width = 6,
       height = 4.5)


# Load models
load(here("data", "results", "bio_results.RData"))
load(here("data", "results", "socioeco_results.RData"))



# Create a function to get standard stargazer tables
supp_regtable <- function(models, caption = "", fs = "small", bio = T, filename){
  
  labels <- c(
    "Lobster density",
    "Fish biomass",
    "Invertebrate density",
    "Fish density")
  
  if(!bio){
    labels <- c("Landings",
                "Revenues")
  }
  
  stargazer::stargazer(models,
                       omit = c("generoespecie", "unidad"),
                       se = commarobust::makerobustseslist(models, type = "HC1"),
                       t.auto = T,
                       p.auto = T,
                       column.labels = labels,
                       dep.var.labels = "",
                       single.row = T,
                       omit.stat = c("f", "adj.rsq"),
                       title = caption,
                       header = F,
                       font.size = fs,
                       column.sep.width = "1pt",
                       out = filename,
                       type = "latex")
}


# Isla Natividad Bio
list(L_IN, B_IN, Ni_IN, N_IN) %>% 
  supp_regtable(caption = "Coefficient estimates of biological indicators for Isla Natividad.",
                filename = here("docs", "tab", "S4_table.tex"))
# Maria Elena Bio
list(L_ME, B_ME, Ni_ME, N_ME) %>% 
  supp_regtable(caption = "Coefficient estimates of biological indicators for Maria Elena.",
                filename = here("docs", "tab", "S5_table.tex"))
# Punta Herrero Bio
list(L_PH, B_PH, Ni_PH, N_PH) %>% 
  supp_regtable(caption = "Coefficient estimates of biological indicators for Punta Herrero.",
                filename = here("docs", "tab", "S6_table.tex"))

# Socioeco Natividad
list(C_IN, V_IN) %>% 
  supp_regtable(caption = "Coefficient estimates of socioeconomic indicators Isla Natividad.",
                bio = F,
                filename = here("docs", "tab", "S7_table.tex"))
# Socioeco Maria Elena
list(C_ME, V_ME) %>% 
  supp_regtable(caption = "Coefficient estimates of socioeconomic indicators for Maria Elena.",
                bio = F,
                filename = here("docs", "tab", "S8_table.tex"))

