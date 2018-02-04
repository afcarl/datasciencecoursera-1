# Compare emissions from motor vehicle sources in Baltimore City (fips == "24510") with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?


message("reading data...")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

scc_vehicles <- SCC[grep("[Vv]eh", SCC$Short.Name), 1]

totals <- NEI %>%
    filter(fips %in% c("24510","06037") & SCC %in% scc_vehicles) %>%
    group_by(year, fips) %>%
    summarize(total=sum(Emissions, na.rm=TRUE)) %>%
    group_by(fips)

baltimore <- subset(totals, totals$fips=="24510", select=c("year", "total"))
losangeles <- subset(totals, totals$fips=="06037", select=c("year", "total"))

png("plot6.png")
plot(losangeles, pch=15, ylab="Emission", col=4, ylim=c(0, 5000))
lines(losangeles, col=4)
points(baltimore, pch=15, col=2)
lines(baltimore, col=2)
title("Baltimore vs Los Angeles County")
dev.off()
