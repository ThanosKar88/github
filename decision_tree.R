# Importing data
data <- read.csv("data.csv")

# Splitting data into training and testing sets
set.seed(123)
train_index <- sample(1:nrow(data), size = 0.7 * nrow(data), replace = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# Performing decision tree analysis
library(rpart)
decision_tree_model <- rpart(Y ~ ., data = train_data)

# Predicting results on test data
test_data$predicted_Y <- predict(decision_tree_model, test_data, type = "vector")

# Assessing model accuracy
library(Metrics)
mae(test_data$Y, test_data$predicted_Y)
