

# Plot Australia Map and then show the points of interest
# on the charts

# Packages used
library(ozmaps)
library(sf)
library(dplyr)
library(viridis)
library(ggrepel)
library(ggthemes)
library(rio)
library(gt)

# Get the States data for Australia

sf_oz <- ozmaps::ozmap("states")

my_nsw <- sf_oz[1,]
ggplot(data = my_nsw) + geom_sf()
lga_sf <- ozmap_data("abs_lga")
wnswphn_subset <- c(1, 21, 38, 43, 47, 51, 77, 89, 92, 120, 170, 171, 188, 233, 236, 250, 302, 310, 313, 328, 345, 352, 378, 427, 428, 435, 495)
wnswphn <- lga_sf[wnswphn_subset,]
ggplot(data = wnswphn) + geom_sf()

# Load the Practices data
myPractices <- import("Practices_subset.csv")
str(myPractices)
gt(myPractices)

ggplot() +
  geom_sf(data = my_nsw) +
  geom_sf(data = wnswphn) +
  geom_point(data = myPractices,
             aes(x = Longitude, y = Latitude),
             alpha = 0.5)

# Draw map of Australia
pl <- ggplot(data = sf_oz)
pl <- pl + geom_sf()
pl

# Colour each state in different colours using
# the variable NAME in the sf_oz dataset
pl <- ggplot(data = sf_oz)
pl <- pl + geom_sf(aes(fill = NAME), colour = "white")
pl

# Use theme
pl <- pl + theme_map()
pl

# Remove legend
pl <- pl + theme(legend.position = "none")
pl

# Add labels for each State
pl <- pl + geom_label_repel(aes(label = NAME, geometry = geometry),
                            stat = "sf_coordinates",
                            box.padding = 0.5,
                            max.overlaps = Inf,
                            size = 4)
pl

# Provide different fill colours
pl <- pl + scale_fill_viridis(discrete = TRUE)
pl



# Using the myPractices data plot the practice locations
pl <- pl + geom_point(data = myPractices,
                      aes(x = Longitude, y = Latitude),
                      alpha = 0.5)
pl
