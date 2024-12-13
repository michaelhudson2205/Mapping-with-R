# Packages used
library(ozmaps)
library(sf)
library(dplyr)
library(viridis)
library(ggrepel)
library(ggthemes)
library(rio)
library(gt)
library(geojsonsf)
library(RColorBrewer)

my_geo <- geojson_sf("wnswphn_simple.geojson")

sf_oz <- ozmaps::ozmap("states")
my_nsw <- sf_oz[1,]


ggplot(data = my_geo) +
  geom_sf(data = my_nsw) +
  geom_sf(data = my_geo, fill = "lightblue")

indigenous_prop <- c(6.39, 7.24, 5.78, 17.84, 30.26, 51.4, 9.96, 5.03, 36.52, 14.26, 33.95, 8.85, 16.57, 13.26, 14.46, 18.35, 6.81, 20.44, 4.66, 7.65, 13.14, 3.54, 21.19, 15.37, 10.68, 4.68, 8.35)

my_geo$a_prop <- indigenous_prop

ggplot(data = my_geo) +
  geom_sf(data = my_nsw) +
  geom_sf(data = my_geo, aes(fill = a_prop)) +
  scale_fill_distiller(palette = "Oranges", 
                       direction = 1, 
                       name = "% LGA Population") +
  ggtitle("Western NSW PHN", "Aboriginal Population as Proportion of LGA") +
  theme(legend.key.width = unit(2, "cm"),
        legend.key.height = unit(1, "cm"))
