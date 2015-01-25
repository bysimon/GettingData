---
title: "CodeBook.md"
author: "Simone"
date: "January, 2015"
output: html_document
---

# Coursera - Getting and Cleaning Data Course 
## Project Assignment Code Book

This file describes the variables, the data and any transformations or work performed to clean up the data; as well as the data structure of the two output files.

It assumes you have R and RStudio already installed in your computer and connection to the internet as it may need to download a specific package.

- URL where the original data was downloaded:  
    <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

- This assignment uses data from   
    <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
    
    
### 1) The **run_analysis.R** script performs the below steps in order to clean the data:

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

- Generate a text file (*step5_data_set_names.txt*) containing the column names of the final data set (*final_data_set* data frame)  

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

### 2) Data Structure of the output files
#### File name: **"step4_merged_data_set.txt"**
Number of columns:     88  
Number of rows   : 10,299

See below for the data structure.


#### File name: **"step5_data_set.txt"**
Number of columns:  88  
Number of rows   : 180

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 'time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

All these variables had their mean calculated per subject and per activity in order to generate this output.

Set of variables that were estimated:  

    - mean: Mean value
    - std: Standard deviation
    - meanFreq: Weighted average of the frequency components to obtain a mean frequency  

All the actual values in these measurements are the average of its occurrences along a period of time for a particular type of activity.

If required the original data is available in the URL mentioned at the top of this document.


