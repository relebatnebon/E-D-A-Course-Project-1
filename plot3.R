## Input: Dataset position
## Output: Chart showing the level of 3 energy sub meterings

## ask for location of the source file
## Input example: ./Data/household_power_consumption.txt
cat("Source file location:")
dirSource <- readLines(n=1)

## set data types
library(methods)
setClass("thisDate")
setAs("character", "thisDate", function(from) as.Date(from, format="%d/%m/%Y") )
setClass("thisTime")
setAs("character", "thisTime", function(from) as.POSIXct(from, format="%H:%M:%S"))

## read data
rawDataset <- read.table(dirSource,header=TRUE,na.strings="?",
		colClasses=c("thisDate","thisTime",rep("numeric",7)),sep=";")

## subset the data
ds <- rawDataset[rawDataset$Date >= as.Date("2007-02-01") &
			rawDataset$Date <= as.Date("2007-02-02"),]

## update Time column
ds$Time <-ISOdatetime(format(ds$Date, "%Y"),format(ds$Date, "%m"),format(ds$Date, "%d") 
	,format(ds$Time, "%H"),format(ds$Time, "%M"),format(ds$Time, "%S")
	,tz = "")

## create plot 3
with(ds
	,{
		plot(Sub_metering_1~Time
			,type="l"
			,ylab="Global Active Power (kilowatts)"
			,xlab="")
		lines(Sub_metering_2~Time,col='Red')
		lines(Sub_metering_3~Time,col='Blue')
	}
)
legend("topright"
	,col=c("black", "red", "blue"),
	,lty=1
	,lwd=2
	,legend=c("Sub_metering_1"
		,"Sub_metering_2"
		,"Sub_metering_3"))

## Save the output to PNG
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
