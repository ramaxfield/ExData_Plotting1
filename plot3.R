#Download and unzip data
if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

unzip(zipfile="./data/Dataset.zip",exdir="./data")

#Load dataset into RStudio
df<-read.table("./data/household_power_consumption.txt",header=TRUE,sep=";")

#Subset the data to include only 2007-02-01 and 2007-02-02 with dplyr
library(dplyr)
d1<-filter(df,Date=="1/2/2007"|Date=="2/2/2007")

#Mutate the dates and times with dplyr
d2<-mutate(d1,datetime=as.POSIXct(paste(d1$Date, d1$Time), format="%d/%m/%Y %H:%M:%S"))

#Change Sub_metering_1, 2, and 3 from factors to numerics
d2$Sub_metering_1<-as.numeric(as.character(d2$Sub_metering_1))
d2$Sub_metering_2<-as.numeric(as.character(d2$Sub_metering_2))
d2$Sub_metering_3<-as.numeric(as.character(d2$Sub_metering_3))

#Call to plot() to create plot
plot(d2$datetime,d2$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(d2,lines(datetime,Sub_metering_1))
with(d2,lines(datetime,Sub_metering_2,col="red"))
with(d2,lines(datetime,Sub_metering_3,col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
