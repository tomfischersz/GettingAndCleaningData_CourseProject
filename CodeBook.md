Code Book for Getting and Cleaning Data Course Project
===========

Thomas Fischer
January 31, 2018


## Source Data
Training and test data sets can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The zip archive contains a folder named `UCI HAR Dataset` with all the raw data. Hereby a list with *only* the data relevant for this project:

* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

## Transformations by script `run_analysis.R`:
The script is following the instructions for this coursera assignment: 

1. Merges the training and the test sets to create one data set.
   Mergeing `test/X_test.txt` and `train/X_train.txt`.
   Adding column headers from `features.txt`.
   Adding the labels as new column from `train/y_train.txt` and `test/y_test.txt`
   Adding activity id's from `train/subject_train.txt` and `test/subject_test.txt`
2. Extracts only the measurements on the mean and standard deviation for each measurement.
   Features containing either the string 'std()', 'mean()' or 'meanFreq()' are extracted together with the label 'activity_id' and identifier for the subjects 'subject_id'
   Form 561 original features only 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Variables and Summaries calculated in tidy data set

