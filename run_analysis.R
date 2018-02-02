## Peer-Graded Assignment: 'Getting and Cleaning Data' Course Project
## part of coursera's nine-week Data Spezialization by Johns Hopkins University

## January 30, 2018
## author:  Thomas Fischer
## email:   tomfischer@qq.com   

# setwd('C:/Users/user/Documents/GitHub/GettingAndCleaningData_CourseProject/')
# rm(list = ls())

require(data.table)
require(dplyr)

# all data for project can be found in this zip file:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# the content of the zip archive has been extracted to this subfolder:
data_folder = 'C:/Users/user/Documents/Rworking/Coursera_DataScience/Coursera_Data_Cleaning/UCI HAR Dataset/'
# data_folder should be set to where the raw data can be found
# data_folder = './UCI HAR Dataset/'
# setwd(data_folder)


#----------------------- Load Raw Data Section ---------------------------------
# We just load all the raw data we need.
#-------------------------------------------------------------------------------
# - 'features_info.txt': Shows information about the variables used on the 
#                        feature vector.
#features_info <- fread('features_info.txt')

# - 'features.txt': List of all features.
feature_names <- fread(file.path(data_folder,'features.txt'))

# - 'activity_labels.txt': Links the class labels with their activity name.
activity_labels <- fread(file.path(data_folder,'activity_labels.txt'))

# - 'train/X_train.txt': Training set.
X_train <- fread(file.path(data_folder,'train/X_train.txt'))

# - 'train/y_train.txt': Training labels.
y_train <- fread(file.path(data_folder,'train/y_train.txt'))

# - 'test/X_test.txt': Test set.
X_test <- fread(file.path(data_folder,'test/X_test.txt'))

# - 'test/y_test.txt': Test labels.
y_test <- fread(file.path(data_folder,'test/y_test.txt'))

# - 'train/subject_train.txt': Each row identifies the subject who 
#    performed the activity for each window sample. Its range is from 1 to 30.
subject_train <- fread(file.path(data_folder,'train/subject_train.txt'))
# - 'test/subject_test.txt': Each row identifies the subject who 
#    performed the activity for each window sample. Its range is from 1 to 30.
subject_test <- fread(file.path(data_folder,'test/subject_test.txt'))



## Steps 1 to 6 in this script follow the instructions for this coursera assignment

#----------------------- Step 1 ------------------------------------------------
# Merges the training and the test sets to create one data set.
#-------------------------------------------------------------------------------

dim(X_train)
dim(X_test)
nrow(X_train) + nrow(X_test)
# altogether there are 10299 observations with 561 features

# use feature_names column names for training and test data
names(X_train) <- feature_names[, V2]
names(X_test) <- feature_names[, V2]
rm(feature_names)

# bind the labels to the data sets with column name activity_id
names(y_train) <- 'activity_id'
names(y_test) <- 'activity_id'
train <- cbind(X_train, y_train)
test <- cbind(X_test, y_test)
rm(X_train, X_test, y_train, y_test) ; gc()

# also bind subject-id's to the data sets
names(subject_train) <- 'subject_id'
names(subject_test) <- 'subject_id'
train <- cbind(train, subject_train)
test <- cbind(test, subject_test)
rm(subject_train, subject_test)
# table(train$subject_id)

# merge training and test data sets
all_data <- rbindlist(l = list(train, test))
rm(train, test) ; gc()

# we now have a table.table object, with training and test data
# merged and added the activity_id (label) and subject_id as new columns


#----------------------- Step 2 ------------------------------------------------
# Extracts only the measurements on the mean and standard deviation 
# for each measurement.
#-------------------------------------------------------------------------------

# collect all column names into all_columns
all_columns <- colnames(all_data)
# all_columns

# all_columns[grepl('std\\(\\)', all_columns)]

# It is so far not clear what is meant with 'measurements on the mean'
# We can find find the string 'mean' in different contexts

# 53 columns matching either 'mean' or 'Mean'
print(all_columns[grepl('mean', all_columns, ignore.case = TRUE)])

# 33 of these 53 entail the string 'mean()'
print(all_columns[grepl('mean\\(\\)', all_columns)])

# 13 of these 53 entail the string 'meanFreq()'
print(all_columns[grepl('mean[^\\(]', all_columns)])

# 7 of these 53  entail 'gravityMean' or 'tBodyAccMean' as part of an angle() function
print(all_columns[grepl('Mean', all_columns)])

# we only extract 46 variables containing either string 'mean()' or 'meanFreq()'
all_columns[grepl('mean\\(\\)|meanFreq\\(\\)', all_columns)]

# now collect all column names that will extraact from our data set
non_measurement_cols <- c('activity_id', 'subject_id')
mean_cols <- all_columns[grepl('mean\\(\\)|meanFreq\\(\\)', all_columns)]
std_cols <- all_columns[grepl('std\\(\\)', all_columns)]

# and subset the remaining columns
all_data <- all_data[, c(mean_cols, std_cols, non_measurement_cols), 
                     with = FALSE]
rm(non_measurement_cols, mean_cols, std_cols, all_columns)


#----------------------- Step 3 ------------------------------------------------
# Uses descriptive activity names to name the activities in the data set
#-------------------------------------------------------------------------------
names(activity_labels) <- c('activity_id','activity_name')

# merge the data set with proper activity names
all_data <- merge(all_data, activity_labels, by = c('activity_id'))

# original activity id's can be dropped
all_data[, activity_id:=NULL]
rm(activity_labels)


#----------------------- Step 4 ------------------------------------------------
# Appropriately labels the data set with descriptive variable names. 
#-------------------------------------------------------------------------------

# the original file features_info.txt gives descriptions on how the measurement
# variables are named. 
# In my opinion there is no need to further transform the variable names,
# because it is often very unconvenient to transform column names like:
# "fBodyBodyAccJerkMag-std()"
# "frequencyDomainBodyBodyAccelerometerJerkMagnitudeStandardDeviation"


#----------------------- Step 5 ------------------------------------------------
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
#-------------------------------------------------------------------------------

all_data_mean <-
    all_data %>%
    group_by(subject_id, activity_name) %>%
    summarise_all(funs(mean)) %>%
    # ungroup %>%
    as.data.frame

write.table(all_data_mean, 
            file = 'tidy_data.txt',
            row.names = FALSE)

#----------------------- End of script -----------------------------------------
