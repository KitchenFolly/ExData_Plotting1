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
# set up the frame
par(mfrow= c(2,2), mar = c(3.7, 3.6, 2 ,1) + 0.1, oma = c(2,1,0,0) + 0.1)
par(cex.lab=.9)

# make the 4 plots
plot(power$date_time, power$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", cex.axis = .65)

plot(power$date_time, power$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", cex.axis = .65)

plot(power$date_time, power$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", cex = .75, cex.axis = .65)
lines(power$date_time, power$Sub_metering_1, col = "black")
lines(power$date_time, power$Sub_metering_2, col = "red")
lines(power$date_time, power$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .5, lty=c(1,1),  lwd = 2, col = c("black", "red", "blue"))

plot(power$date_time, power$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power",  cex.axis = .65)


## PRINT
# To png
dev.print(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()






