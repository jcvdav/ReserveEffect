library(sf)
library(ggplot2)

coast <- rnaturalearth::ne_countries(continent = "north america", returnclass = "sf", scale = "medium")

zrp <- st_read(dsn = here::here("raw_data", "spatial"), layer = "ZRP", quiet = T) %>% 
  st_centroid()

rescom <- st_read(dsn = here::here("raw_data", "spatial"), layer = "Res_Com", quiet = T) %>% 
  st_centroid()

zrp_this <- st_read(dsn = here::here("raw_data", "spatial"), layer = "ZRP", quiet = T) %>% 
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
  head(1) %>% 
  st_centroid()

rescom_this <- st_read(dsn = here::here("raw_data", "spatial"), layer = "Res_Com", quiet = T) %>% 
  filter(Nombre %in% c("La_Plana", "PuntaPrieta")) %>% 
  head(1) %>% 
  st_centroid()


map <- ggplot() +
  geom_sf(data = coast, fill = "grey50", color = "black", size = 0.1) +
  geom_sf(data = zrp, fill = "red", color = "black", shape = 21, size = 2) +
  geom_sf(data = rescom, fill = "red", color = "black", shape = 21, size = 2) +
  geom_sf(data = zrp_this, fill = "steelblue", color = "black", shape = 21, size = 2) +
  geom_sf(data = rescom_this, fill = "steelblue", color = "black", shape = 21, size = 2) +
  annotate(geom = "text", x = -102, y = 25, label = "Mexico") +
  annotate(geom = "text", x = -90, y = 25, label = "Gulf of\nMexico") +
  annotate(geom = "text", x = -112, y = 15, label = "Pacific\nOcean") +
  lims(x = c(-120, -80), y = c(10, 35)) +
  theme(panel.grid.major = element_line(color = "transparent")) +
  labs(x = "", y = "")

ggsave(plot = map, filename = "figures/map.png", width = 6, height = 4, dpi = 600)  
