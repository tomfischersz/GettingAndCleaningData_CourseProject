## Peer-Graded Assignment: 'Getting and Cleaning Data' Course Project
## part of coursera's nine-week Data Spezialization by Johns Hopkins University

## January 30, 2018
## author:  Thomas Fischer
## email:   tomfischer@qq.com   


# getwd()
setwd('C:/Users/user/Documents/GitHub/GettingAndCleaningData_CourseProject/')
# setwd('../')
dir()
rm(list = ls())
require(data.table)



# all data for project can be found in this zip file:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# the content of the zip data has been extracted to this subfolder:
# as size is restricted in GitHub the data folder was copied to another loacation
# data_folder should be set to where the raw data can be found
# zip archive of the raw data used in this script can be found here: 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# data_folder = './UCI HAR Dataset/'

#deleted 'Inertial Signals' folder due to size
# deleted './test/X_test.txt' and './train/X_train.txt'
data_folder = 'C:/Users/user/Documents/Rworking/Coursera_DataScience/Coursera_Data_Cleaning/UCI HAR Dataset/'
setwd(data_folder)

#----------------------- Step 1 ------------------------------------------------
# Merges the training and the test sets to create one data set.
# first question is what are traing and test sets?
# README.txt gives us description of files:
# x <- ('README.txt')

#- 'features_info.txt': Shows information about the variables used on the feature vector.
#features_info <- fread('features_info.txt')
#- 'features.txt': List of all features.
features <- fread('features.txt')
#- 'activity_labels.txt': Links the class labels with their activity name.
activity_labels <- fread('activity_labels.txt')
#- 'train/X_train.txt': Training set.
X_train <- fread('train/X_train.txt')
#- 'train/y_train.txt': Training labels.
y_train <- fread('train/y_train.txt')
#- 'test/X_test.txt': Test set.
X_test <- fread('test/X_test.txt')
#- 'test/y_test.txt': Test labels.
y_test <- fread('test/y_test.txt')
# The following files are available for the train and test data. Their descriptions are equivalent. 
# - 'train/subject_train.txt': Each row identifies the subject who 
#    performed the activity for each window sample. Its range is from 1 to 30.
subject_train <- fread('train/subject_train.txt')
subject_test <- fread('test/subject_test.txt')


dim(features)
dim(X_train)
dim(X_test)
7352 + 2947
head(features, 12)

# we use the features as column names for training and test data
names(X_train) <- features[, V2]
names(X_test) <- features[, V2]
rm(features)
head(X_train[, 1:6])
head(X_test[, 1:6])

# we can bind the labels to the data sets with column name activity_id
# sapply(list(y_train, y_test), function(col) {names(col) <- 'activity_id'})
names(y_train) <- 'activity_id'
names(y_test) <- 'activity_id'
train <- cbind(X_train, y_train)
test <- cbind(X_test, y_test)
# dim(X_train)
# dim(train)
# tables()
rm(X_train, X_test, y_train, y_test) ; gc()

# also bind subject-id's to the data sets
names(subject_train) <- 'subject_id'
names(subject_test) <- 'subject_id'
train <- cbind(train, subject_train)
test <- cbind(test, subject_test)
rm(subject_train, subject_test)
table(train$subject_id)

# merge training and test data sets
all_data <- rbindlist(l = list(train, test))
rm(train, test)

# we now have a table.table object, with training and test data
# merged and added the activity_id (label) and subject_id as new columns

dim(all_data)
head(all_data[, 1:6])
tail(all_data[, 559:563])



#----------------------- Step 2 ------------------------------------------------
# Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
all_columns <- colnames(all_data)
all_columns
all_columns[grepl('std\\(\\)', all_columns)]

# It is that far not clear what is meant with 'measurements on the mean'
# We can find find the string 'mean' in different contexts

# 53 columns matching either 'mean' or 'Mean'
all_columns[grepl('mean', all_columns, ignore.case = TRUE)]
# 33 of 53 entail the string 'mean()'
all_columns[grepl('mean\\(\\)', all_columns)]
# 13 of 53 entail the string 'meanFreq()'
all_columns[grepl('mean[^\\(]', all_columns)]
# the rest entail 'gravityMean' or 'tBodyAccMean' as part of an angle() function
all_columns[grepl('Mean', all_columns)]

# we only extract variables with 'mean()' or 'meanFreq()'
all_columns[grepl('mean\\(\\)|meanFreq\\(\\)', all_columns)]

grep('(mean\\(\\))|(meanFreq\\(\\)))', all_columns)

non_measurement_cols <- c('activity_id', 'subject_id')
mean_cols <- all_columns[grepl('mean\\(\\)|meanFreq\\(\\)', all_columns)]
std_cols <- all_columns[grepl('std\\(\\)', all_columns)]

dim(all_data)
all_data <- all_data[, c(mean_cols, std_cols, non_measurement_cols), 
                     with = FALSE]

#----------------------- Step 3 ------------------------------------------------
all_data <- all_data[, 77:81]
head(all_data)
names(activity_labels) <- c('activity_id','activity')
dim(activity_labels)
head(activity_labels)

dim(all_data)

x <- merge(all_data, activity_labels, by = c('activity_id'))
table(x$activity_id, x$activity)

#----------------------- Step 4 ------------------------------------------------
#----------------------- Step 5 ------------------------------------------------
