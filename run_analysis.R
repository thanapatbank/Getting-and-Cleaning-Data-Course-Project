#library(dplyr)
#library(data,table)
#library(plyr)

Main <- function(directory){
  AllData <- rbind(testset(directory),trainset(directory))
  SelectedData <- subset(AllData, select=AllData[,grepl("^subject$|^activity$|mean|std",colnames(AllData))])
  ActValue <- ActivityName(directory)
  for (i in 1:length(ActValue)) {
    SelectedData <- within(SelectedData, activity[activity == i] <- ActValue[i])
  }
  
  GroupData <- melt(SelectedData, id=c("subject", "activity"))  
  Result <- dcast(GroupData, subject + activity ~ variable, mean)
  
  Outpath <- file.path(directory)
  setwd(Outpath)
  write.csv(SelectedData, file="Output.txt", row.names=F)
  write.csv(Result, file="FeautureMean.txt", row.names=F)

  Result
}

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


testset <- function(directory){
  testpath <- file.path(paste0(directory,"\\test"))
  setwd(testpath)
  test_x_test <- fread(file = "X_test.txt", header = F, sep =" ")
  test_y_test <- fread(file = "y_test.txt", header = F, sep =" ")
  test_subject_test <- fread(file = "subject_test.txt", header = F, sep =" ")
  columnset <- headcolumn(directory)
  names(test_x_test) <- columnset
  test_combinded <- cbind(test_subject_test,test_y_test,test_x_test)
  names(test_combinded)[1]<-paste("subject")
  names(test_combinded)[2]<-paste("activity")
  test_combinded
}

trainset <- function(directory){
  trainpath <- file.path(paste0(directory,"\\train"))
  setwd(trainpath)
  train_x_train <- fread(file = "X_train.txt", header = F, sep =" ")
  train_y_train <- fread(file = "y_train.txt", header = F, sep =" ")
  train_subject_train <- fread(file = "subject_train.txt", header = F, sep =" ")
  columnset <- headcolumn(directory)
  names(train_x_train) <- columnset
  train_combinded <- cbind(train_subject_train,train_y_train,train_x_train)
  names(train_combinded)[1]<-paste("subject")
  names(train_combinded)[2]<-paste("activity")
  train_combinded
}

ActivityName <- function(directory){
  Actpath <- file.path(directory)
  setwd(Actpath)
  actName <- fread(file = "activity_labels.txt", header = F, sep =" ")
  actName$V2
}



