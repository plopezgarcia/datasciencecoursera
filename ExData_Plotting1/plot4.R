setwd("~/Google Drive/Coursera/DataScience/Exploratory Data Analysis/projects")

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

dateTime <- paste(as.character(data$Date), as.character(data$Time), sep = " ")
data$Time <- strptime(dateTime, format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(as.character(data$Date), "%d/%m/%Y")


# We will only be using data from the dates 2007-02-01 and 2007-02-02.

smalldata <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Plot 4

#http://seananderson.ca/courses/11-multipanel/multipanel.pdf
par(mfrow=c(2,2))
plot(smalldata$Time, smalldata$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

plot(smalldata$Time, smalldata$Voltage, xlab = "datetime", ylab="Voltage", type = "l")

plot(smalldata$Time, smalldata$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(smalldata$Time, smalldata$Sub_metering_2, col = "red")
lines(smalldata$Time, smalldata$Sub_metering_3, col = "blue")

#http://stackoverflow.com/questions/16905535/r-legend-trouble-how-to-change-the-text-size-in-legend

legend(as.POSIXlt("2007-02-01 16:00:00"),40,
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1),
       col=c("black","blue","red"),
       y.intersp = c(0.4,0.4,0.4),
       bty = "n",
       pt.cex = 1,
       cex = 0.7)

plot(smalldata$Time, smalldata$Global_reactive_power, xlab = "datetime", ylab="Global_reactive_power", type = "l")
dev.copy(png, file = "plot4.png")
dev.off()