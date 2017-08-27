rm (list =ls())
setwd("/users/artem/Documents/Coursera")

if(!file.exists("Course 4")) {
  dir.create("Course 4")
  if(!file.exists("./Course 4/Week 1")) {
    dir.create("./Course 4/Week 1")}
  if (!file.exists("./Course 4/Week 1/Project")) {
    dir.create("./Course 4/Week 1/Project")
  }
}
setwd("./Course 4/Week 1/Project")

if(!file.exists("Plots")) {
  dir.create("Plots")
}

file_name <- "power_consumption.zip"
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
              destfile = (file_name))
if(!file.exists("./Project/household_power_consumption.txt")) {
  unzip(file_name)
}


# reading a file, and then subsetting rows and converting them into date format
library(data.table)
library(lubridate)
library(dplyr)
raw_data <- fread("household_power_consumption.txt", header = T, na.strings = "?", colClasses = )
dates <- c("1/2/2007", "2/2/2007")
consumption <- raw_data[raw_data$Date %in% dates,] %>%
  mutate(Date_time = dmy_hms(paste(Date,Time, sep = " ")))


#plot_1
hist(consumption$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col = "red")
dev.copy(png, file = "./Plots/plot1.png", height = 480, width = 480, units = "px")
dev.off()
