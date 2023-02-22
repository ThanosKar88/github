# Importing data
data <- read.csv("data.csv")

# Data cleaning
data <- data[complete.cases(data), ]

# Mixed effects model
library(lme4)
mixed_model <- lmer(Y ~ X1 + X2 + (1 + X1 | Group), data = data)
summary(mixed_model)

# Structural equation modeling (SEM)
library(lavaan)
SEM_model <- '
  # Measurement model
  Y1 =~ X1 + X2 + X3
  Y2 =~ X4 + X5 + X6
  
  # Structural model
  Y1 ~ Y2
  '
fit <- sem(SEM_model, data = data)
summary(fit)

# Principal component analysis (PCA)
PCA_data <- data[,c("X1", "X2", "X3", "X4", "X5", "X6")]
PCA_result <- prcomp(PCA_data, center = TRUE, scale. = TRUE)
summary(PCA_result)

# Cluster analysis
library(cluster)
cluster_data <- data[,c("X1", "X2", "X3")]
cluster_model <- kmeans(cluster_data, centers = 3)
cluster_model$cluster
