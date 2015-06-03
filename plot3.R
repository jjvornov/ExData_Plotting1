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

png(file="plot3.png")
plot(data3$Sub_metering_1~data3$DateTime,
     ylim=c(1,40),
     type="l",
     ylab="Energy sub metering",
     xlab="")
lines(data3$Sub_metering_2~data3$DateTime, col="red")
lines(data3$Sub_metering_3~data3$DateTime,col="blue")
legend("topright", 
       lty = c(1, 1, 1), 
       col =  c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
