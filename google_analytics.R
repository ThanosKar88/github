library(googleAnalyticsR)
library(tidyverse)

# Set the Google Analytics credentials and view ID
ga_auth()
view_id <- "12345678"

# Set the date range for the report
start_date <- "2022-01-01"
end_date <- "2022-01-31"

# Retrieve the data from Google Analytics
ga_data <- google_analytics(view_id,
                            date_range = c(start_date, end_date),
                            metrics = c("users", "sessions", "pageviews"),
                            dimensions = c("date", "sourceMedium"),
                            anti_sample = TRUE,
                            max = -1)

# Generate a report from the data
report <- ga_data %>%
  group_by(date, sourceMedium) %>%
  summarise(users = sum(users),
            sessions = sum(sessions),
            pageviews = sum(pageviews))

# Print the report
print(report)
