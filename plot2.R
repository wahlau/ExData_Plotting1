setwd("~/Documents/Coursera_DataScience/Course5 - Exploratory Data Analysis/ExData_Plotting1/")
dest="../data/household_power_consumption.txt" 
fileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"   
if (!file.exists(dest)) {
  download.file(fileURL, destfile = '../data/household_power_consumption.zip')
  unzip('../data/household_power_consumption.zip', exdir = '../data/')
}
data <- read.table(dest, header = TRUE, sep = ";", colClasses = c("character", "character", rep("numeric",7)),  na = "?")

# now get only the two days of data we are interested in
subset <- data$Date == "1/2/2007" | data$Date == "2/2/2007"
desiredData <- data[subset, ]

attach(desiredData)
x <- paste(Date, Time)
desiredData$DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")
rownames(desiredData) <- 1:nrow(desiredData)
# reattach desiredData
attach(desiredData)
# plotting time
png(filename = "plot2.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")
plot(DateTime, Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()