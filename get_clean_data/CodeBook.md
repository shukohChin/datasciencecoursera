Getting and Cleaning Data
========================================================

In this document, the variables, the data, and any transformations or work that I performed would be explained.

## Description of variables
  Variables in the tidy data set would be explained.  
- subject  
  **subject** is [numerical variable]. It represents the volunteer who perform the activity. There are 30 volunteers here, so subject would be an integer between 1 to 30. 
- activity  
  **activity** is [categorical variable]. It represents six activities wearing a smartphone(Samsung Galaxy S II) on the waist. The six activities are (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING).  
- features that were measured  
  There are 561 kinds of measurements with time and frequency provided in the raw data. Information of feature meaning can be found at features_info.txt in [UCI HAR Dataset] folder.

## Naming strategy
According to [Google's R style Guide](https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml#identifiers), naming strategy when coding is listed below.  
- Not use underscores(_) or hyphens(-) in variable names
- First letter of function name is Capital
- *variable.name* is preferred, *variableName*(camel style) is accepted
- Place spaces around all binary operators (=, +, -, <-, etc.)

## How data was process
#### Before(See README.md)
- Download the raw data
- Unzip the data.

#### Process
- Read the data into R  
In this step, we read data into R. According to "README.txt" in the [UCI HAR Dataset] folder, we can ignore the [Inertial Signals] folder because these information have already been contained in X\_train.txt and X\_test.txt. We will also know, files we need are like below.(Reference 1)
![files needed](https://coursera-forum-screenshots.s3.amazonaws.com/d3/2e01f0dc7c11e390ad71b4be1de5b8/Slide2.png)  
So we load each file in test folder and train folder.  

```r
x.train <- read.table(paste0(getwd(), "/UCI HAR Dataset/train/X_train.txt"))
subject.train <- read.table(paste0(getwd(), "/UCI HAR Dataset/train/subject_train.txt"))
y.train <- read.table(paste0(getwd(), "/UCI HAR Dataset/train/Y_train.txt"))
x.test <- read.table(paste0(getwd(), "/UCI HAR Dataset/test/X_test.txt"))
subject.test <- read.table(paste0(getwd(), "/UCI HAR Dataset/test/subject_test.txt"))
y.test <- read.table(paste0(getwd(), "/UCI HAR Dataset/test/Y_test.txt"))
```

- merge the training and the test sets of X, subject, and Y.

```r
data <- rbind(x.train, x.test)
subject <- rbind(subject.train, subject.test)
activity <- rbind(y.train, y.test)
```

- read features.txt into R and then create a new column(V3) containing new feature names.  
Feature name in the features.txt are like "tBodyAcc-mean()-X". Here we replace "-" and "()" to empty string. So "tBodyAcc-mean()-X" will become "tBodyAccmeanX".

```r
features <- read.table(paste0(getwd(), "/UCI HAR Dataset/features.txt"))
features$V3 <- gsub("[(),-]", "", features$V2)
```

- set colnames of the data.

```r
colnames(data) <- features$V3
colnames(subject) <- c("subject")
colnames(activity) <- c("activity")
```

- extracts only the measurements on the mean and standard deviation for each measurement.  
According to features_info.txt,  
 + mean(): Mean value
 + std(): Standard deviation
 + meanFreq(): Weighted average of the frequency components to obtain a mean frequency  

  Although meanFreq() is not a direct mean measurement, it is still a **mean** frequency, so I assume that names which contain "mean" or "std" are the measurements on the mean and standard deviation. We may also see some variable names contain "Mean" in angle() function, they won't be included because they are for angle measurements.

```r
tidy.features <- grep("std|mean", features$V2)
tidy.features.data <- subset(data, select = names(data)[tidy.features])
```

- merge subject, activity, and data that only measures on the mean and standard deviation.  
So far, requirement 1,2,4 of run_analysis.R have been completed.

```r
result.data <- cbind(subject, activity, tidy.features.data)
```


- use descriptive activity names to name the activities in the data set.  
In this step, requirement 3 has been completed.

```r
activity.label <- read.table(paste0(getwd(), "/UCI HAR Dataset/activity_labels.txt"))
act.name.merged.data <- merge(activity.label, result.data, by.x = "V1", by.y = "activity", 
    all = TRUE)
tidy.data <- subset(act.name.merged.data, select = -c(V1))
names(tidy.data)[names(tidy.data) == "V2"] <- "activity"
```

- create a tidy data set with the average of each variable for each activity and each subject.  
In this step, requirement 5 has been completed.

```r
library(reshape2)
melt.tidy.data <- melt(tidy.data, id = c("subject", "activity"))
cast.data <- dcast(melt.tidy.data, subject + activity ~ variable, fun.aggregate = mean)
write.table(cast.data, "tidyData.txt", sep = "\t")
```



## References:
- Getting and Cleaning Data discussion forum, [What files to use?](https://class.coursera.org/getdata-003/forum/thread?thread_id=90)
