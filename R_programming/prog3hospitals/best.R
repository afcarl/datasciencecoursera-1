best <- function(state, outcome) {

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

    # return hospital name in that state with lowest 30-day death
    data <- outcomes[, c(7, outcomes_columns[outcome], 2)]
    names(data) <- c("state", "outcome", "hospital")

    data <- data[data$state==state, ]

    data <- data[order(data$outcome, data$hospital, na.last=NA), ]

    head(data,1)$hospital   # returns the hospital with the lowest (best) outcome
}
