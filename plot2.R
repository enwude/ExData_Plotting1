#Load relevant libraries
library(dplyr)
library(data.table)


# Create working directory if necessary
if(!file.exists("~/Data/")){
        dir.create("~/Data/")
}

# Determine if dataset has been loaded to global environment
if(!exists("powerSubset", envir = globalenv())){
        
        # Download and unzip the data
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "~/Data/household_power_consumption.zip")
        unzip(zipfile = "~/data/household_power_consumption.zip", exdir = "~/data")
        
        # Set working directory
        datasetPath <- "~/data/"
        setwd(file.path(datasetPath, "ExData_Plotting1"))
        
        # Read data to R
        powerDataset <- tbl_df(read.table(file.path(datasetPath,"household_power_consumption.txt"), header = TRUE, sep = ";", 
                                          na.strings = "?", colClasses = c("character", "character", rep("numeric",7))))
        
        # Convert Time variable to Time class
        powerDataset$Time <- strptime(paste(powerDataset$Date, powerDataset$Time), "%d/%m/%Y %H:%M:%S")
        
        # Convert Date variable to Date class
        powerDataset$Date <- as.Date(powerDataset$Date, "%d/%m/%Y")
        
        # Subset relevant data
        powerSubset <- subset(powerDataset, Date == "2007-02-01" | Date == "2007-02-02")
}

# Launch png graphics device
png("plot2.png", width = 500, height = 500)

# Plot Global Active Power vs Time
with(powerSubset, plot(Time, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l"))

# Close graphics device
dev.off() 