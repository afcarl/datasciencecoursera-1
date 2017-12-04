# quiz 4

# question 1
if(!file.exists("housingidaho.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "housingidaho.csv")
}

housing <- read.csv("housingidaho.csv")
answer = strsplit(names(housing), "wgtp")[[123]]
print("answer1"); print(answer)

# question 2
if(!file.exists("gdp.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "gdp.csv")
}

gdp <- read.csv("gdp.csv", skip=5, header=FALSE, col.names = c("CountryCode", "rank", "", "countryname", "gdp", "", "", "", "", ""))
gdp <- gdp[gdp$rank != "", ]
answer <- mean(as.numeric(gsub(",", "", gdp$gdp)), na.rm = TRUE)
print("answer2"); print(answer)


# question 3
answer <- length(grep("^United", gdp$countryname))
print("answer 3"); print(answer)


# question 4

if(!file.exists("edstats.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "edstats.csv")
}

edstats <- read.csv("edstats.csv", stringsAsFactors = FALSE)
merged <- merge(edstats, gdp, by="CountryCode", all=FALSE)
# have_fiscal_year <- startsWith(merged$Special.Notes, "Fiscal year")
have_fiscal_year <- grepl("^Fiscal.year", merged$Special.Notes)
with_fy <- merged[which(have_fiscal_year), ]
answer <- length(with_fy[grepl("June", with_fy$Special.Notes),1])
print("question 4"); print(answer)


# question 5
library(quantmod)
amzn <- getSymbols("AMZN", auto.assign=FALSE)
sampletimes <- index(amzn)
sampletimes <- as.POSIXlt(sampletimes)
answerA = sum(sampletimes$year==112)
answerB = sum(sampletimes$wday==1 & sampletimes$year==112)
print("question5"); print(answerA); print(answerB)

