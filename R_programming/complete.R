complete <- function(directory, id=1:332) {
  
  nobs = c()
  for(file_id in id) {
    csvfile <- file.path(directory, paste(sprintf("%03d",file_id), ".csv", sep=""))
    csv <- read.csv(csvfile)
    num_complete <- sum(complete.cases(csv))
    nobs <- c(nobs, num_complete)
  }
  
  data.frame(id=id, nobs=nobs)
}
