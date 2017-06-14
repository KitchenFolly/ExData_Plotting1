#libraries needed
library(data.table)
library(dplyr)
library(readr)

## DATA
# import the big data set
power_large <- fread(file.path( "household_power_consumption.txt"), na.strings="?" )

# subset the data set to just the dates we need
power <- filter(power_large, Date == "1/2/2007" | Date == "2/2/2007")

# create a date time column that can be sequenced
power <- mutate(power, date_time = paste(Date, Time))
power$date_time <- strptime(power$date_time, format = "%d/%m/%Y %H:%M:%S", tz = "")

## PLOTTING
plot(power$date_time, power$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", cex = .75)
lines(power$date_time, power$Sub_metering_1, col = "black")
lines(power$date_time, power$Sub_metering_2, col = "red")
lines(power$date_time, power$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .75, lty=c(1,1),  lwd = 2, col = c("black", "red", "blue"))

## PRINTING
dev.print(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()


