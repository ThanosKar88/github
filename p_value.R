# Generate two random samples
set.seed(123)
sample1 <- rnorm(50, mean = 10, sd = 2)
sample2 <- rnorm(50, mean = 12, sd = 2)

# Test for statistical significance using t-test
ttest_result <- t.test(sample1, sample2)
p_value <- ttest_result$p.value

# Check if p-value is less than alpha (0.05)
if(p_value < 0.05) {
  cat("The p-value is", p_value, "which is less than 0.05. Therefore, the difference between the means is statistically significant.")
} else {
  cat("The p-value is", p_value, "which is not less than 0.05. Therefore, the difference between the means is not statistically significant.")
}
