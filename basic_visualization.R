# Importing data
data <- read.csv("data.csv")

# Data cleaning
data <- data[complete.cases(data), ]

# Creating a scatter plot
library(ggplot2)
ggplot(data, aes(x = X, y = Y, color = Category)) + 
  geom_point() +
  ggtitle("Scatter plot of X and Y by category") +
  xlab("X") +
  ylab("Y") +
  theme_bw()

# Creating a box plot
ggplot(data, aes(x = Category, y = X, fill = Category)) + 
  geom_boxplot() +
  ggtitle("Box plot of X by category") +
  xlab("Category") +
  ylab("X") +
  theme_bw()

# Creating a histogram
ggplot(data, aes(x = Y, fill = Category)) + 
  geom_histogram(binwidth = 1) +
  ggtitle("Histogram of Y by category") +
  xlab("Y") +
  ylab("Frequency") +
  theme_bw()
