# Across the United States, how have emissions from
# coal combustion-related sources changed from 1999–2008?

message("reading data...")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

scc_coal <- SCC[grep("[Cc]oal", SCC$EI.Sector), 1]
NEI_coals <- NEI[NEI$SCC %in% scc_coal, ]

totals <- NEI_coals %>%
    group_by(year) %>%
    summarize(total=sum(Emissions, na.rm=TRUE))

png("plot4.png")
plot(totals, pch=15, ylab="Coal combustion total in the US", ylim=c(300000, 700000))
title("Coal Combustion Emission decreased in the US")
abline(lm(totals$total ~ totals$year), col=4)
dev.off()
