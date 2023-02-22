# Importing data
data <- read.csv("data.csv")

# Performing linear regression
model <- lm(Y ~ X1 + X2 + X3 + X4 + X5, data = data)

# Outputting regression summary
summary(model)
