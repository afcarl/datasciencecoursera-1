rankhospital <- function(state, outcome, num="best") {
    # read outcome data
    outcomes <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available", stringsAsFactors=FALSE)
    outcomes_columns = c("heart attack"=11, "heart failure"=17, "pneumonia"=23)

    # check that state and outcome data are valid
    if (!(state %in% outcomes$State)) {
        stop("invalid state")
    }
    if (!(outcome %in% names(outcomes_columns))) {
        stop("invalid outcome")
    }

    # return hospital name in that state with desired outcome
    data <- outcomes[, c(7, outcomes_columns[outcome], 2)]
    names(data) <- c("state", "outcome", "hospital")

    data <- data[data$state==state, ]
    data <- data[order(data$outcome, data$hospital, na.last=NA), ]

    # select the desired ranked hospital
    if(num=="best") {
        head(data,1)$hospital   # returns the hospital with the lowest (best) outcome
    } else if (num=="worst") {
        tail(data,1)$hospital   # returns the hospital with the highest (worst) outcome
    } else if (is.numeric(num)) {
        if(num>nrow(data)) {
            NA
        } else {
            data[num,]$hospital
        }
    } else {
        NA
    }

}