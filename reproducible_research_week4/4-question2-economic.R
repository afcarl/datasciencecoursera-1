# question 2,
# 'Across the United States, which types of events
# have the greatest economic consequences?'

library(dplyr)
library(ggplot2)



top_ten_damage <- stormdata %>% 
    group_by(EVTYPE) %>% 
    summarize(total_prop_damage=sum(propdmg_amount), total_crop_damage=sum(cropdmg_amount)) %>% 
    arrange(desc(total_prop_damage+total_crop_damage)) %>%
    top_n(10)

# make the event type an ordered factor, so the plotting keeps the x axis sort order:
top_ten_damage$EVTYPE = factor(top_ten_damage$EVTYPE, levels=top_ten_damage$EVTYPE)

print(top_ten_damage)


top_ten.molten = melt(top_ten_damage, 'EVTYPE')
    
plot <- ggplot(top_ten.molten, aes(x=EVTYPE, y=value/1e6, fill=variable)) +
    geom_bar(stat="identity") +
    ylim(0, 160000) +
    labs(x="Event", y="million $ Damage", title="Top 10 total (property+crop) damage per storm event\nsource: US National Weather Service Storm Data 1950-2011") +
    scale_fill_manual(values=c("purple", "navy"), name="damage type", labels=c("property", "crops")) +
    theme(axis.text.x=element_text(angle=70, hjust=1))

print(plot)
