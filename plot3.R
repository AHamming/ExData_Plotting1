#plot 3
#If data file is not present, download the required household power consumption data file from UC Irvine Machine Learning Repository
if(!file.exists('power.zip')){
  url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  
  download.file(url,destfile = "power.zip")
}

#unizip downloaded file into txt file
unzip("power.zip")

power<-read.table("household_power_consumption.txt",header = TRUE, sep= ";")

#quick check to make sure data looks okay
head(power)
#review structure of variables
str(power)
#identify class of variables
lapply(power, class)
#What do the first few values of the date variable look like?
power$Date[1:5]
#how about time?
power$Time[1:5]
#combine date and time into new variable
power$DT<-paste(power$Date, power$Time)
#review new variable DT
power$DT[1:5]

#Change DT to yyyy-mm-dd hh:mm:ss
power$DT<-strptime(power$DT, "%d/%m/%Y %H:%M:%S")
#Select only range between 2007-02-01 and 2007-02-02
start<-which(power$DT==strptime("2007-02-01", "%Y-%m-%d"))

stop<-which(power$DT==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))

power2<-power[start:stop,]

plot3<-plot(power2$DT, as.numeric(as.character(power2$Sub_metering_1)),type='l', 
            ylab ="Energy sub metering", xlab="", main="Plot 3")
lines(power2$DT, as.numeric(as.character(power2$Sub_metering_2)),type='l', col='red')
lines(power2$DT, power2$Sub_metering_3,type='l', col="blue")
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1)
       ,col=c("black","red","blue"))
plot3


dev.copy(png, 'plot3.png')
dev.off()