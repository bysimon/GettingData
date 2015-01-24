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

- Load dplyr library (usage of select())

- Extract only the measurements columns on the mean and standard deviation.
It means removing the columns from the *totalset* data frame that do not contain either 'mean' or 'std' on their names. It creates 2 data frames, being 1 for mean (meanDt)  with 53 columns and the other one for std (stdDt) with 33 columns. The mergedDt data frame will be the result from the concatenation of 
```
   mergeDt = subject_number + activity_name + meanDt + stdDt        [10299 rows | 88 columns]
```

- If desired, generates an output data file named **"step4_merged_data_set.txt"** with 10299 rows and 88 columns

- Generate a new data frame (*final_data_set*) with a reduced number of rows containing 1 observation (or row) per subject per activity with the average of all the mean and std measurements for each of one of them
[180 observations = 30 subjects X 6 activities] and 88 variables/measurements

- Clean up the columns on this final_data_set data frame created during the aggregate operation:
	- rename column 'Group.1' to 'activity_name
	- drop extra column 'Group.2'        

- Finally generate the output file **"step5_data_set"** using

```
write.table( final_data_set , file = "step5_data_set.txt"" , sep = " ", row.name = FALSE, quote = FALSE)  
```


*Note:* use the commands below if you want to read the output file generated by the last step

```
        mydata <- read.table( "step5_data_set.txt" , header = TRUE , sep = " " )
        dim(mydata)
        str(mydata)
        summary(mydata)
``` 














