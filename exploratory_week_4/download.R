# download and unzip the raw data 

if(!file.exists("data.zip")) {
    message("downloading data...")
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "data.zip")
} else {
    message("already downloaded")
}

unzip("data.zip", exdir=".")
