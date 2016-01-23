# Code Book for Getting and Cleaning Data Course Project

activity_labels.txt
-	contains the six activities studied 
-	1 – walking
-	2 – walking_upstairs
-	3 – walking_downstairs
-	4 – sitting
-	5 – standing
-	6 - laying

X_train.txt
-	training set
-	File contains no header row.  561 of the variables matche up with each feature vector within the features.txt file. (Example, variable 1 is equal to row 1, column 2 variable in the features file - “tBodyAcc-mean()-X”.)

y_train.txt
-	codes for the activities:
-	1 – walking
-	2 – walking_upstairs
-	3 – walking_downstairs
-	4 – sitting
-	5 – standing
-	6 - laying

X_test.txt
-	test set

y_test.txt
-	codes for the activities:
-	1 – walking
-	2 – walking_upstairs
-	3 – walking_downstairs
-	4 – sitting
-	5 – standing
-	6 - laying

subject_train.txt
-	Each row identifies the subject who performed the activity for each window sample various signals captured from the accelerometer and gyroscope

subject_test.txt
-	 identifiers for the 9 test people. Codes 2,4,9 etc. For each window sample.

features_info.txt 
-	information about the variables used in the feature vector

features.txt
-	various signals captured from the accelerometer and gyroscope

