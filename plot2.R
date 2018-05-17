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

#Change Global_active_power from factor to numeric
d2$Global_active_power<-as.numeric(as.character(d2$Global_active_power))

#Call to plot() to create plot
plot(d2$datetime,d2$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)") 
