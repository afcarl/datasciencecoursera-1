
rankall <- function(outcome, num="best") {
    # read outcome data
    outcomes <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available", stringsAsFactors=FALSE)
    outcomes_columns = c("heart attack"=11, "heart failure"=17, "pneumonia"=23)

    # check that outcome data is valid
    if (!(outcome %in% names(outcomes_columns))) {
        stop("invalid outcome")
    }

    # helper function
    findhospital <- function(data) {
        # select the desired ranked hospital (returns state + hospital)
        data <- data[order(data$outcome, data$hospital, na.last=NA), ]
        if(num=="best") {
            best <- head(data, 1)
            best$hospital
            #c(state=best$state, hospital=best$hospital)
        } else if (num=="worst") {
            worst <- tail(data, 1)
            worst$hospital
            #c(state=worst$state, hospital=worst$hospital)
        } else if (is.numeric(num)) {
            if(num>nrow(data)) {
                NA   # c(NA, NA) ?
            } else {
                ranked <- data[num,]
                ranked$hospital
                #c(state=ranked$state, hospital=ranked$hospital)
            }
        } else {
            NA  # c(NA, NA)?
        }
    }

    # for each state, find the hospital of the given rank
    # return data frame with hospital name and the state
    hospitaldata <- outcomes[, c(7, outcomes_columns[outcome], 2)]
    names(hospitaldata) <- c("state", "outcome", "hospital")
    per_state <- split(hospitaldata, hospitaldata$state)
    results <- lapply(per_state, findhospital)
    results <- data.frame(hospital=unlist(results), state=names(results))   # turn into dataframe
    results
    #results
    #results <- cbind(results, names(results))    # make matrix
    #results <- data.frame(results)   # make into dataframe
    #names(results) <- c("hospital", "names")
    #results
}
