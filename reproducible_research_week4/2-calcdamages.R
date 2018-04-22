
# convert the damage numbers into actual numbers based on the 'exponent' column (PROPDMGEXP and CROPDMGEXP)
# definition of the values of these columns is a bit vague, but is partly explained
# on page 12 of the "NATIONAL WEATHER SERVICE STORM DATA DOCUMENTATION" (chapter 2.7, 'Damage')
# and, thanks to a helpful soul on the forum, in a lot more detail here https://rstudio-pubs-static.s3.amazonaws.com/58957_37b6723ee52b455990e149edde45e5b6.html

library(dplyr)


exps <- data.table(
    expchar = c("", "-", "+", "?", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "H", "h", "K", "k", "M", "m", "B", "b"),
    factor = c(0, 0, 1, 0, 1e0, 1e1, 1e2, 1e3, 1e4, 1e5, 1e6, 1e7, 1e8, 1e9, 100, 100, 1000, 1000, 1e6, 1e6, 1e9, 1e9)
)

stormdata <- stormdata %>%
    left_join(exps, by=c("PROPDMGEXP" = "expchar"), suffix=c(".prop", ".crop")) %>%
    left_join(exps, by=c("CROPDMGEXP" = "expchar"), suffix=c(".prop", ".crop"))  %>%
    mutate(propdmg_amount=PROPDMG*factor.prop, cropdmg_amount=CROPDMG*factor.crop)


# the total damage amount is the property damage and crop damage combined.

stormdata$total_damage <- stormdata$propdmg_amount+stormdata$cropdmg_amount
