setwd("F:/Simplilearn/R Programming/Dataset/")
getwd()
dir()

install.packages(c("ggplot2", "dplyr", "lubridate", "readr", "tidyverse"))
library(ggplot2)
library(dplyr)
library(lubridate)
library(readr)
library(tidyverse)

install.packages("readxl")
library(readxl)
df = read_excel("Flight_Delays.xlsx")
View(df)
summary(df)
str(df)

# Convert schedtime to Decimal Hours
df$schedtime_hours <- floor(df$schedtime / 100) + (df$schedtime %% 100) / 60

# Check the first few values:
head(df$schedtime_hours)

# Check if any schedtime_hours values are NA:
sum(is.na(df$schedtime_hours))  # Should be 0 ideally

# 1️⃣ Histogram of Scheduled Time
ggplot(df, aes(x = schedtime_hours)) +
  geom_histogram(fill = "blue", bins = 24, color = "black") +
  labs(title = "Distribution of Scheduled Flight Times", 
       x = "Scheduled Time (Hours)", 
       y = "Count")


# 2️⃣ Histogram of Carriers
ggplot(df, aes(x = carrier)) +
  geom_bar(fill = "orange") +
  labs(title = "Number of Flights per Carrier", x = "Carrier", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate labels if needed


# 3️⃣ Histogram of Destinations
ggplot(df, aes(x = dest)) +
  geom_bar(fill = "purple") +
  labs(title = "Flight Distribution by Destination", x = "Destination", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 4️⃣ Histogram of Origins
ggplot(df, aes(x = origin)) +
  geom_bar(fill = "green") +
  labs(title = "Flight Distribution by Origin", x = "Origin", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 5️⃣ Histogram of Weather Conditions
ggplot(df, aes(x = factor(weather))) +  # Convert weather to a factor for categorical plotting
  geom_bar(fill = "red") +
  labs(title = "Flights Distribution by Weather Condition", x = "Weather (0 = Clear, 1 = Bad)", y = "Count")

# 6️⃣ Histogram of Day of the Week
ggplot(df, aes(x = factor(dayweek))) +  # Convert to factor to treat as categorical
  geom_bar(fill = "cyan") +
  labs(title = "Flights Distribution by Day of the Week", x = "Day of the Week", y = "Count")

# 📊 Scatter Plot for Flights (Ontime vs. Delayed)
ggplot(df, aes(x = schedtime_hours, y = deptime, color = delay)) +
  geom_point(alpha = 0.6) +
  labs(title = "Scatter Plot of Scheduled vs. Departure Time",
       x = "Scheduled Time (Hours)",
       y = "Departure Time",
       color = "Delay Status") +
  theme_minimal()

# 📊 Steps to Create the Box Plot
ggplot(df, aes(x = factor(daymonth), y = deptime - schedtime, fill = delay)) +
  geom_boxplot() +
  labs(title = "Delay Distribution by Day of the Month",
       x = "Day of the Month",
       y = "Departure Delay (Minutes)",
       fill = "Delay Status") +
  theme_minimal()


##### Define the hours of departure
# ✅ Steps to Categorize Departure Hours
# 1️⃣ Convert deptime to Decimal Hours (if not already done)
df$deptime_hours <- floor(df$deptime / 100) + (df$deptime %% 100) / 60

# 2️⃣ Create Departure Time Categories
df$departure_period <- case_when(
  df$deptime_hours >= 5 & df$deptime_hours < 12  ~ "Morning",
  df$deptime_hours >= 12 & df$deptime_hours < 17 ~ "Afternoon",
  df$deptime_hours >= 17 & df$deptime_hours < 21 ~ "Evening",
  TRUE ~ "Night"  # Includes late-night & early-morning flights
)

# 3️⃣ Verify the Categorization
table(df$departure_period)  # Check counts in each category

# 📊 Visualizing Delays by Departure Period
ggplot(df, aes(x = departure_period, fill = delay)) +
  geom_bar() +
  labs(title = "Flight Delays by Departure Period", 
       x = "Departure Period", 
       y = "Count", 
       fill = "Delay Status") +
  theme_minimal()


##### Create a categorical representation of data using a table
# 1️⃣ Count of Flights by Carrier
table(df$carrier)
# 2️⃣ Count of Flights by Weather Condition
table(df$weather)
# 3️⃣ Count of Flights by Delay Status
table(df$delay)

# Contingency table for Departure Period vs. Delay Status
table(df$departure_period, df$delay)

# Contingency table for Carrier vs. Delay Status
table(df$carrier, df$delay)

# Contingency table for Day of the Week vs. Delay Status
table(df$dayweek, df$delay)

# Create a summary table for Departure Period and Delay Status
library(dplyr)
delay_summary <- df %>%
  group_by(departure_period, delay) %>%
  summarise(Count = n(), .groups = "drop") %>%
  arrange(desc(Count))

print(delay_summary)

# 📊 Visual Representation (Optional)
ggplot(df, aes(x = carrier, fill = delay)) +
  geom_bar(position = "dodge") +
  labs(title = "Flight Delays by Carrier", x = "Carrier", y = "Count", fill = "Delay Status") +
  theme_minimal()


##### Redefine the delay variables
# 1️⃣ Convert delay into a Numeric Column
df$delay_numeric <- ifelse(df$delay == "delayed", 1, 0)

# 2️⃣ Verify the Changes
table(df$delay, df$delay_numeric)

# 3️⃣ Check Delay Percentage
mean(df$delay_numeric) * 100



##### Understand the summary of major variables
# 1️⃣ Summary Statistics for Numerical Variables
summary(df[, c("schedtime", "deptime", "distance", "daymonth", "delay_numeric")])

# 2️⃣ Summary of Categorical Variables
table(df$carrier)      # Count of flights per airline
table(df$weather)      # Flights affected by bad weather
table(df$dayweek)      # Flights per day of the week
table(df$delay_numeric) # Count of delayed vs. on-time flights

# 3️⃣ Correlation Between Variables (Optional)
cor(df[, c("schedtime", "deptime", "distance", "daymonth", "delay_numeric")])


##### Plot histograms of major variables
# 1️⃣ Histogram: Delays by Scheduled Time
ggplot(df, aes(x = schedtime_hours, fill = factor(delay_numeric))) +
  geom_histogram(bins = 24, color = "black") +
  labs(title = "Flight Delays by Scheduled Time", 
       x = "Scheduled Time (Hours)", 
       y = "Count", 
       fill = "Delay Status") +
  scale_fill_manual(values = c("0" = "blue", "1" = "red"), labels = c("On-time", "Delayed")) +
  theme_minimal()


# 2️⃣ Bar Chart for Carrier vs. Delay
ggplot(df, aes(x = carrier, fill = factor(delay_numeric))) +
  geom_bar(position = "dodge", color = "black") +
  labs(title = "Flight Delays by Carrier", 
       x = "Carrier", 
       y = "Count", 
       fill = "Delay Status") +
  scale_fill_manual(values = c("0" = "blue", "1" = "red"), labels = c("On-time", "Delayed")) +
  theme_minimal()


# 3️⃣ Bar Chart Delays by Day of the Week
ggplot(df, aes(x = factor(dayweek), fill = factor(delay_numeric))) +
  geom_bar(position = "dodge", color = "black") +
  scale_x_discrete(labels = c("1" = "Mon", "2" = "Tue", "3" = "Wed", "4" = "Thu", "5" = "Fri", "6" = "Sat", "7" = "Sun")) +
  labs(title = "Flight Delays by Day of the Week", 
       x = "Day of the Week", 
       y = "Count", 
       fill = "Delay Status") +
  scale_fill_manual(values = c("0" = "blue", "1" = "red"), labels = c("On-time", "Delayed")) +
  theme_minimal()


# 4️⃣ Bar Chart: Delays by Weather
ggplot(df, aes(x = factor(weather), fill = factor(delay_numeric))) +
  geom_bar(position = "dodge", color = "black") +
  scale_x_discrete(labels = c("0" = "Clear", "1" = "Bad")) +
  labs(title = "Impact of Weather on Flight Delays", 
       x = "Weather Condition", 
       y = "Count", 
       fill = "Delay Status") +
  scale_fill_manual(values = c("0" = "blue", "1" = "red"), labels = c("On-time", "Delayed")) +
  theme_minimal()



##### Plot a pie chart to see how many flights were delayed

# Calculate percentage of delays
delay_counts <- df %>%
  group_by(delay_numeric) %>%
  summarise(count = n()) %>%
  mutate(percent = round(100 * count / sum(count), 1))

# Create Pie Chart with Percent Labels in Yellow Color
ggplot(delay_counts, aes(x = "", y = count, fill = factor(delay_numeric))) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +  # Converts bar chart into a pie chart
  geom_text(aes(label = paste0(percent, "%")), 
            position = position_stack(vjust = 0.5), 
            color = "yellow", size = 5, fontface = "bold") +  # Change text color to yellow
  labs(title = "Proportion of Delayed vs. On-Time Flights", 
       fill = "Flight Status") +
  scale_fill_manual(values = c("0" = "blue", "1" = "red"), 
                    labels = c("On-time", "Delayed")) +
  theme_void()  # Removes background grid for a clean pie chart



### The End

