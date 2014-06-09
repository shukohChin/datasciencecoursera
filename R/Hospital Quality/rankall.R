rankall <- function(outcome, num = "best") {
    ## Read outcome data
    outcome.data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
    
    ## Check that state and outcome are valid
    data <- subset(outcome.data, select=c(2, 7, 11, 17, 23))
    colnames <- c("hosname", "State", "heart attack", "heart failure", "pneumonia")
    colnames(data) <- colnames
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    # n is the col number of outcome
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
    # clear the NA values
    out.data <- data[!is.na(data[, n]),]
    states <- levels(as.factor(out.data$State))
    state.num <- length(state)
    result <- data.frame("hospital" = rep(NA, state.num), "state" = rep(NA, state.num))
    rank <- num
    count <- 1
    for(state in states) {
    	state.data <- subset(out.data, out.data$State == state)
    	hos.num <- length(state.data$hosname)
		if (num == "best") {
    		rank = 1
    	} else if (num == "worst") {
    		rank = hos.num
    	} else if (num > hos.num) {
    		result[count, "hospital"] <- NA
    		result[count, "state"] <- state    	
    		count <- count + 1	
    		next
    	}
    	order.data <- state.data[order(state.data[,n], state.data[, "hosname"]), ]
    	result[count, "hospital"] <- order.data$hosname[rank]
    	result[count, "state"] <- state 
    	count <- count + 1
    } 
    result
}

