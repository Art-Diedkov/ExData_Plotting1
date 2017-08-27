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

#plot 3
par(mar = c(4,4,4,2))
with(consumption, plot(Date_time, Sub_metering_1, xlab = NA, ylab = "Ehergy sub metering", type = "n"))
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       col = c("black","red","blue"), 
       lty = 1,
       cex = 0.8)
with(consumption,lines(Date_time, Sub_metering_1))
with(consumption,lines(Date_time, Sub_metering_2, col = "red"))
with(consumption, lines(Date_time, Sub_metering_3, col = "blue"))
dev.copy(png,file = "./Plots/plot3.png",width = 480, height = 480, units = "px")
dev.off()

