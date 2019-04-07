##################
##    fig_map   ##
##################

######################################################
# Creates a map of the study area. The approximate
# figure caption is: Location of the three coastal
# communities studied (A). Isla Natividad (B) is
# located off the Baja California Peninsula, Maria
# Elena and Punta Herrero (C) are located in the
# Yucatan Peninsula. Blue polygons represent the TURFs,
# and red polygons the marine reserves.
######################################################

# Load packages
library(tmap) #To load the WORLD dataset
library(sf)
library(ggsn)
library(ggrepel)
library(cowplot)
library(here)
library(tidyverse)


######## DATA ##############

# Determine a projection for the maps
proj <- "+proj=longlat +datum=NAD27"

# Load coastline for Mexico and World
data(World)
World <- st_transform(World, proj)

# Load high-res mexican coastline
coastline_mx <- readRDS(here("raw_data", "spatial", "coastline_mx.rds"))

# Load ZRP shapefile
zrp <- st_read(dsn = here("raw_data", "spatial"), layer = "ZRP", quiet = T) %>% 
  filter(Name %in% c("El Cabezo",
                     "Gallineros",
                     "Punta Loria",
                     "San Roman Norte",
                     "San Roman Sur",
                     "Anegado de Chal",
                     "Laguna Canche Balam",
                     "Niluc",
                     "Mimis",
                     "El Faro (Pesca de Langosta)",
                     "El Faro")) %>%
  st_transform(crs = proj) %>%
  mutate(evaluated = ifelse(Name %in% c("El Cabezo",
                                        "El Faro (Pesca de Langosta)",
                                        "El Faro"), T, F),
         Comunidad = ifelse(Name %in% c("El Faro",
                                        "Laguna Canche Balam",
                                        "El Faro (Pesca de Langosta)",
                                        "Anegado de Chal"),
                            "Punta Herrero",
                            "Maria Elena"))

# Load Community reserve shapefile
rescom <- st_read(dsn = here("raw_data", "spatial"), layer = "Res_Com", quiet = T) %>% 
  filter(Nombre %in% c("La_Plana", "PuntaPrieta")) %>% 
  st_transform(crs = proj)

# Load TURF shapefile
turf <- st_read(dsn = here("raw_data", "spatial"), layer = "turfs", quiet = T) %>% 
  filter(Coop %in% c("SCPP Buzos y Pescadores de la Baja California",
                     "SCPP Cozumel",
                     "SCPP Jose Maria Azcorra"))


######### PLOTING ###########


# Define reference map ##############################
## Declare points for reference map
location_labels <- data.frame(X = c(-115.24, -87.4611756),
                              Y = c(27.85, 19),
                              Location = c("Isla Natividad", "Punta Herrero"),
                              Region = c("Pacific", "Caribbean"),
                              stringsAsFactors = F)

## Create map
mex <- ggplot() +
  geom_sf(data = World) +
  geom_point(data = location_labels,
             aes(x = X, y = Y),
             color = "black",
             fill = "steelblue",
             size = 3,
             shape = 21) +
  theme_classic() +
  scale_color_brewer(palette = "Set1") +
  scale_fill_brewer(palette = "Set1") +
  theme(legend.position = "none",
        panel.grid.major = element_line(colour = "transparent"),
        axis.text = element_text(size = 7)) +
  lims(x = c(-118.36648, -86.71074), y = c(14.53507, 32.71863)) +
  annotate(geom = "text", x = -102, y = 25, label = "Mexico") +
  annotate(geom = "text", x = -90, y = 25, label = "Gulf of\nMexico") +
  annotate(geom = "text", x = -112, y = 20, label = "Pacific\nOcean") +
  annotate(geom = "text", x = -116.4, y = 27.5, label = "B") +
  annotate(geom = "text", x = -86.8, y = 18.2, label = "C") +
  labs(x = "", y = "")

# Map for SAM ##############################################
## Declare points for SAM
sam_points <- data.frame(x = c(-87.4646745, -87.539104),
                         y = c(19.3229767, 19.396729),
                         location = c("Punta Herrero", "Maria Elena"))

## Create map
ph <- ggplot() +
  geom_sf(data = turf[c(1,3),], fill = "steelblue", alpha = 0.5, size = 1, color = "black") +
  geom_sf(data = coastline_mx) +
  lims(x = c(-87.7, -87.35), y = c(19.15, 19.6)) +
  geom_sf(data = zrp, fill = "red2") +
  theme_classic() +
  theme(panel.grid.major = element_line(colour = "transparent"),
        axis.text = element_text(size = 7)) +
  geom_label_repel(data = sam_points,
                   aes(x = x, y = y, label = location),
                   nudge_x = c(0.1, -0.05),
                   nudge_y = c(-0.05, 0.06)) +
  labs(x = "", y = "") +
  ggsn::scalebar(data = turf[c(1:3),1],
                 dist = 5,
                 dd2km = T,
                 model = 'WGS84',
                 location = "bottomright",
                 st.size = 2,
                 st.dist = 0.05,
                 height = 0.1) +
  scale_x_continuous(breaks = seq(-87.7, -87.3, 0.1), limits = c(-87.7, -87.3))

# Map for PBC #################################################
pbc <- ggplot() +
  geom_sf(data = turf[4,], fill = "steelblue", alpha = 0.5, size = 1, color = "black") +
  lims(x = c(-115.65, -115.109), y = c(27.7, 28)) +
  geom_sf(data = coastline_mx) +
  geom_sf(data = rescom, fill = "red2") +
  theme_classic() +
  theme(panel.grid.major = element_line(colour = "transparent"),
        axis.text = element_text(size = 7)) +
  labs(x = "", y = "") +
  scalebar(data = turf[c(1:4),1], dist = 10, dd2km = T, model = 'WGS84', location = "bottomleft", st.size = 2, st.dist = 0.05, height = 0.1)

left <- plot_grid(mex, pbc, ncol = 1, labels = "AUTO")

plot1 <- plot_grid(left, ph, labels = c("", "C"), ncol = 2)

# Save map
ggsave(plot1,
       filename = here("docs", "img", "fig_map.pdf"),
       width = 6.5,
       height = 4.5)

ggsave(plot1,
       filename = here("docs", "img", "fig_map.tiff"),
       width = 6.5,
       height = 4.5)
