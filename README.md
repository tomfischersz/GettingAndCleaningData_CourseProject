Getting and Cleaning Data Course Project
===========

Thomas Fischer
January 31, 2018

Repository for the submission of the peer-graded assignment in Coursera's **Getting and Cleaning Data** course by Johns Hopkins University.

## Repository Content

* `README.md` - just this file, which provides an overview of the repository
* `CodeBook.md` - desciption of the variables, the data, and any transformations or work done to clean up the data 
* `run_analysis.R` - R script for performing data cleaning


## Overview
This project aims to demonstrate how to collect and clean raw data and to transform it to a tidy data set that can be used for further analysis. More information on tidy data can be obtained from [Tidy Data by Hadley Wickham](http://vita.had.co.nz/papers/tidy-data.pdf).

## Raw Data
The raw data to tidy up represents data collected from the accelerometers from the Samsung Galaxy S smartphone. The data was built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. The data was labeled manually corresponding to video records.
A full description is available at the site where the data was obtained: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 
The raw data namely consists of 561 attributes (already preprocessed measurements) and 10299 observations for 30 individuals.
The labels were classified into six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

## Important Note
This repository does not entail the raw data, as GitHub is restricted on file size. It is recommended to download it [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and save it in the same directory with the R script called run_analysis.R to actually tidy up the raw data.



