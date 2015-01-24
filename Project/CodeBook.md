---
title: "CodeBook.md"
author: "Simone"
date: "January, 2015"
output: html_document
---

## Coursera - Getting and Cleaning Data Course 
### Project Assignment Code Book

This file describes the variables, the data and any transformations or work performed to clean up the data.

It assumes you have R and RStudio already installed in your computer and connection to the internet as it may need to download a specific package.

- URL where the original data was downloaded:  
    <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

- This assignment uses data from   
    <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
    
    
The **run_analysis.R** script performs the below steps in order to clean the data:

- Set the working directory as *'~/Project/*
- Check for the zip file, if does not exist in the working directory downloads it
- Check for the data directory named "UCI HAR Dataset", if does not exist unzips the downloaded file
- Read the activity labels file "activity_labels.txt" from "UCI HAR Dataset" folder into *actlabel* variable *(see table below)*

- Read the features file "features.txt" from "UCI HAR Dataset" folder into *feature* variable using parameter 'stringsAsFactors = FALSE' *(see table below)*


Directory Name   | File Name         |  File Description  | Variable Name | #Rows | #Columns
-----------------|-------------------|--------------------|----------------|-----|----
UCI HAR Dataset/ | activity_labels.txt | activity labels file  | *actlabel* | 6 | 2
UCI HAR Dataset/ | features.txt       | features file | *feature* | 561 | 2


- Read the test files as per the below table:

Directory Name       | File Name         |  File Description  | Variable Name | #Rows | #Columns
---------------------|-------------------|--------------------|----------------|-----|----
UCI HAR Dataset/test/ | subject_test.txt | test subject file  | *testsub* | 2947 | 1
UCI HAR Dataset/test/ | X_test.txt       | test data measurements set file | *testset* | 2947 | 561
UCI HAR Dataset/test/ | y_test.txt       | test label activity file | *testlbl* | 2947 |1

- Read the train files as per the below table:

Directory Name       | File Name         |  File Description | Variable Name | #Rows | #Columns
---------------------|-------------------|-------------------|-------------------|-----|----
UCI HAR Dataset/train/ | subject_train.txt | train subject file    | *trainsub* |7352 |1
UCI HAR Dataset/train/ | X_train.txt       | train data measurements set file | *trainset* |7352 |561
UCI HAR Dataset/train/ | y_train.txt       | train label activity file | *trainlbl* |7352 |1

- Clean up the names of features in *feature* variable *V2* column:
    - removing parenthesis '()'
	- replacing dash '-' by underscore '_'
	- replacing words starting with 't' by 'time_'
	- replacing words starting with 'f' by 'frequency_'
	- making names unique and according to R naming conventions


- Merge the training and test sets together *(as per below table)*:

Merge Operation               | Result Description         |   #Rows | #Columns
------------------------------|----------------------------|---------|----
*totalset* = *testset* + *trainset* | Complete data measurements set | 10299 | 561
*totalsub* = *testsub* + *trainsub* | Complete subject set |  10299 |1
*totallbl* = *testlbl* + *trainlbl* | Complete label activity set | 10299   |1

- Update the complete label activity set (*totallbl*) with a new column "activity_name" containing the activity name from *actlabel* variable and Drop its first column containing only the code (*totallbl$V1*)

- Assign the feature names list (*feature$V2*) to the totalset data frame

- 

```
        mydata <- read.table( "step5_data_set.txt" , header = TRUE , sep = " " )
        dim(mydata)
        str(mydata)
        summary(mydata)
``` 














