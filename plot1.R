# name          :       plot1.R
# author        :       Murray Pung
# date          :       2016-10-13
# description   :       The household power consumption data are downloaded and unzipped
#                       A histogram of Global Active Power is then plotted 

# the zip is downloaded, unzipped, and placed in the power object.
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
power <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", header = TRUE)
unlink(temp)

# the dplyr package is used to mutate the data variable and the power dataset is then filtered on this variable
library(dplyr)
subpower <- mutate(power,date=as.Date(power$Date,"%d/%m/%Y")) %>%
            filter(date>="2007-02-01" & date<="2007-02-02") 

# there should only be two dates printed : "2007-02-01" "2007-02-02"
unique(subpower$date)

# a histogram is created and saved as a .png in the working directory
png(file="plot1.png",width=480,height=480)
with(subpower, hist(as.numeric(Global_active_power), 
                 xlab = "Global Active Power (kilowatts)", 
                 ylab = "Frequency",
                 col = "red",
                 main = "Global Active Power"))
dev.off()

