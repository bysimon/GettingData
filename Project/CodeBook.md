---
title: "CodeBook.md"
author: "Simone"
date: "January, 2015"
output: html_document
---

## Coursera - Getting and Cleaning Data Course 
### Project Assignment Code Book

This file describes the variables, the data, and any transformations or work performed to clean up the data.

It assumes you have R and RStudio already installed in your computer and connection to the internet as it may need to download a specific package.

- URL where the original data was downloaded:  
    <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

- This assignment uses data from   
    <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>


1) Ensure your local path is set to "~/Project" folder, this is your working directory.  
2) Download the file from the above mentioned URL in your working directory. The file should be named as 'getdata-projectfiles-UCI HAR Dataset.zip'.  
3) Unzip it.  
4) Make sure the folder 'UCI HAR Dataset' created in the previous step is in the same folder as run_analysis.R script.  
5) Load the mentioned script using source("run_analysis.R") within RStudio.  
6) In the working directory there are the following files:
    - two output files:
        - step4_merged_data_set.txt (size = 10MB)
            data resulted from merged_data_set data frame which dimensions are [10299 obs. of 90 variables]
        - step5_data_set.txt (size = 286 KB)
            final data set from 'final_data_set' data frame which dimensions are [180  obs. 90 variables]
    - R script: run_analysis.R
    - README.md (this file)
    - CodeBook.md
    - 'UCI HAR Dataset' folder containing the data files to be read during the script execution  
7) To read the data files within RStudio use the command as per below:
  That file contais the average of each variable (86) for each activity (6) for each subject (30).
  
    So you will find 180 rows (6 activities * 30 subjects) and 88 columns (86 variables + 1 subject number + 1 activity name )
  

```
        mydata <- read.table( "step5_data_set.txt" , header = TRUE , sep = " " )
        dim(mydata)
        str(mydata)
        summary(mydata)
``` 