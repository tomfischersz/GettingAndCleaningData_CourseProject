Code Book for Getting and Cleaning Data Course Project
===========

Thomas Fischer
February 02, 2018


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

1. **Merges the training and the test sets to create one data set.**
   
   Mergeing `test/X_test.txt` and `train/X_train.txt`.  
   Adding column headers from `features.txt`.  
   Adding the labels as new column from `train/y_train.txt` and `test/y_test.txt`.  
   Adding activity id's from `train/subject_train.txt` and `test/subject_test.txt`.  
2. **Extracts only the measurements on the mean and standard deviation for each measurement.**

   Features containing either the string 'std()', 'mean()' or 'meanFreq()' are extracted together with label 'activity_id' and identifier for the subjects 'subject_id'.  
   From 561 original measurement features 482 features were removed. 

3. **Uses descriptive activity names to name the activities in the data set**

   The descriptive activity names from `activity_labels.txt` were merged into the dat set.

4. **Appropriately labels the data set with descriptive variable names.**

   Nothing transformed. In my opinion there is no need to further transform the variable names, because there is no gain in ending in column names like:  
   "frequencyDomainBodyBodyAccelerometerJerkMagnitudeStandardDeviation"
   
5. **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

   The data set finally has been agregated by 'activity_id' and 'subject_id' and for each aggregation pair the mean for all measurement variables is calculated.  
   The final data set is saved to `tidy_data.txt`.

## Variables in `tidy_data.txt`
Aggreated data by 'activity_id' and 'subject_id'. The mean of all the measurements per aggregation is calculated. Please refer to the original [README.txt](https://github.com/tomfischersz/GettingAndCleaningData_CourseProject/blob/master/UCI%20HAR%20Dataset/README.txt) file for detailed information.