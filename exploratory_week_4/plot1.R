# Have total emissions from PM2.5 decreased in the US from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission
# from all sources for each of the years 1999, 2002, 2005, and 2008.

message("reading data...")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
totals <-
    NEI %>%
    group_by(year) %>%
    summarize(total=sum(Emissions, na.rm=TRUE))

png("plot1.png")
plot(totals, ylab="Total Emission (tons)", pch=15)
title("emission decreases")
abline(lm(totals$total ~ totals$year), col=4)
dev.off()

delta <- totals[totals$year==2008,2] - totals[totals$year==1999,2]
message("emission tonnes delta 1999-2008: ", delta)
