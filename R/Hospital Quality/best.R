best <- function(state, outcome) {
    ## Read outcome data
    outcome.data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
    
    ## Check that state and outcome are valid
    data <- subset(outcome.data, select=c(2, 7, 11, 17, 23))
    colnames <- c("hosname", "State", "heart attack", "heart failure", "pneumonia")
    colnames(data) <- colnames
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    n <- match(outcome, colnames)
    if (is.na(n)) {
    	stop("invalid outcome")
    }
    if (is.na(match(state, data$State))) {
    	stop("invalid state")
    }
    

    ## Return hospital name in that state with lowest 30-day death
    ## rate
    for (o in outcomes) {
    	data[, o] <- as.numeric(data[, o])
    }
    out.data <- data[!is.na(data[, n]),]
    state.data <- subset(out.data, out.data$State == state)
    min <- state.data[which.min(state.data[, n]), n]
    best.data <- subset(state.data, state.data[, n] == min)
    best.data[order(best.data$hosname),]$hosname[1]
}

