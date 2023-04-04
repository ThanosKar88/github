library(h2o)

# Start the H2O cluster
h2o.init()

# Load the data
data <- h2o.importFile("https://h2o-public-test-data.s3.amazonaws.com/smalldata/logreg/prostate.csv")

# Convert the target variable to a factor
data$CAPSULE <- as.factor(data$CAPSULE)

# Split the data into training and testing sets
split <- h2o.splitFrame(data, ratios = c(0.8, 0.2), seed = 123)
train <- split[[1]]
test <- split[[2]]

# Specify the model parameters
model_params <- list(
  activation = "TanhWithDropout",
  input_dropout_ratio = 0.2,
  hidden_dropout_ratios = c(0.5, 0.5),
  adaptive_rate = TRUE,
  epochs = 100,
  l1 = 1e-5,
  l2 = 1e-5
)

# Build the neural network
model <- h2o.deeplearning(
  x = 2:9,
  y = "CAPSULE",
  training_frame = train,
  validation_frame = test,
  hidden = c(50, 50),
  stopping_rounds = 5,
  stopping_tolerance = 1e-3,
  stopping_metric = "AUC",
  score_validation_samples = 10000,
  score_duty_cycle = 0.025,
  max_w2 = 10,
  **model_params
)

# Print the model summary
print(summary(model))

# Shutdown the H2O cluster
h2o.shutdown()
