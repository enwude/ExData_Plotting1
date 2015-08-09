#Load relevant libraries
library(dplyr)
library(data.table)


# Create working directory if necessary
if(!file.exists("~/Data/")){
        dir.create("~/Data/")
}

if(!exists("powerSubset", envir = globalenv())){
        
        # Download and unzip the data
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "~/Data/household_power_consumption.zip")
        unzip(zipfile = "~/data/household_power_consumption.zip", exdir = "~/data")
        
        # Set working directory
        datasetPath <- "~/data/"
        setwd(file.path(datasetPath, "ExData_Plotting1"))
        
        powerDataset <- tbl_df(read.table(file.path(datasetPath,"household_power_consumption.txt"), header = TRUE, sep = ";", 
                                          na.strings = "?", colClasses = c("character", "character", rep("numeric",7))))
        
        powerDataset$Time <- strptime(paste(powerDataset$Date, powerDataset$Time), "%d/%m/%Y %H:%M:%S")
        
        powerDataset$Date <- as.Date(powerDataset$Date, "%d/%m/%Y")
        
        powerSubset <- subset(powerDataset, Date == "2007-02-01" | Date == "2007-02-02")
}

png("plot3.png", width = 500, height = 500)

with(powerSubset, plot(Time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l"))
with(powerSubset, lines(Time, Sub_metering_2, col = "red"))
with(powerSubset, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", col = c("black","red","blue"), c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1)

dev.off()