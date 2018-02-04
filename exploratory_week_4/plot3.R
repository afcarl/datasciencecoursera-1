# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from
# 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

message("reading data...")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

totals <-
    NEI %>%
    filter(fips=="24510") %>%
    group_by(year, type) %>%
    summarize(total_by_type=sum(Emissions, na.rm=TRUE))

png("plot3.png")

emissions.type <- ggplot(totals, aes(year, total_by_type)) + geom_point(size=4)
emissions.type <- emissions.type +
    facet_grid(. ~ type) +
    geom_smooth(method="lm", se=FALSE) +
    xlab("Year") + ylab("Total Emissions (tonnes)") +
    ggtitle("Total Emissions in Baltimore by Source Type, only POINT increased")

print(emissions.type)
dev.off()
