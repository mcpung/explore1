# name          :       plot2.R
# author        :       Murray Pung
# date          :       2016-10-13
# description   :       The household power consumption data are downloaded and unzipped
#                       A lineplot of Global Active Power is then plotted 

# the zip is downloaded, unzipped, and placed in the power object.
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
power <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", header = TRUE)
unlink(temp)

# the dplyr package is used to mutate the data variable and the power dataset is then filtered on this variable
library(dplyr)
subpower <- mutate(power,date=as.Date(power$Date,"%d/%m/%Y"),day=substr(weekdays(as.Date(power$Date)),1,3)) %>%
        filter(date>="2007-02-01" & date<="2007-02-02") 


png(file="plot4.png",width=480,height=480)
par(mfrow=c(2,2)) # change the graphic device settings to two rows by two columns
# the global active power data are plotted in the first position
with(subpower, plot(strptime(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S"),Global_active_power,
                 type = "l",
                 xlab = "", 
                 ylab = "Global Active Power (kilowatts)",
                 main = ""))
# the Voltage is then plotted as a line plot
with(subpower, plot(strptime(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S"),Voltage,
                 type = "l",
                 xlab = "",
                 main = ""))
# the sub metering 1 data are plotted
with(subpower, plot(strptime(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S"),Sub_metering_1,
                 type = "l",
                 xlab = "", 
                 ylab = "Energy sub metering",
                 main = ""))
# the sub metering 2 data are plotted
with(subpower, lines(strptime(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S"),
                  Sub_metering_2,
                  col="red"))
# the sub metering 3 data are plotted
with(subpower, lines(strptime(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S"),
                  Sub_metering_3,
                  col="blue"))
# the legend is added to the plot
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=1)
# the final plot is added -global reactive power
with(subpower, plot(strptime(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S"),Global_reactive_power,
                 type = "l",
                 xlab = "",
                 main = ""))

dev.off()

