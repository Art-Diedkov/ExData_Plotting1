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

#plot 4 
par(mfrow = c(2,2), mar = c(4,4,2,2), oma = c(0,0,2,0))
#1
with(consumption, plot(Date_time,Global_active_power,ylab = "Global Active Power", xlab = NA,type = 'n'))
lines(consumption$Date_time, consumption$Global_active_power)
#2
with(consumption, plot(Date_time, Voltage, xlab = "datetime",type = 'n',ylab = "Voltage"))
lines(consumption$Date_time, consumption$Voltage)
#3
with(consumption, {
  plot(Date_time, Sub_metering_1, xlab = NA, type = 'l', ylab = "Energy sub metering")
  lines(Date_time, Sub_metering_2, col = "red")
  lines(Date_time, Sub_metering_3, col = "blue")
})
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       col = c("black","red","blue"), 
       lty = 1,
       bty = "n",
       cex = 0.4)
#4
with(consumption, plot(Date_time, Global_reactive_power, xlab = "datetime", type = "n"))
lines(consumption$Date_time, consumption$Global_reactive_power)
dev.copy(png,file = "./Plots/plot_4.png",width = 480, height = 480, units = "px")
dev.off()
