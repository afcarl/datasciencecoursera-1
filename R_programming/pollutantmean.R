pollutantmean <- function(directory, pollutant, id=1:332) {
  
  csvfiles <- file.path(directory, paste(sprintf("%03d",id), ".csv", sep=""))
  
  numbers <- c()
  for(csvfile in csvfiles) {
    csv <- read.csv(csvfile)
    pollutions <- csv[[pollutant]]
    pollutions <- pollutions[!is.na(pollutions)]
    numbers <- append(numbers, pollutions)
  }
  
  mean(numbers, na.rm = TRUE)
}
