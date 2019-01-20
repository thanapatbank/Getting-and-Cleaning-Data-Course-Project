#These are library that require for run this script
library(dplyr)
library(data,table)
library(plyr)

#After load this R file. ONLY "Main" function should be call to run all process.
Main <- function(directory){
  #Collect all data into one dataset by calling test and train function to retrive sub dataset.
  AllData <- rbind(testset(directory),trainset(directory))
  
  #Extract only used column to process in next step
  SelectedData <- subset(AllData, select=AllData[,grepl("^subject$|^activity$|mean|std",colnames(AllData))])
  
  #Call Activity name file to replace value with string Name of each activity
  ActValue <- ActivityName(directory)
  for (i in 1:length(ActValue)) {
    SelectedData <- within(SelectedData, activity[activity == i] <- ActValue[i])
  }
  
  #Group data by melt function with "subject" and "activity" column
  GroupData <- melt(SelectedData, id=c("subject", "activity"))  
  
  #Finalize data with mean function of each group
  Result <- dcast(GroupData, subject + activity ~ variable, mean)
  
  #Set output path and write table out as text file
  Outpath <- file.path(directory)
  setwd(Outpath)
  write.table(SelectedData, file="Output.txt", row.names=F)
  write.table(Result, file="FeautureMean.txt", row.names=F)
  Result
}

#This will call features.txt file to set as referece of column name. Also clean the column name before send out to "Main" function.
#This function will called by "testset" and "trainset"
headcolumn <- function(directory){
  columnpath <- file.path(directory)
  setwd(columnpath)
  column_test <- fread(file = "features.txt", header = F, sep =" ")
  column_test <- gsub("-","",column_test$V2)
  column_test <- gsub(",","",column_test)
  column_test <- gsub("^t","Time",column_test)
  column_test <- gsub("^f","Frequency",column_test)
  column_test <- gsub("Acc","Accelerometer",column_test)
  column_test <- gsub("X","Xaxis",column_test)
  column_test <- gsub("Y","Yaxis",column_test)
  column_test <- gsub("Z","Zaxis",column_test)
  column_test <- gsub("\\()","",column_test)
  column_test
}

#This function will resemble all test text file into single test dataset
testset <- function(directory){
  #Call file and setup
  testpath <- file.path(paste0(directory,"\\test"))
  setwd(testpath)
  test_x_test <- fread(file = "X_test.txt", header = F, sep =" ")
  test_y_test <- fread(file = "y_test.txt", header = F, sep =" ")
  test_subject_test <- fread(file = "subject_test.txt", header = F, sep =" ")
  
  #Call headcolumn to retive the column name
  columnset <- headcolumn(directory)
  names(test_x_test) <- columnset
  
  #Combine all file and return
  test_combinded <- cbind(test_subject_test,test_y_test,test_x_test)
  names(test_combinded)[1]<-paste("subject")
  names(test_combinded)[2]<-paste("activity")
  test_combinded
}

#This function will resemble all train text file into single train dataset
trainset <- function(directory){
  #Call file and setup
  trainpath <- file.path(paste0(directory,"\\train"))
  setwd(trainpath)
  train_x_train <- fread(file = "X_train.txt", header = F, sep =" ")
  train_y_train <- fread(file = "y_train.txt", header = F, sep =" ")
  train_subject_train <- fread(file = "subject_train.txt", header = F, sep =" ")
  
  #Call headcolumn to retive the column name
  columnset <- headcolumn(directory)
  names(train_x_train) <- columnset
  
  #Combine all file and return
  train_combinded <- cbind(train_subject_train,train_y_train,train_x_train)
  names(train_combinded)[1]<-paste("subject")
  names(train_combinded)[2]<-paste("activity")
  train_combinded
}

#This function will called by "Main" function to change the lable of activity name
ActivityName <- function(directory){
  #Call file and setup then return only name column
  Actpath <- file.path(directory)
  setwd(Actpath)
  actName <- fread(file = "activity_labels.txt", header = F, sep =" ")
  actName$V2
}



