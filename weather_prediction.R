library(tidyverse)
library(leaflet)
library(ggmap)
library(openair)

# Read the timeseries data
temp_data <- read_csv("temperature_data.csv")
hum_data <- read_csv("humidity_data.csv")
rain_data <- read_csv("rainfall_data.csv")
wind_data <- read_csv("wind_data.csv")

# Merge the data into a single dataframe
weather_data <- temp_data %>%
  left_join(hum_data, by = c("Date", "Time")) %>%
  left_join(rain_data, by = c("Date", "Time")) %>%
  left_join(wind_data, by = c("Date", "Time"))

# Convert the data to a time series object
weather_ts <- weather_data %>%
  select(Date, Time, Temperature, Humidity, Rainfall, Wind_Speed) %>%
  mutate(DateTime = as.POSIXct(paste(Date, Time))) %>%
  select(DateTime, Temperature, Humidity, Rainfall, Wind_Speed) %>%
  as_ts()

# Make a weather prediction map
base_map <- get_map(location = "your_location", zoom = 10, maptype = "terrain")

wind_map <- windRose(weather_ts, pollutant = "Wind_Speed")

weather_map <- ggmap(base_map) +
  geom_point(data = weather_data, aes(x = Longitude, y = Latitude, color = Temperature), size = 2) +
  scale_color_gradient(low = "blue", high = "red") +
  windRoseMap(wind_map, x = -77.01, y = 38.90, r = 0.05, n = 12, col = "black") +
  ggtitle("Weather Prediction Map")

leaflet() %>%
  addTiles() %>%
  addMarkers(data = weather_data, ~Longitude, ~Latitude, popup = paste("Temperature:", Temperature, "Humidity:", Humidity, "Rainfall:", Rainfall, "Wind Speed:", Wind_Speed)) %>%
  addLegend("bottomright", colors = c("blue", "red"), labels = c("Low", "High"), title = "Temperature", opacity = 1) %>%
  addLegend("bottomleft", title = "Wind Direction and Speed", layerId = "wind", pal = windRosePal(n = 12)) %>%
  addCircleMarkers(data = weather_data, ~Longitude, ~Latitude, color = "black", radius = 0.1, stroke = FALSE) %>%
  addCircles(x = -77.01, y = 38.90, radius = 500, layerId = "wind", color = "black", weight = 2) %>%
  addLayersControl(overlayGroups = c("wind"), options = layersControlOptions(collapsed = FALSE)) %>%
  addPopupHandlers(popupOptions(maxWidth = 500))
