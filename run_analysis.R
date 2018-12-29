#####    Install Requied packages   #####

# check if "reshape2" package is installed
if (!"reshape2" %in% installed.packages()) {
      install.packages("reshape2")
}
library("reshape2")

#####    Download & Read Data     #####

# identify the url for download & the zip file name:
fileName <- "UCIdata.zip"
url <-
      "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# download dataset if it's not already available in the working directory:
if (!file.exists(fileName)) {
      download.file(url, fileName, mode = "wb")
}

# unzip the downloaded file.

unzip("UCIdata.zip", files = NULL, exdir = ".")

## read Data

testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
testMeasurements <- read.table("UCI HAR Dataset/test/X_test.txt")
trainMeasurements <- read.table("UCI HAR Dataset/train/X_train.txt")
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# add column names for measurement data sets

names(testMeasurements) <- features$V2
names(trainMeasurements) <- features$V2

### 1. Merges the training and the test measurements to create one data set:

dataSet <- rbind(testMeasurements, trainMeasurements)

### 2. Extracts only the measurements on the mean and standard deviation for each measurement:

MeanAndStd <- grep("mean()|std()", features[, 2])
dataSet <- dataSet[, MeanAndStd]

### 3. Uses descriptive activity names to name the activities in the data set:

# add Subjects and Activities columns to the created dataSet
subjects <- rbind(testSubjects, trainSubjects)
activities <- rbind(testActivities, trainActivities)
names(subjects) <- 'subjects'
names(activities) <- 'activities'

DataSet <- cbind(subjects, activities, dataSet)

# replace activity values with named factor levels
DataSet$activities <- factor(DataSet$activities,
                             levels = activityLabels[, 1], labels = activityLabels[, 2])

### 4. Appropriately labels the data set with descriptive variable names.

# get column names
DataSetCols <- colnames(DataSet)

# remove special characters
DataSetCols <- gsub("[\\(\\)-]", "", DataSetCols)

# expand abbreviations and clean up names
DataSetCols <- gsub("^f", "frequencyDomain", DataSetCols)
DataSetCols <- gsub("^t", "timeDomain", DataSetCols)
DataSetCols <- gsub("Acc", "Accelerometer", DataSetCols)
DataSetCols <- gsub("Gyro", "Gyroscope", DataSetCols)
DataSetCols <- gsub("Mag", "Magnitude", DataSetCols)
DataSetCols <- gsub("Freq", "Frequency", DataSetCols)
DataSetCols <- gsub("mean", "Mean", DataSetCols)
DataSetCols <- gsub("std", "StandardDeviation", DataSetCols)

# correct typo
DataSetCols <- gsub("BodyBody", "Body", DataSetCols)

# use new labels as column names
colnames(DataSet) <- DataSetCols

### 5. From the data set in step 4, creates a second, independent tidy data set 
     #with the average of each variable for each activity and each subject.

# melt data to tall skinny data
melted <- melt(DataSet, id=c("subjects","activities"))

# create a secondary data set and summarise observations by mean
secondDataSet  <- dcast(melted, subjects+activities ~ variable, mean)

# write the secondary data set to the working directory as "secobdary_data.cvs"
write.csv(secondDataSet, "secondary_data.csv", row.names=FALSE)