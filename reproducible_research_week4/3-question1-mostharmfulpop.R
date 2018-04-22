# question 1,
# 'Across the United States, which types of events (as indicated in the EVTYPE variable) 
# are most harmful with respect to population health?'

library(dplyr)
library(ggplot2)


top_ten_fatalities <- stormdata %>% 
    group_by(EVTYPE) %>% 
    summarize(fatalities=sum(FATALITIES)) %>% 
    arrange(desc(fatalities)) %>%
    top_n(10)

top_ten_injuries <- stormdata %>% 
    group_by(EVTYPE) %>% 
    summarize(injuries=sum(INJURIES)) %>% 
    arrange(desc(injuries)) %>%
    top_n(10)

# make the event type an ordered factor, so the plotting keeps the x axis sort order:
top_ten_fatalities$EVTYPE = factor(top_ten_fatalities$EVTYPE, levels=top_ten_fatalities$EVTYPE)
top_ten_injuries$EVTYPE = factor(top_ten_injuries$EVTYPE, levels=top_ten_injuries$EVTYPE)

print(top_ten_fatalities)
print(top_ten_injuries)


plot <- ggplot(top_ten_fatalities, aes(x=EVTYPE, y=fatalities)) +
    geom_bar(stat="identity") +
    ylim(0, 6000) +
    labs(x="Event", y="Fatalities", title="Top 10 fatalities per storm event\nsource: US National Weather Service Storm Data 1950-2011") +
    theme(axis.text.x=element_text(angle=70, hjust=1))

print(plot)

plot <- ggplot(top_ten_injuries, aes(x=EVTYPE, y=injuries)) +
    geom_bar(stat="identity") +
    ylim(0, 100000) +
    labs(x="Event", y="Injuries", title="Top 10 injuries per storm event\nsource: US National Weather Service Storm Data 1950-2011") +
    theme(axis.text.x=element_text(angle=70, hjust=1))

print(plot)
