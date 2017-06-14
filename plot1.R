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
hist(power$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

## PRINTING
dev.print(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()



