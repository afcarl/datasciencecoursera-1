# week 1 question 1-5

# download.file(url='https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile='housingidaho.csv')
csv <- read.csv('housingidaho.csv')
answer <- length(csv[which(csv$VAL==24), 'VAL'])
print(c("answer1", answer))


#download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", destfile="naturalgas.xlsx")

library(xlsx)
dat<-read.xlsx("naturalgas.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex=7:15)
answer <- sum(dat$Zip*dat$Ext,na.rm=T)
print(c("answer3", answer))


# download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", destfile="restaurants.xml")
library(XML)
restdata <- xmlTreeParse("restaurants.xml", useInternal=TRUE)
restdata <- xmlRoot(restdata)[[1]]    # <row> contains all <row> elements

num_zipcodes <- length(xpathSApply(restdata, "//zipcode[text()='21231']"))
print(c("answer4", num_zipcodes))

zipcodes <- xpathSApply(restdata, "//zipcode", xmlValue)
num_zipcodes2 = sum(zipcodes==21231)
print(c("answer4b", num_zipcodes2))


#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile="comm.csv")
library(data.table)
DT<-fread("comm.csv")


# ??????
bench <- function(what) {
    system.time(replicate(10000, what))
}
result <- bench(sapply(split(DT$pwgtp15,DT$SEX),mean))
print("1"); print(result)
result <- bench(DT[,mean(pwgtp15),by=SEX])
print("2"); print(result)
result <- bench(c(mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15)))
print("3"); print(result)
result <- bench(tapply(DT$pwgtp15,DT$SEX,mean))
print("4"); print(result)
result <- bench(mean(DT$pwgtp15,by=DT$SEX))
print("5"); print(result)
result <- bench(c(rowMeans(DT)[DT$SEX==1], rowMeans(DT)[DT$SEX==2]))
print("6"); print(result)
