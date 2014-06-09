pollutantmean <- function(directory, pollutant, id = 1:332) {
    count <- 1    datas <- vector("list", length(id))
    for (i in id) {        name <- paste(directory, "/", sprintf("%03i", as.integer(i)), ".csv", sep = "")        data <- read.csv(name)        datas[[count]] <- data        count <- count +1    }
	df <- do.call(rbind, datas)
	
	length <- length(id)
	first <- id[1]
	last <- id[length]
	usedDf <- subset(df, df$ID >= first & df$ID <= last)
	if(pollutant == "sulfate") {
		sulMean <- mean(usedDf$sulfate, na.rm=TRUE)
		round(sulMean, 3)
	} else if(pollutant == "nitrate") {
		nitMean <- mean(usedDf$nitrate, na.rm=TRUE)
		round(nitMean, 3)
	}}

#data.rbind <- NA
# for(i in id ){
#   file.name <- paste(directory, "/", sprintf("%03i", as.integer(i)), ".csv", sep = "")
#   data <- read.csv(file.name,header=T)
#   data.rbind <- rbind(data,data.rbind)
# }