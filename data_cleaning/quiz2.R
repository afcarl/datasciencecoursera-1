# week 2 quiz, questions 1-5

# question 1

library(httr)
library(jsonlite)

myapp <- oauth_app("github", key="6801db10594797048be5", secret="2aeeabeef117ba34f2099358b415a807bf6435b1")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token=github_token)

data <- GET("https://api.github.com/users/jtleek/repos", gtoken)
j <- fromJSON(content(data, "text"))
answer = j[j$name=="datasharing", "created_at"]
print("1"); print(answer)


# question 2
library(sqldf)
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "acs.csv")
acs <- read.csv("acs.csv")
answer <- sqldf("select pwgtp1 from acs where AGEP < 50")


# question3
answer <- sqldf("select distinct AGEP from acs")

# question 4
html <- readLines("http://biostat.jhsph.edu/~jleek/contact.html")
lines <- html[c(10,20,30,100)]
answer <- nchar(lines)
print("4"); print(answer)


# question 5
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", destfile="weeklysst.dat")
library(data.table)
data <- read.fwf("weeklysst.dat", skip=4, widths=c(15, 4, 9, 4, 9, 4, 9, 4, 9))
answer <- sum(data[,4])
print("5"); print(answer)