Column Name         |    Column Description
--------------------|------------------------------------------------------------------------------------------------------
activity_name | Name of the activity performed during the measurement such as: walking, walking upstairs, walking downstairs, sitting, standing or laying.
subject_no | Number of the subject who the measurements belong to.
time_BodyAcc_mean.X | Average of time of BodyAcc on X axis.
time_BodyAcc_mean.Y | Average of time of BodyAcc on Y axis.
time_BodyAcc_mean.Z | Average of time of BodyAcc on Z axis.
time_GravityAcc_mean.X | Average of time of GravityAcc on X axis.
time_GravityAcc_mean.Y | Average of time of GravityAcc on Y axis.
time_GravityAcc_mean.Z | Average of time of GravityAcc on Z axis.
time_BodyAccJerk_mean.X | Average of time of BodyAccJerk on X axis.
time_BodyAccJerk_mean.Y | Average of time of BodyAccJerk on Y axis.
time_BodyAccJerk_mean.Z | Average of time of BodyAccJerk on Z axis.
time_BodyGyro_mean.X | Average of time of BodyGyro on x axis.
time_BodyGyro_mean.Y | Average of time of BodyGyro on Y axis.
time_BodyGyro_mean.Z | Average of time of BodyGyro on Z axis.
time_BodyGyroJerk_mean.X | Average of time of BodyGyroJerk on X axis.
time_BodyGyroJerk_mean.Y | Average of time of BodyGyroJerk on Y axis.
time_BodyGyroJerk_mean.Z | Average of time of BodyGyroJerk on Z axis.
time_BodyAccMag_mean | Average of time of BodyAccMag.
time_GravityAccMag_mean | Average of time of GravityAccMag.
time_BodyAccJerkMag_mean | Average of time of BodyAccJerkMag.
time_BodyGyroMag_mean | Average of time of BodyGyroMag.
time_BodyGyroJerkMag_mean | Average of time of BodyGyroJerkMag.
frequency_BodyAcc_mean.X | Average of frequency of BodyAcc on X axis.
frequency_BodyAcc_mean.Y | Average of frequency of BodyAcc on Y axis.
frequency_BodyAcc_mean.Z | Average of frequency of BodyAcc on Z axis.
frequency_BodyAcc_meanFreq.X | Average of weighted average of the frequency components of BodyAcc on X axis.
frequency_BodyAcc_meanFreq.Y | Average of weighted average of the frequency components of BodyAcc on Y axis.
frequency_BodyAcc_meanFreq.Z | Average of weighted average of the frequency components of BodyAcc on Z axis.
frequency_BodyAccJerk_mean.X | Average of frequency of BodyAccJerk on X axis.
frequency_BodyAccJerk_mean.Y | Average of frequency of BodyAccJerk on Y axis.
frequency_BodyAccJerk_mean.Z | Average of frequency of BodyAccJerk on Z axis.
frequency_BodyAccJerk_meanFreq.X | Average of weighted average of the frequency components of BodyAccJerk on X axis.
frequency_BodyAccJerk_meanFreq.Y | Average of weighted average of the frequency components of BodyAccJerk on Y axis.
frequency_BodyAccJerk_meanFreq.Z | Average of weighted average of the frequency components of BodyAccJerk on Z axis.
frequency_BodyGyro_mean.X | Average of frequency of BodyGyro on X axis.
frequency_BodyGyro_mean.Y | Average of frequency of BodyGyro on Y axis.
frequency_BodyGyro_mean.Z | Average of frequency of BodyGyro on Z axis.
frequency_BodyGyro_meanFreq.X | Average of weighted average of the frequency components of BodyGyro on X axis.
frequency_BodyGyro_meanFreq.Y | Average of weighted average of the frequency components of BodyGyro on Y axis.
frequency_BodyGyro_meanFreq.Z | Average of weighted average of the frequency components of BodyGyro on Z axis.
frequency_BodyAccMag_mean | Average of frequency of BodyAccMag.
frequency_BodyAccMag_meanFreq | Average of weighted average of the frequency components of BodyAccMag.
frequency_BodyBodyAccJerkMag_mean | Average of frequency of BodyBodyAccJerkMag.
frequency_BodyBodyAccJerkMag_meanFreq | Average of weighted average of the frequency components of BodyBodyAccJerkMag.
frequency_BodyBodyGyroMag_mean | Average of frequency of BodyBodyGyroMag.
frequency_BodyBodyGyroMag_meanFreq | Average of weighted average of the frequency components of BodyBodyGyroMag.
frequency_BodyBodyGyroJerkMag_mean | Average of frequency of BodyBodyGyroJerkMag.
frequency_BodyBodyGyroJerkMag_meanFreq | Average of weighted average of the frequency components of BodyBodyGyroJerkMag.
angle.tBodyAccMean.gravity. | Average of the time of BodyAccMean of the angle gravity.
angle.tBodyAccJerkMean..gravityMean. | Average of the time of BodyAccJerkMean of the angle gravity.
angle.tBodyGyroMean.gravityMean. | Average of the time of BodyGyroMean of the angle gravity.
angle.tBodyGyroJerkMean.gravityMean. | Average of the time of BodyGyroJerkMean of the angle gravity.
angle.X.gravityMean. | Average of the angle gravity on axis X.
angle.Y.gravityMean. | Average of the angle gravity on axis Y.
angle.Z.gravityMean. | Average of the angle gravity on axis Z.
time_BodyAcc_std.X | Standard Deviation of time of BodyAcc on X axis.
time_BodyAcc_std.Y | Standard Deviation of time of BodyAcc on Y axis.
time_BodyAcc_std.Z | Standard Deviation of time of BodyAcc on Z axis.
time_GravityAcc_std.X | Standard Deviation of time of GravityAcc on X axis.
time_GravityAcc_std.Y | Standard Deviation of time of GravityAcc on X axis.
time_GravityAcc_std.Z | Standard Deviation of time of GravityAcc on X axis.
time_BodyAccJerk_std.X | Standard Deviation of time of BodyAccJerk on X axis.
time_BodyAccJerk_std.Y | Standard Deviation of time of BodyAccJerk on Y axis.
time_BodyAccJerk_std.Z | Standard Deviation of time of BodyAccJerk on Z axis.
time_BodyGyro_std.X | Standard Deviation of time of BodyGyro on X axis.
time_BodyGyro_std.Y | Standard Deviation of time of BodyGyro on Y axis.
time_BodyGyro_std.Z | Standard Deviation of time of BodyGyro on Z axis.
time_BodyGyroJerk_std.X | Standard Deviation of time of BodyGyroJerk on X axis.
time_BodyGyroJerk_std.Y | Standard Deviation of time of BodyGyroJerk on Y axis.
time_BodyGyroJerk_std.Z | Standard Deviation of time of BodyGyroJerk on Z axis.
time_BodyAccMag_std | Standard Deviation of time of BodyAccMag.
time_GravityAccMag_std | Standard Deviation of time of GravityAcc.
time_BodyAccJerkMag_std | Standard Deviation of time of GravityAcc.
time_BodyGyroMag_std | Standard Deviation of time of GravityAcc.
time_BodyGyroJerkMag_std | Standard Deviation of time of GravityAcc.
frequency_BodyAcc_std.X | Standard Deviation of frequency of BodyAcc on X axis.
frequency_BodyAcc_std.Y | Standard Deviation of frequency of BodyAcc on Y axis.
frequency_BodyAcc_std.Z | Standard Deviation of frequency of BodyAcc on Z axis.
frequency_BodyAccJerk_std.X | Standard Deviation of frequency of BodyAccJerk on X axis.
frequency_BodyAccJerk_std.Y | Standard Deviation of frequency of BodyAccJerk on Y axis.
frequency_BodyAccJerk_std.Z | Standard Deviation of frequency of BodyAccJerk on Z axis.
frequency_BodyGyro_std.X | Standard Deviation of frequency of BodyGyro on X axis.
frequency_BodyGyro_std.Y | Standard Deviation of frequency of BodyGyro on Y axis.
frequency_BodyGyro_std.Z | Standard Deviation of frequency of BodyGyro on Z axis.
frequency_BodyAccMag_std | Standard Deviation of frequency of BodyAccMag.
frequency_BodyBodyAccJerkMag_std | Standard Deviation of frequency of BodyBodyAccJerkMag.
frequency_BodyBodyGyroMag_std | Standard Deviation of frequency of BodyBodyGyroMag.
frequency_BodyBodyGyroJerkMag_std | Standard Deviation of frequency of BodyBodyGyroJerkMag.










