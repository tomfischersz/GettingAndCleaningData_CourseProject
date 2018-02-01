Getting and Cleaning Data Course Project
===========

Thomas Fischer
January 31, 2018

Repository for the submission of the peer-graded assignment in Coursera's **Getting and Cleaning Data** course by Johns Hopkins University.

## Overview
This project aims to demonstrate how to collect and clean raw data and to transform it to a tidy data set that can be used for further analysis. More information on tidy data can be obtained from [Tidy Data by Hadley Wickham](http://vita.had.co.nz/papers/tidy-data.pdf).

## Repository Content
* `README.md` - just this file, which provides an overview of the repository
* `CodeBook.md` - desciption of the variables, the data, and any transformations or work done to clean up the data 
* `run_analysis.R` - R script for performing data cleaning. Further details on this script can be obtainded in the section [Script](## Script).
* `UCI HAR Dataset` - original raw data folder. **Important Note:** Due to GitHub's file size limits, this folder **does not contain** the training and test files, namely `./train/X_train.txt` and `./test/X_test.txt`. Furthermore both `./training/Inertial Signals` and `./test/Inertial Signals`were removed as they don't contribute neccessary data to this project. Training and test data sets can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Please extract it to the same directory where the R script called run_analysis.R resides.
* `tidy_data.txt` - tidy data set with the average of each variable for each activity and each subject. This data set is performed all in `run_analysis.R` script.

## Raw Data
The raw data to tidy up represents data collected from the accelerometers from the Samsung Galaxy S smartphone. The data was built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. The data was labeled manually corresponding to video records.
A full description is available at the site where the data was obtained: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 
The raw data namely consists of 561 attributes (already preprocessed measurements) and 10299 observations for 30 individuals.
The labels were classified into six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

## Script
bla ba