# Load required packages
library(ggplot2)
library(dplyr)
library(reshape2)
library(RColorBrewer)

# Read temperature data
temp_data <- read.csv("temperature_data.csv")

# Melt data into long format
temp_melt <- melt(temp_data, id.vars = c("lat", "lon"), variable.name = "month", value.name = "temperature")

# Create a custom color palette
my_palette <- brewer.pal(9, "YlOrRd")

# Plot the data
ggplot(temp_melt, aes(x = lon, y = lat, z = temperature)) +
  stat_contour(geom = "polygon", aes(fill = ..level..)) +
  scale_fill_gradientn(colors = my_palette) +
  coord_equal() +
  labs(title = "Temperature Contour Map",
       x = "Longitude",
       y = "Latitude",
       fill = "Temperature (Celsius)") +
  theme_bw()
