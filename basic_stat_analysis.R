# Importing data
data <- read.csv("data.csv")

# Data cleaning
data <- data[complete.cases(data), ]

# Descriptive statistics
summary(data)

# Correlation analysis
correlation_matrix <- cor(data)
corrplot(correlation_matrix, method = "circle")

# Linear regression
linear_model <- lm(Y ~ X1 + X2 + X3, data = data)
summary(linear_model)

# Data visualization
ggplot(data, aes(X1, Y)) + geom_point() + geom_smooth(method = "lm")

# Hypothesis testing
t.test(data$X1, data$X2)

# ANOVA
anova_model <- aov(Y ~ X1 + X2 + X3, data = data)
summary(anova_model)

# Random forest
library(randomForest)
random_forest_model <- randomForest(Y ~ X1 + X2 + X3, data = data)
summary(random_forest_model)
