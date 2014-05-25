RunAnalysis <- function() {
  # assume the UCI CHAR Dataset and R script to be in the working directory
  # create a txt file of tidy data required
  x.train <- read.table(paste0(getwd(), '/UCI HAR Dataset/train/X_train.txt'))
  subject.train <- read.table(paste0(getwd(), '/UCI HAR Dataset/train/subject_train.txt'))
  y.train <- read.table(paste0(getwd(), '/UCI HAR Dataset/train/Y_train.txt'))
  
  x.test <- read.table(paste0(getwd(), '/UCI HAR Dataset/test/X_test.txt'))
  subject.test <- read.table(paste0(getwd(), '/UCI HAR Dataset/test/subject_test.txt'))
  y.test <- read.table(paste0(getwd(), '/UCI HAR Dataset/test/Y_test.txt'))
  
  data <- rbind(x.train, x.test)
  subject <- rbind(subject.train, subject.test)
  activity <- rbind(y.train, y.test)
  
  features <- read.table(paste0(getwd(), '/UCI HAR Dataset/features.txt'))
  features$V3 <- gsub("[(),-]", "", features$V2)
  
  colnames(data) <- features$V3
  colnames(subject) <- c("subject")
  colnames(activity) <- c("activity")
  
  tidy.features <- grep("std|mean", features$V2)
  tidy.features.data <- subset(data, select = names(data)[tidy.features])
  
  result.data <- cbind(subject, activity, tidy.features.data)
  
  activity.label <- read.table(paste0(getwd(), '/UCI HAR Dataset/activity_labels.txt'))
  act.name.merged.data <- merge(activity.label, result.data, by.x = "V1", by.y = "activity", all = TRUE)
  tidy.data <- subset(act.name.merged.data, select = -c(V1))
  names(tidy.data)[names(tidy.data) == 'V2'] <- 'activity'
  
  library(reshape2)
  melt.tidy.data <- melt(tidy.data, id = c("subject","activity"))
  cast.data <- dcast(melt.tidy.data, subject + activity ~ variable, fun.aggregate = mean)
  write.table(cast.data, "tidyData.txt", sep = "\t")
}

