## plot4.R constructs a plot, plot4.png
## Also saves it to a PNG file with a width of 480 pixels and a height of 480 pixels.
## Assumptions: unzipped data file is in the working directory.

#If needed, download and unzip by uncommenting below
#download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="PowerConsumption.zip")
#unzip the file
#unzip("PowerConsumption.zip")

#Read the file into R
power<-read.csv("household_power_consumption.txt",sep=";",header=T,na.strings="?",colClass=c("character","character",rep("numeric",7))) 

# Subset based on dates 2007-02-01 and 2007-02-02
test<-power[,1]=="1/2/2007"|power[,1]=="2/2/2007"
power<-power[test,]
#Change Date column format to R date format
power$Date<-as.Date(power$Date,"%d/%m/%Y")

#Change Time column format to R time format
temp<-paste(power[,1],power[,2])
#Change the name of the time column since it will be date and time
colnames(power)[2]<-"datetime"
power$datetime<-strptime(temp, "%Y-%m-%d %H:%M:%S", tz="")

#Create a plot

par.old<-par(mfrow=c(2,2)) # going to plot a 2x2 array of graphs
with(power, {
	plot(power$datetime,power[,3],type="l",ylab="Global Active Power",xlab="") # in row 1,col 1
	plot(datetime,Voltage,type="l",ylab="Voltage") #in row 1, col 2

	with(power, plot(datetime,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")) # in row 2, col 1
	with(power,lines(datetime,Sub_metering_1))
	with(power,lines(datetime,Sub_metering_2,col="red"))
	with(power,lines(datetime,Sub_metering_3,col="blue"))
	legend("topright", bty="n", lty=1, col=c("black","blue","red"), 
		legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

	plot(datetime,Global_reactive_power,type="l") #in row 2,col2
})

dev.copy(png, file ="plot4.png") ## Copy plot to a PNG file
dev.off() ## Close the PNG device
par(par.old) # Reset