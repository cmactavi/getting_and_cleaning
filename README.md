---
title: "README"
author: "Carrie MacTavish"
date: "22 November 2014"
---

Script contains the function:

tidy_data <- function(path, outfile) 

The raw data are collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

This script merges the training and the test sets to create one tidy data set. 

Requires installation of:

*install.packages("qdap")
*library(qdap)

Code runs via eg: 

$> tidy_data("/your/path/to/working/dir", "tidy_data.txt")$

The code performs the following:
        
*Sets working dir, downlowd data and unzip
*Reads raw data sets
*Reads in the activity labels key
*Reads in the features names
*Gets indices for mean and std fields
*Creates subset of mean and std data fields
*Combines test and train subjects and activities fields
*Gives columns decriptive names
*Uses aggregate to find the mean of feature observations (having extracted only 
         the measurements on the mean and standard deviation for each measurement) 
         for each subject and each activity.
*Convert activity numbers into activity names
*Write out data to outfile
     

