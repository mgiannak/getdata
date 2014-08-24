#Coursera - Getting and Cleaning Data Course Project

This project uses data retrieve from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. This page is a must-read to understand this project. Data set is available on 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Project Aim
Create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##Usage
Zip file content must be in the same directory as the 'run_analysis.R' file (hence 'test' and 'train' folders should be a the same level) for the R script to work.

##Result
This R script produces 
- a R dataset named 'melted_data' which fulfills the project's aim up to point 4. 
- a R dataset named 'tidy_data' and a 'tidydata.txt' file that fullfill the project's aim up to point 5.

##Script Process
- load libraries plyr and reshape2
- load raw data from test and train folders
- merge test and train datasets
- load measures names
- insert measures names in merged dataset
- filter merged dataset to keep only measures with "mean()" or "std()" in the name
- load raw activity data from test and train folders
- merge raw activity data
- merge measures with activity
- load raw subjects data from test and train folders
- merge subject data
- merge subject data with measures-activity
- load activity labels
- modify activity labels to lower case
- merge activity labels with measures-activity-subject data
- remove activity id (keep only label)
- reformat measure name for easier reading (and follow conventions)
- reshape data so have one measure per row
- make a crosstab of data to have a mean value for each activity-subject-measure