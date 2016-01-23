# GettingAndCleaningDataCourseProject

This README file for the Getting and Cleaning Data Course Project explains what the run_analysis.R script does.
 
There is one script, run_analysis.R, for this project.

Not contained within the script is the process to download and unzip the data files used for this project.  This process needs to be completed before running the run_analysis.R script.  

	setwd("I:/Data Science Certification/3_Getting_And_Cleaning_Data/Week_4")
	if(!file.exists("./data")) {dir.create("./data")}
	fileUrl <- “https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(fileUrl, destfile="./data/dataset.zip", mode="wb") 
	unzip ("dataset.zip", exdir = "./data")

The run_analysis.R script does the following:

1. Creates data sets for each of the following files:
  * subject_train.txt
  * subject_test.txt
  * X_train.txt
  * X_test.txt
  * y_train.txt
  * y_test.txt
  * features.txt
2. Updates column names to more descriptive names within the “subject” and “y” data sets.
3. Updates the column names in the “x” data sets using the measured signal features in the features data set.
4. Combines the “train” data sets (x_train, y_train and subject_train) into one “train” data set.
5. Combines the “test” data sets (x_test, y_test, subject_test) into one “test” data set.
6. Creates one working data set combining the “test” and “train” data sets.
7. Extracts the columns from the working data set that contain only the mean and standard deviation measurements.
8. Removes all columns that are not mean and standard deviation measurements from the working data set.
9. Using the following mapping of activityId and activityName, a new column is added to the data set with the descriptive name of the activity based on the activityId value.  The activityId column is then dropped from the data set to keep the working data set tidy.
  * activityId  -  activityName
  * 1  -  WALKING
  * 2  -  WALKING_UPSTAIRS
  * 3  -  WALKING_DOWNSTAIRS
  * 4  -  SITTING
  * 5  -  STANDING
  * 6  -  LAYING
10. A new data set is created with the average of each variable for each activity and each subject from the working data set.
11. A results file is produced using the new data set.  The results file is tidy_ds.txt.

Further comments accompany the code within the script itself.

Also, refer to CodeBook.md for detailed information on the data sets and the transformations completed to produce the tidy_data_set.csv results file.
