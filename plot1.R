## Input: Dataset position
## Output: Histogram showing the frequency of the global active power reaching different levels at different time in working directory
## Assumption: Data source file placed in the working directory

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

## create plot 1
hist(ds$Global_active_power, 
	breaks=seq(0, ceiling(2*max(ds$Global_active_power))/2, by=0.5)
	,col="red", ,main="Global Actice Power",xlab="Global Active Power (kilowatts)")

## Save the output to PNG
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
