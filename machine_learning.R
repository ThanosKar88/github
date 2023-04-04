library(caret)

# Load the iris dataset
data(iris)

# Split the data into training and testing sets
set.seed(123)
trainIndex <- createDataPartition(iris$Species, p = 0.7, list = FALSE)
training <- iris[trainIndex, ]
testing <- iris[-trainIndex, ]

# Train the SVM model
svm_model <- train(Species ~ ., 
                   data = training, 
                   method = "svmRadial",
                   trControl = trainControl(method = "cv", number = 10))

# Make predictions on the testing set
predictions <- predict(svm_model, testing)

# Evaluate the model performance
confusionMatrix(predictions, testing$Species)
