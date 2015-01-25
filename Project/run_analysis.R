# Getting and Cleaning Data - Project Assignment
# Program: run_analysis.R
#

## =================== BEGIN ===================================================
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
# The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on 
# a series of yes/no questions related to the project. You will be required to submit: 
#     1) a tidy data set as described below, 
#     2) a link to a Github repository with your script for performing the analysis, and 
#     3) a code book that describes the variables, the data, and any transformations or work that you performed to 
# clean up the data called CodeBook.md. 
#     You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts 
# work and how they are connected.  
# 
# Here are the data for the project: 
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 
# You should create one R script called run_analysis.R that does the following. 
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
# 
# Good luck!
## ===================  ===================================================

setwd("D:/Coursera/Johns Hopkins University/03.Getting and Cleaning Data/Project")

# only download if required
zipfile <- "getdata-projectfiles-UCI HAR Dataset.zip"
if(file.exists( zipfile ) == 0)
{
    fileUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl , destfile=zipfile , method="curl")
}

#only unzip if required
if(file.exists("UCI HAR Dataset") == 0)
{
    print(" unzipping file ... ")
    unzip( zipfile )
}

# read activity_labels file
actlabel <- read.table("UCI HAR Dataset/activity_labels.txt", sep = " " , h = F )

# read feature file as string
feature <- read.table("UCI HAR Dataset/features.txt", sep = "" , h = F , na.strings = "NA", stringsAsFactors = FALSE )

## read test data
testsub <- read.table("UCI HAR Dataset/test/subject_test.txt", sep = "" , h = F , na.strings = "NA")
testset <- read.table("UCI HAR Dataset/test/X_test.txt", sep = "" , h = F , na.strings = "NA")
testlbl <- read.table("UCI HAR Dataset/test/y_test.txt", sep = "" , h = F , na.strings = "NA")

## read training data
trainsub <- read.table("UCI HAR Dataset/train/subject_train.txt", sep = "" , h = F , na.strings = "NA")
trainset <- read.table("UCI HAR Dataset/train/X_train.txt", sep = "" , h = F , na.strings = "NA")
trainlbl <- read.table("UCI HAR Dataset/train/y_train.txt", sep = "" , h = F , na.strings = "NA")

# remove () and - from the feature; and replace t with time, f with frequency
feature$V2 <- sub("()","", feature$V2 , fixed = TRUE )
feature$V2 <- sub("-","_", feature$V2 , fixed = TRUE )
feature$V2 <- sub("^t" , "time_" , feature$V2)
feature$V2 <- sub("^f" , "frequency_" , feature$V2)

# make names unique according to R patterns
feature$V2 <- make.names(feature$V2, unique=TRUE)
 

#step 1: Merges the training and the test sets to create one data set.
totalset <- rbind( testset, trainset )          ## data set
totalsub <- rbind( testsub, trainsub )          ## subject
totallbl <- rbind( testlbl, trainlbl )          ## activity label

#step 3: assign activity labels as descriptive name to activity numbers in totallbl$V1
totallbl["activity_name"] <- actlabel[ totallbl$V1 , 2 ]
## drop the activity number column
totallbl <- subset( totallbl, select = -V1)
## link feature 561 rows into test set column names
colnames(totalset) <- c(feature$V2)  


#step 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# only use columns w mean and std
library(dplyr)
meanDt <- select(totalset , contains("mean" )  )  ## returns 53 cols
stdDt  <- select(totalset , contains("std")  )    ## returns 33 cols
# concatenate mean and std data frames together = 86 columns + subject + activity
mergedDt <- cbind(subject_no = totalsub$V1, activity_name = totallbl$activity_name,  meanDt , stdDt )

## if required, generates file with data set of 10299  obs. 88 variables
write.table( mergedDt 
             , file = "step4_merged_data_set.txt" 
             , sep = " "
             , row.name = FALSE
             , quote = FALSE)  ## add with no quotes

# step 5: generates a new data set with [180 observations = 30 subjects X 6 activities] and 88 variables
final_data_set <- aggregate( subset( mergedDt , select= -activity_name ) 
               , by = list( mergedDt$activity_name , mergedDt$subject_no ) 
               , FUN = mean )

# renaming columns created during the aggregate
names(final_data_set)[ names(final_data_set) == 'Group.1'] <- "activity_name"
## drop the extra column created during aggregate
final_data_set <- subset(final_data_set , select = -Group.2 )

# generate text file with list of column names of the final data set
step5_data_set_names <- colnames(final_data_set)
write.table( step5_data_set_names , file = "step5_data_set_names.txt", col.name = FALSE , row.name = FALSE, quote = FALSE)

# generate output of final data set from step 5 with no quotes
write.table( final_data_set , file = "step5_data_set.txt" , sep = " ", row.name = FALSE, quote = FALSE)  

# suggest how the marker should read this data set
#mydata <- read.table( "step5_data_set.txt" , header = TRUE , sep = " " )
#dim(mydata)
#str(mydata)
#summary(mydata)




## =================== END of run_analysis.R