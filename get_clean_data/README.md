Getting and Cleaning Data Project
========================================================

## summary  
In this project, data collected from the accelerometers from the Samsung Galaxy S smartphone would be processed, and tidy data that can be used for analysis is prepared. For more information of the raw data, see [Human Activity Recognition Using Smartphones Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). You can also download the data from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## submitting files
In this project, three files listed below were uploaded. 
- 'README.md'  
  Explain the summary of this project, files contained in the assignment, and the way how to run the script file.
- 'CodeBook.md'  
  Describes the variables, the data, and any transformations or work that I performed to clean up the data.
- 'run_analysis.R'  
  A script file that can be run as long as the Samsung data is in working directory.

## how to run script
- Start with the [UCI HAR Dataset] data folder and R script file in your working directory.

```r
// Go to working directory. Download the data and unzip. Put run_analysis.R into working directory too.
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="getdata_project_data", method="curl")
unzip("getdata_project_data")
```

- Call RunAnalysis() in the R console or Rstudio. Then the tidy data file(tidyData.txt) will be created in your working directory.
