corr <- function(directory, threshold=0) {
	comp <- complete(directory)
	comp <- subset(comp, comp$nobs > threshold)
	count <- 1
    rownum <- nrow(comp)
	datas <- rep(0, times=rownum)
    if(rownum > 0) {
    	for (i in 1:rownum) {
			j <- comp$id[i]
        	name <- paste(directory, "/", sprintf("%03i", as.integer(j)), ".csv", sep = "")
        	data <- na.omit(read.csv(name))
        	datas[i] <- cor(data$nitrate, data$sulfate)

        	count <- count +1
    	}
    }
	
	datas
}