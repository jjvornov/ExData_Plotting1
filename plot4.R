##Read in data and subset to the two days
datafile<-"household_power_consumption.txt"
data<-read.table(datafile, header = TRUE, sep =";",na.strings="?", stringsAsFactors=FALSE)
##use lubridate library to read the dates more easily
library(lubridate)
data$Date <- dmy(data$Date)
##put the data and time together
dateTime<-paste(data$Date,data$Time)
DateTime<-(strptime(dateTime, "%Y-%m-%d %H:%M:%S"))
##Bring the combined date time as date to first column and drop the others
data<-cbind(DateTime,data)
data2<-data[,-c(2,3)]
head(data2)
##now select out the two days 2007-02-01 and 2007-02-02
data3<-subset(data2,DateTime > "2007-02-01" & DateTime < "2007-02-03" )

##This just plots previous plots with some mods in single 2x2 file
png(file="plot4.png")
par(mfrow = c(2, 2))
with(data3, {
  plot(data3$Global_active_power~data3$DateTime,
       type="l",
       ylab="Global Active Power",
       xlab="")
  plot(Voltage~DateTime,type="l")
  plot(data3$Sub_metering_1~data3$DateTime,
       ylim=c(1,40),
       type="l",
       ylab="Energy sub metering",
       xlab="")
  lines(data3$Sub_metering_2~data3$DateTime, col="red")
  lines(data3$Sub_metering_3~data3$DateTime,col="blue")
  legend("topright", 
         lty = c(1, 1, 1), 
         bty="n",
         col =  c("black","red","blue"), 
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(Global_reactive_power~DateTime,type="l")
})
dev.off()