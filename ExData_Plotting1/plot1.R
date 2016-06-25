data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

dateTime <- paste(as.character(data$Date), as.character(data$Time), sep = " ")
data$Time <- strptime(dateTime, format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(as.character(data$Date), "%d/%m/%Y")

# We will only be using data from the dates 2007-02-01 and 2007-02-02.

smalldata <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Plot 1

hist(smalldata$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.copy(png, file = "plot1.png") 
dev.off()