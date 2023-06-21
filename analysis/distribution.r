## data from IUCN
library(maptools)
library(magrittr)
library(rgdal)
library(raster)
library(sf)
library(foreign)
library(ggplot2)
setwd("D:/MAMMALS_TERRESTRIAL_ONLY")
sha <- raster::shapefile('Export_Output.shp')
sha <- sf::st_read("Export_Output.shp")
world <- map_data('world')
ggplot() +
  geom_map(
    data = world,
    map = world ,
    aes(long, lat, map_id = region),
    color = 'grey96',
    fill = 'grey96',
    linewidth = .1
  ) +
  geom_sf(data = sha, col = NA , aes(fill  =  sha$sci_name) ,alpha = .5) +
  theme(panel.background = element_rect(fill = 'white'),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank())+ ylim(-15,40)+xlim(-15,75)
