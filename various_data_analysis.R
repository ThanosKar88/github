# Load required packages
library(tidyverse)
library(ggplot2)
library(lubridate)
library(gridExtra)
library(corrplot)
library(caret)
library(rpart)
library(rpart.plot)

# Read in data
data <- read.csv("data.csv")

# Check for missing values
sum(is.na(data))

# Remove missing values
data <- na.omit(data)

# Check for duplicates
sum(duplicated(data))

# Remove duplicates
data <- unique(data)

# Explore data
summary(data)

# Visualize data
ggplot(data, aes(x = variable1, y = variable2)) +
  geom_point() +
  labs(title = "Scatterplot of Variables 1 and 2",
       x = "Variable 1",
       y = "Variable 2")

ggplot(data, aes(x = variable1)) +
  geom_histogram(binwidth = 5) +
  labs(title = "Histogram of Variable 1",
       x = "Variable 1",
       y = "Count")

ggplot(data, aes(x = variable2)) +
  geom_density() +
  labs(title = "Density Plot of Variable 2",
       x = "Variable 2",
       y = "Density")

# Calculate correlation matrix
cor_matrix <- cor(data[, -1])

# Visualize correlation matrix
corrplot(cor_matrix, method = "circle")

# Train-test split
set.seed(123)
trainIndex <- createDataPartition(data$target, p = .8, list = FALSE)
training <- data[trainIndex,]
testing <- data[-trainIndex,]

# Decision tree model
model <- rpart(target ~ ., data = training)
rpart.plot(model)

# Predict using model
predictions <- predict(model, newdata = testing)

# Evaluate model
confusionMatrix(predictions, testing$target)
