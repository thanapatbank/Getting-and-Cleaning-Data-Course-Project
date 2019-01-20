# Getting and Cleaning Data Course Project
This repo if for Peer-graded Assignment for Getting and Cleaning Data Course

## The dataset used in this assessment is from following publication
by Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## What is script do
### In short term
This script will show dataset of Human Activity Recognition on Smartphones as group by subject and activity with value of mean of each feature.
### In long term
This script will resemble train and test dataset of Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine as one dataframe. Next it will extracts only mean and standard deviation column of each measurement. Then clean variable name of each column and value of activity column for the most people can be able to understand of the dataset. Finally it will show dataset as group by subject and activity with value of mean of all feature. 

## How to run this script
This script is contain five function as "Main", "headcolumn", "testset", "trainset", "ActivityName". The **"Main"** function is the **ONLY** one that need to call to do all the process. "Main" function is require directory as parameter where directory is the path that required file of UCI HAR Dataset. "Main" function can all by **Main(directory)**.

### Input
Only one Input that required is the directory where contain all file.

### Output
Output will write out FeatureMean.txt which is the average of all features per sample and activity.

###### How this script process is writed as comment in the R script
