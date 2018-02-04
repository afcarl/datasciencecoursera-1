# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


message("reading data...")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

scc_vehicles <- SCC[grep("[Vv]eh", SCC$Short.Name), 1]

totals <- NEI %>%
    filter(fips=="24510" & SCC %in% scc_vehicles) %>%
    group_by(year) %>%
    summarize(total=sum(Emissions, na.rm=TRUE))

png("plot5.png")
plot(totals, pch=15, ylab="Emission", ylim=c(0, 400))
title("Motor vehicle emission decrease in Baltimore")
abline(lm(totals$total ~ totals$year), col=4)
dev.off()
