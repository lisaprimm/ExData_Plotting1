#############################################################################
#
# plot4.R
#
# by Lisa M. Primm
#
# Exploratory Data Analysis Class
#
#############################################################################
# Download and Unzip the .zip file containing the data files.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localZipFile <- "./exdata-data-household_power_consumption.zip"
dataFile <- "./household_power_consumption.txt"
if (!file.exists(localZipFile)) { download.file(fileUrl, localZipFile, method = "curl")}
if (!file.exists(dataFile)) { unzip(localZipFile) }

# Read in the data table.  Just the data we want and assign correct variable names
hPDColumns <- c("Date", "Time", "Global_active_power",
                "Global_reactive_power", "Voltage", "Global_intensity",
                "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
housePowerData <- read.table(dataFile, sep = ";", stringsAsFactors = FALSE,
                             col.names = hPDColumns, skip = 66637, nrows = 2880)

# Add extra column to combine Date and Time into a single variable
housePowerData$DateTime <- strptime(paste(housePowerData$Date, housePowerData$Time),
                                    format = "%d/%m/%Y %H:%M:%S")

# Plot data into png file
xNameDT <- "datetime"
yName1 <- "Global Active Power"
yName2 <- "Voltage"
yName3 <- "Energy sub metering"
yName4 <- "Global_reactive_power"
png(file="plot4.png",width=480,height=480)
par(mfrow = c(2,2))

# plot 1 of 4
plot(housePowerData$DateTime, housePowerData$Global_active_power,
     type = "l", main = "", xlab = "", ylab = yName1)

# plot 2 of 4
plot(housePowerData$DateTime, housePowerData$Voltage,
     type = "l", main = "", xlab = xNameDT, ylab = yName2)

# plot 3 of 4
plot(housePowerData$DateTime, housePowerData$Sub_metering_1,
     type = "l", main = "", xlab = "", ylab = yName)
lines(housePowerData$DateTime, housePowerData$Sub_metering_2, col = "red")
lines(housePowerData$DateTime, housePowerData$Sub_metering_3, col = "blue")
legend("topright", lty = c("solid", "solid", "solid"),
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

# plot 4 of 4
plot(housePowerData$DateTime, housePowerData$Global_reactive_power,
     type = "l", main = "", xlab = xNameDT, ylab = yName4)

# Main Title
mtext("", outer = TRUE)

# Close graphics device (.png file)
dev.off()
