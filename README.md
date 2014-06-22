Getting-and-Cleaning-Data
=========================

This is the repository for the "Getting and Cleaning Data" course project from Coursera.

Before running run_analysis.R script in R, make sure that the working directory is set to be the UCI HAR Dataset directory (download [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)).

##Running the script does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The resulting datasets will be written to Tidy Dataset.txt and Means of Tidy Dataset.txt
