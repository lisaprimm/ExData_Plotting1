#############################################################################
#
# plot1.R
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
plot1Name <- "Global Active Power"
unitsName <- " (kilowatts)"
png(file="plot1.png",width=480,height=480)
hist(housePowerData$Global_active_power, col = "red",
     main = plot1Name, xlab = paste(plot1Name, unitsName),
     ylab = "Frequency", ylim = c(0, 1200))
dev.off()
