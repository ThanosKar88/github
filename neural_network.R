library(neuralnet)

# Load the iris dataset
data(iris)

# Split the data into training and testing sets
set.seed(123)
trainIndex <- sample(1:nrow(iris), 0.7 * nrow(iris))
training <- iris[trainIndex, ]
testing <- iris[-trainIndex, ]

# Create a formula for the neural network
formula <- as.formula(paste("Species ~ ", paste(colnames(iris)[1:4], collapse = " + ")))

# Train the neural network
nn_model <- neuralnet(formula, data = training, hidden = 5)

# Make predictions on the testing set
predictions <- predict(nn_model, testing[, 1:4])

# Convert the predictions to class labels
predicted_classes <- apply(predictions, 1, which.max)
predicted_classes <- levels(iris$Species)[predicted_classes]

# Evaluate the model performance
accuracy <- sum(predicted_classes == testing$Species) / nrow(testing)
print(paste("Accuracy:", round(accuracy, 2)))
