library(tidyverse)

# Read the CSV file
data <- read_csv("mydata.csv")

# Filter and arrange the data
filtered_data <- data %>%
  filter(column1 > 10, column2 == "some value") %>%
  arrange(column3)

# Compute some summary statistics
summary_stats <- filtered_data %>%
  summarize(mean_column4 = mean(column4), 
            sd_column5 = sd(column5))

# Create a plot
my_plot <- ggplot(filtered_data, aes(x = column3, y = column4)) +
  geom_point(size = 3, color = "blue") +
  labs(title = "My plot", x = "Column 3", y = "Column 4")

# Save the plot as a PDF file
ggsave("my_plot.pdf", plot = my_plot, width = 6, height = 4, units = "in")
