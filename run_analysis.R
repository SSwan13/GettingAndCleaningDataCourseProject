library(reshape2)
library(dplyr)

## STEP 1: Merges the training and the test sets to create one data set

# read data into data frames
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")

# rename columns 
# subject column given a more descriptive label than V1
names(subject_train) <- "subjectId"
names(subject_test) <- "subjectId"
# x column names V# match up with each row in features
names(x_train) <- features$V2
names(x_test) <- features$V2
# y columns are activities
names(y_train) <- "activityId"
names(y_test) <- "activityId"

# combine files into one data set
train_ds <- cbind(subject_train, y_train, x_train)
test_ds <- cbind(subject_test, y_test, x_test)
ds <- rbind(train_ds, test_ds)


## STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.

# determine which columns contain "mean" or "std"
mean_std <- grepl("mean", names(ds)) | grepl("std", names(ds))

# ensure that we also keep the subjectId and activityId columns
mean_std[1:2] <- TRUE

# remove unnecessary columns - only want the mean and std columns
ds <- ds[, mean_std]


## STEP 3: Uses descriptive activity names to name the activities
## in the data set.
## STEP 4: Appropriately labels the data set with descriptive
## variable names. 

# add column with activity name
ds <- mutate(ds, activityName = factor(ds$activityId, labels=c("Walking","Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")) )

#drop activityId column (id no longer needed in tidy set of data since have activity name)
ds$activityId <- NULL

## STEP 5: Creates a second, independent tidy data set with the
## average of each variable for each activity and each subject.

# create the tidy data set
melted <- melt(ds, id=c("subjectId","activityName"))
tidy_ds <- dcast(melted, subjectId+activityName ~ variable, mean)

# write the tidy data set to a file
write.csv(tidy_ds, "tidy_ds.txt", row.names=FALSE)