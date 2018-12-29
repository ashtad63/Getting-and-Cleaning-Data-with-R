Code Book
==========

## Pre Analysis

This script will check if the data file is present in your working directory. (If not, will download and unzip the file)

## 0. Read data and Merge

* testSubjects : subject IDs for test
* trainSubjects  : subject IDs for train
* testMeasurements : values of variables in test
* trainMeasurements : values of variables in train
* testActivities : activity ID in test
* trainActivities : activity ID in train
* activityLabels : Description of activity IDs in y_test and y_train
* features : description(label) of each variables in X_test and X_train

At the end of this step, add column names for test and train measurement data sets.

## 1. Merges the training and the test measurements

* dataSet : bind of testMeasurements and trainMeasurements

## 2. Extract only mean() and std()

Create a vector of only mean and std labels, then use the vector to subset dataSet.

* MeanAndStd : a vector of only mean and std labels extracted from 2nd column of features
* dataSet : at the end of this step, dataSet will only contain mean and std variables

## 3. Changing Column label of dataSet

Add Subject and Activity to the dataSet

* subjects : bind subject IDs in test and train data sets
* activities: bind activity IDs in test and train data sets

Combine test data and train data of subject and activity, then give descriptive lables. Then bind with dataSet.

* DataSet: has 2 additonal columns 'subjecs' and 'activities' in the left side of dataSet

Finally, replace 'activities' values with named factor levels.

## 4. Appropriately labels the data set with descriptive variable names.

Get coloumn names, remove special characters, expand abbreviations, and correct typo.

* DataSetCols: revised column names

## 5. Output tidy data

In this part, dataSet is melted to create tidy data. Finally output the data as "secondary_data.cvs"

* melted : melted tall and skinny dataSet
* secondDataSet : casete baseData which has means of each variables
