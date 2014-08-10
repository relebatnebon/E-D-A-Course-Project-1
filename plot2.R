## Input: Dataset position
## Output: Histogram showing the frequency of the global active power reaching different levels

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

## create plot 2
plot(ds$Global_active_power~ds$Time,type="l"
	,ylab="Global Active Power (kilowatts)",xlab="")

## Save the output to PNG
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
