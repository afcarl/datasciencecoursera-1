# Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting
# system to make a plot answering this question.

message("reading data...")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
totals <-
    NEI %>%
    filter(fips=="24510") %>%
    group_by(year) %>%
    summarize(total=sum(Emissions, na.rm=TRUE))

png("plot2.png")
plot(totals, ylab="Total Emission in Baltimore City (tons)", pch=15)
title("emission decreases in Baltimore")
abline(lm(totals$total ~ totals$year), col=4)
dev.off()

delta <- totals[totals$year==2008,2] - totals[totals$year==1999,2]
message("emission tonnes delta 1999-2008: ", delta)
