# read the large stormdata file (but only the relevant columns) and convert some basic column types
library(data.table)
library(lubridate)

if(!file.exists("StormData.csv.bz2")) {
    download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", method="curl", destfile="StormData.csv.bz2")
}

stormdata <- fread("bzcat StormData.csv.bz2", stringsAsFactors = FALSE, select=c("EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP", "CROPDMG", "CROPDMGEXP"))
# stormdata$BGN_DATE <- mdy_hms(stormdata$BGN_DATE)
# stormdata$END_DATE <- mdy_hms(stormdata$END_DATE)
# stormdata$STATE <- factor(stormdata$STATE)
stormdata$EVTYPE <- factor(stormdata$EVTYPE)
