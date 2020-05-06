fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "ElecPwrCon.zip")

library(lubridate)

rowsDesired <- c("2007-02-01", "2007-02-02")

unzip("ElecPwrCon.zip")
temporary <- read.table("household_power_consumption.txt",
                        header = TRUE,
                        sep = ";",
                        na.strings = "?")

temp <- temporary

temp$Date <- as.character(temp$Date)
temp$Time <- as.character(temp$Time)
temp$Time <- paste(temp$Date, temp$Time)
temp$Time <- strptime(temp$Time, format = "%d/%m/%Y %H:%M:%S")
temp$Date <- as.Date(temp$Date, format = "%d/%m/%Y")

ElecPwrCon <- temp[c(which(temp$Date == "2007-2-01"), which(temp$Date == "2007-02-02")),]

with(ElecPwrCon, plot(Time, Global_active_power, type = "l", 
                      xlab = "", 
                      ylab = "Global Active Power (kilowatts)"))

dev.copy(png, file = "plot2.png")

dev.off()