corr <- function(directory, threshold=0)
{
  above_thresh <- subset(complete(directory), nobs>threshold)

  correlations <- vector(mode="numeric", length=0)
  
  for(file_id in above_thresh$id) {
    csvfile <- file.path(directory, paste(sprintf("%03d",file_id), ".csv", sep=""))
    csv <- read.csv(csvfile)
    
    complete_obs = csv[!is.na(csv$sulfate) & !is.na(csv$nitrate),]
    correlation <- cor(complete_obs$sulfate, complete_obs$nitrate)
    # alternatief: correlation <- cor(csv$sulfate, csv$nitrate, use="complete.obs")
    
    correlations <- c(correlations, correlation)
  }  

  correlations
}