# Importing data
data <- read.csv("data.csv")

# Data cleaning
data <- data[complete.cases(data), ]

# Heatmap
library(ggplot2)
library(RColorBrewer)
heatmap_data <- data[,c("X1", "X2", "X3", "X4", "X5", "X6")]
colnames(heatmap_data) <- c("A", "B", "C", "D", "E", "F")
row.names(heatmap_data) <- paste0("Row", 1:nrow(heatmap_data))
heatmap_data_scaled <- scale(heatmap_data)
heatmap_colors <- brewer.pal(n = 9, name = "YlOrRd")
heatmap_colors <- rev(heatmap_colors)
heatmap_breaks <- seq(-2, 2, length.out = length(heatmap_colors) + 1)
ggplot(reshape2::melt(heatmap_data_scaled), aes(x = variable, y = rownames(heatmap_data_scaled), fill = value)) + 
  geom_tile() +
  scale_fill_gradientn(colours = heatmap_colors, breaks = heatmap_breaks, limits = c(-2, 2), na.value = "grey") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), axis.text.y = element_text(size = 8)) +
  ggtitle("Heatmap of scaled data")

# Network graph
library(igraph)
edges <- data[,c("From", "To")]
nodes <- unique(c(as.character(edges$From), as.character(edges$To)))
nodes <- data.frame(ID = nodes)
nodes$Label <- nodes$ID
nodes$Type <- ifelse(grepl("^A", nodes$ID), "Group A", "Group B")
g <- graph_from_data_frame(edges)
V(g)$color <- ifelse(grepl("^A", V(g)$name), "red", "blue")
V(g)$size <- ifelse(grepl("^A", V(g)$name), 30, 15)
plot(g, vertex.label = nodes$Label, vertex.label.cex = 0.8, vertex.color = V(g)$color, vertex.size = V(g)$size, edge.arrow.size = 0.5, edge.curved = 0.1, layout = layout.fruchterman.reingold)

# Geographic map
library(ggmap)
library(dplyr)
location_data <- data[,c("Location", "Value")]
location_data <- group_by(location_data, Location) %>%
  summarise(Value = mean(Value))
location_data$Location <- as.character(location_data$Location)
location_data$Value <- as.numeric(location_data$Value)
location_data$Location <- gsub(",", "", location_data$Location)
location_data$Location <- paste0(location_data$Location, ", United States")
us_map <- get_map(location = "united states")
ggmap(us_map) +
  geom_point(data = location_data, aes(x = lon, y = lat, size = Value), color = "red") +
  scale_size_continuous(range = c(1, 10)) +
  ggtitle("Geographic distribution of data")
