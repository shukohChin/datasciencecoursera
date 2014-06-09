complete <- function(directory, id = 1:332) {
    count <- 1
    datas <- vector("list", length(id))
    for (i in id) {
        name <- paste(directory, "/", sprintf("%03i", as.integer(i)), ".csv", sep = "")
        data <- read.csv(name)
        datas[[count]] <- data
        count <- count +1
    }
	df <- do.call(rbind, datas)
	usedDf <- na.omit(df)
	
	nobs <- vector()
	for(j in 1:length(id)) {
		k <- id[j]
		nobs[j] <- nrow(subset(usedDf, usedDf$ID == k))
	}
	
	data.frame(id, nobs)
}