# ✈️ Flight Delays Analysis (R Programming Project)

## 📌 Project Overview
This project analyzes flight delays using **R programming**.  
The dataset includes flight information such as scheduled time, departure time, carrier, weather, and delay status.  
The goal was to visualize the impact of different factors on delays using **histograms, scatter plots, box plots, bar charts, and pie charts**.

---

## 🛠️ Tools & Packages
- R Programming  
- ggplot2  
- dplyr  
- readxl  
- tidyverse  
- lubridate  

---

## 📂 Repository Contents
- `datasets/Flight_Delays.xlsx` → Dataset  
- `FlightDelays.R` → R Script with analysis code  
- `images/` → All chart images  
- `Flight_Delay_Project_Summary.pdf` → Project Report  
- `My_Learning_Experience.pdf` → Learning Note  
- `README.md` → Documentation  

---

## 📊 Visualizations (in analysis order)

### 1) Scheduled Time Distribution  
![Histogram Distribution of Schedule Flight Time](images/Histogram Distribution of Schedule Flight Time.png)

### 2) Flights per Carrier  
![Bar Chart No of Flights per Carriers](images/Bar Chart No of Flights per Carriers.png)

### 3) Flight Distribution by Destination  
![Histogram Flight Distribution by Destination](images/Histogram Flight Distribution by Destination.png)

### 4) Flight Distribution by Origin  
![Bar Chart Flight Distribution by Origins](images/Bar Chart Flight Distribution by Origins.png)

### 5) Flights Distribution by Weather Condition  
![Bar Chart Flights Distribution by Weather Condition](images/Bar Chart Flights Distribution by Weather Condition.png)

### 6) Flights Distribution by Day of the Week  
![Histogram Days of the Wek](images/Histogram Days of the Wek.png)

### 7) Scheduled vs Departure Time (Scatter Plot)  
![Scatter Plot Schedule vs Departure Time](images/Scatter Plot Schedule vs Departure Time.png)

### 8) Delay Distribution by Day of the Month (Box Plot)  
![Box Plot Delay Distribution by Day of the Month](images/Box Plot Delay Distribution by Day of the Month.png)

### 9) Flight Delays by Departure Period  
![Bar Chart Flight Delays by Departure Period](images/Bar Chart Flight Delays by Departure Period.png)

### 10) Flight Delays by Carrier  
![Bar Chart Flight Delays by Carrier](images/Bar Chart Flight Delays by Carrier.png)

### 11) Flight Delays by Day of the Week  
![Bar Chart Flight Delays by Day of the Week](images/Bar Chart Flight Delays by Day of the Week.png)

### 12) Flight Delays by Weather  
![Bar Chart Flight Delays by Weather](images/Bar Chart Flight Delays by Weather.png)

### 13) Flight Delays by Scheduled Time  
![Histogram Flight Delays by Scheduled Time](images/Histogram Flight Delays by Scheduled Time.png)

### 14) Delayed vs On-Time Flights (Pie Chart)  
![Pie Delayed vs On Time Flights](images/Pie Delayed vs On Time Flights.png)

---

## 🔑 Key Insights
- **19.45% of flights were delayed**, 80.55% were on-time.  
- Delays were **more frequent in late evening flights**.  
- Certain airlines had **higher delay rates** than others.  
- **Weather caused only 1.5% of delays**, but when bad weather occurred, delays were almost certain.  

---

## 🧑‍💻 Learning Experience
Working on this project gave me a valuable opportunity to apply R programming concepts to a real dataset.  
I learned data cleaning, time conversion, categorical representation, and visualization using **ggplot2** and **dplyr**.  
This project strengthened my ability to explore and present insights clearly.

---

## ▶️ How to Run
1. Download this repository.  
2. Install required R packages:  
   ```R
   install.packages(c("ggplot2","dplyr","readxl","lubridate","tidyverse"))
3. Run the script:
   source("FlightDelays.R")
