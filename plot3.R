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

with(ElecPwrCon,
     plot(Time,
          Sub_metering_1,
          type = "l", 
          xlab = "", 
          ylab = "Energy sub Meeting",
          col = "black"))

points(ElecPwrCon$Time,
       ElecPwrCon$Sub_metering_2,
       type = "l",
       xlab = "", 
       ylab = "",
       col = "red")

points(ElecPwrCon$Time,
       ElecPwrCon$Sub_metering_3,
       type = "l",
       xlab = "",
       ylab = "",
       col = "blue")

legend("topright", 
       lty = c(1, 1, 1),
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png")

dev.off()
