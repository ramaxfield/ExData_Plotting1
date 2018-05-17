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

#Change Global_active_power from factor to numeric
d1$Global_active_power<-as.numeric(as.character(d1$Global_active_power))

#Call to hist() to create histogram
hist(d1$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
