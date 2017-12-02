# week 3 questions
# question 1

library(dplyr)
comm <- read.csv("housingidaho.csv")
agricultureLogical <- comm$ACR==3 & comm$AGS==6
answer <- head(which(agricultureLogical), 3)
print("answer1"); print(answer)

# question 2
library(jpeg)
library(readr)
if(!file.exists("jeff.jpg")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile="jeff.jpg")
}
pic <- readJPEG("jeff.jpg", native=TRUE)
answer <- quantile(pic, probs=c(0.3, 0.8))
print("answer2"); print(answer)

# question 3
if(!file.exists("gdp.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="gdp.csv")
}
if(!file.exists("edstats.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile="edstats.csv")
}

gdp <- read.csv("gdp.csv", header=FALSE, skip=5, stringsAsFactors = FALSE)
gdp <- gdp[, c(1,2,4,5)]    # strip columns
names(gdp) <- c("CountryCode", "rank", "countryname", "gdp")    # rename
gdp <- filter(gdp, CountryCode!="", rank!="")   # remove empty
gdp <- mutate(gdp, rank=parse_number(rank), gdp=parse_number(gdp))   # fix numbers
edstats <- read.csv("edstats.csv", stringsAsFactors = FALSE)
merged <- merge(edstats, gdp, by.x="CountryCode", by="CountryCode", all=FALSE)
merged <- merged[order(merged$gdp),]
answer1 <- nrow(merged)
answer2 <- merged[13, "Long.Name"]
print("answer3"); print(answer1); print(answer2)

# question 4
grouped_by_incomegrp <- group_by(merged, Income.Group)
rankings <- dplyr::summarize(grouped_by_incomegrp, mean=mean(rank))
print("answer4"); print(rankings)

# question 5
dt <- tbl_df(merged) %>%
    select(Income.Group, rank) %>%
    mutate(quant = cut2(rank, g=5))        #  cut2 from hmisc g=number of quantile groups
answer <- group_by(dt, Income.Group, quant) %>%
    dplyr::summarize(num=n()) %>%
    filter(Income.Group=="Lower middle income", quant=="[  1, 39)")
print("answer 5"); print(answer)
