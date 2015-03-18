# JHUDS-GCData-Project
This repository is dedicated to upload and share the Course Project analysis for the Coursera Getting and Cleaning data provided by JHU

The analysis performed by the code run_analysis.R has 5 main steps/objectives as required by the Course Project description:

The code does:
*Merges the training and the test sets to create one data set.
*Extracts only the measurements on the mean and standard deviation for each measurement
*Uses descriptive activity names to name the activities in the data set
*Appropriately labels the data set with descriptive variable names. 
*From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Step 1 - Import data

*read.table function is used to import all the different datasets provided into several R variables. label and traning name dictionary are also imported.

## Step 2 - Combine subject, training and measurements

*rbind function is used to merge the subject, training type and measurement datasets
        *this is done for both the traininf and the testing groups, producing two main data frames: test and train
        

## Step 3 - Combine datasets

*cbind function is used to combine the two main data frames: test and train, creating "data"

*previousto this step, columns are renamed for easy undertanding


## Step 4 - Select only means and standard deviations

*Only variables that contain mean() and std() are selected. using grepl() function
*Columns are renamed extracting their names from the labels dataset
*Training names are added to the datset using the provided dictionary through a merge function


## Step 5 - Create aggregated dataset

*melt and cast functions from the reshape2 package are used to aggregate the measures by subject and training and calculating the averages: data_use_agg


## Step 6 - Export

*aggregated dataset is exported into a txt tile
