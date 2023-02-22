# Importing data
data <- read.csv("data.csv")

# Scaling data
scaled_data <- scale(data)

# Performing K-means clustering
set.seed(123)
kmeans_model <- kmeans(scaled_data, centers = 3)

# Visualizing results
library(ggplot2)
library(dplyr)
cluster_data <- data.frame(scaled_data, Cluster = factor(kmeans_model$cluster))
ggplot(cluster_data, aes(x = X1, y = X2, color = Cluster)) +
  geom_point() +
  labs(title = "K-means Clustering of Data")
