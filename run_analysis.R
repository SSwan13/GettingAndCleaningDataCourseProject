library(reshape2)
library(dplyr)

# read data from files into data frames
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")

# rename columns within train and test data sets
# subject column given a more descriptive label than V1
names(subject_train) <- "subjectId"
names(subject_test) <- "subjectId"
# x column names V# match up with each row in features
names(x_train) <- features$V2
names(x_test) <- features$V2
# y columns are activities
names(y_train) <- "activityId"
names(y_test) <- "activityId"

# merge the train and test sets to create one working data set
train_ds <- cbind(subject_train, y_train, x_train)
test_ds <- cbind(subject_test, y_test, x_test)
ds <- rbind(train_ds, test_ds)


# determine which columns contain "mean" or "std"
mean_std <- grepl("mean", names(ds)) | grepl("std", names(ds))

# need to keep the subjectId and activityId columns
mean_std[1:2] <- TRUE

# remove unnecessary columns - only want to extract the mean and standard deviation columns
ds <- ds[, mean_std]


# add column with a more descriptive name for activity
ds <- mutate(ds, activityName = factor(ds$activityId, labels=c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")) )

#drop activityId column (id no longer needed in working set of data since have activity name now)
ds$activityId <- NULL


# create a new data set with the average of each variable for each activity and each subject.
melted <- melt(ds, id=c("subjectId","activityName"))
tidy_ds <- dcast(melted, subjectId+activityName ~ variable, mean)

# write the new data set out to a file
write.csv(tidy_ds, "tidy_ds.txt", row.names=FALSE)
