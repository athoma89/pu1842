# pu1842
## Tidying accelerometer data
This project tidies accelerometer data from the Human Activity Recognition using Smartphones Dataset,
provided by the UCI Machine Learning Repository.
The raw data is available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This code performs the following tasks:
* Sets the working directory and imports the relevant data from the unzipped file
* Stitches together the training and test data sets
* Extracts the subset of the 561 measured variables that consists of only mean and std measurements (86 variables)
* Binds together the datasets consisting of the subject codes, activity codes, and subset of measurements
* Replaces activity codes with descriptive names
* Condenses dataset into a 180x88 data frame by calculating the mean of each variable for each subject-activity pairing (30X6)
* Exports this final data frame as a text file
