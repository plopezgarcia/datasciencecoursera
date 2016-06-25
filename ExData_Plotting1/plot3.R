data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

dateTime <- paste(as.character(data$Date), as.character(data$Time), sep = " ")
data$Time <- strptime(dateTime, format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(as.character(data$Date), "%d/%m/%Y")


# We will only be using data from the dates 2007-02-01 and 2007-02-02.

smalldata <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Plot 3

# http://www.r-bloggers.com/adding-a-legend-to-a-plot/

plot(smalldata$Time, smalldata$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(smalldata$Time, smalldata$Sub_metering_2, col = "red")
lines(smalldata$Time, smalldata$Sub_metering_3, col = "blue")

legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1),
       col=c("black","blue","red"),
       y.intersp = c(0.5,0.5,0.5))
dev.copy(png, file = "plot3.png")
dev.off()



