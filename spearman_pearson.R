# Read in data
data <- read.csv("data.csv")

# Calculate Pearson correlation coefficient
pearson_cor <- cor(data$variable1, data$variable2, method = "pearson")

# Calculate Spearman correlation coefficient
spearman_cor <- cor(data$variable1, data$variable2, method = "spearman")

# Print results
cat("Pearson correlation coefficient:", pearson_cor, "\n")
cat("Spearman correlation coefficient:", spearman_cor, "\n")
