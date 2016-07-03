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

x <- paste(desiredData$Date, desiredData$Time)
desiredData$DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")
rownames(desiredData) <- 1:nrow(desiredData)

# plotting time
png(filename = "plot4.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")
# set the plot output to 2 x 2
par(mfrow = c(2, 2))
# first plot
plot(desiredData$DateTime, desiredData$Global_active_power, 
     type = "l",
     xlab = "", ylab = "Global Active Power")
# second plot
plot(desiredData$DateTime, desiredData$Voltage, 
     type = "l",
     xlab = "datetime", ylab = "Voltage")
# third plot (from plot3)
plot(desiredData$DateTime, desiredData$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(desiredData$DateTime, desiredData$Sub_metering_2, col = "red")
lines(desiredData$DateTime, desiredData$Sub_metering_3, col = "blue")
legend("topright", bty = "n", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
# forth plot
plot(desiredData$DateTime, desiredData$Global_reactive_power, 
     type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()