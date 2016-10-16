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

#  a line plot is created and output to the working directory in png format
png(file="plot2.png",width=480,height=480)
with(subpower, plot(strptime(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S"),Global_active_power,
                 type = "l",
                 xlab = "", 
                 ylab = "Global Active Power (kilowatts)",
                 main = ""))
dev.off()

