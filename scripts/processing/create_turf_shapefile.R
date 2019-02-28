# Mon Apr 23 19:41:00 2018 ------------------------------

# Create an sf_object with TURF polygons

## For Isla Natividad
# Polygon vertices from http://www.dof.gob.mx/nota_detalle.php?codigo=4692631&fecha=14/10/1992

library(tidyverse)
library(sf)

# Create vectors of latitudes and longitudes
lat <- c(
  27.96666667,
  27.96666667,
  27.89638889,
  27.72083333,
  27.795,
  27.96666667
)

lon <- c(
  -115.1019444,
  -115.4,
  -115.6311111,
  -115.2777778,
  -115.1255556,
  -115.1019444
)

# Transform vectors into a simple feature
pol <- cbind(lon, lat) %>% 
  list() %>% 
  st_polygon() %>% 
  st_sfc(crs = "+proj=longlat +datum=NAD27")

# Create a dataframe with the above as simple feature
dat <- data.frame(Coop = "SCPP Buzos y Pescadores de la Baja California", stringsAsFactors = F)
st_geometry(dat) <- pol

## For the Caribbean ones

# Caribbean TURFs were supplied by Stuart Fulton
# Read them in and append the Isla Natividad Polygon
# We also reproject and calculate the area

turf <- st_read(dsn = here::here("raw_data", "spatial"), layer = "ConcessionesQRoo") %>% 
  st_cast(to = "POLYGON") %>% 
  st_transform(crs = "+proj=longlat +datum=NAD27") %>% 
  select(Coop = Cooperativ) %>% 
  rbind(dat) %>% 
  mutate(Area = as.numeric(st_area(.))/1000)

# Visualize to inspect
ggplot() +
  geom_sf(data = turf, fill = "red")

# Export shapefiles
st_write(turf, dsn = here::here("raw_data", "spatial", "turfs.shp"), delete_dsn = T)
















