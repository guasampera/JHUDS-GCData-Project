
## Importing datasets into R

#Training dataset

train_subject <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt")
train_data <- read.table(file = "./UCI HAR Dataset/train/X_train.txt")
train_type <- read.table(file = "./UCI HAR Dataset/train/y_train.txt")


#Testing dataset

test_subject <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt")
test_data <- read.table(file = "./UCI HAR Dataset/test/X_test.txt")
test_type <- read.table(file = "./UCI HAR Dataset/test/y_test.txt")


#labels and features

training_names <- read.table(file = "./UCI HAR Dataset/activity_labels.txt")
labels <- read.table(file = "./UCI HAR Dataset/features.txt")



#Subject and training type are added to the databases
train <- cbind(train_subject,train_type,train_data)
test <- cbind(test_subject,test_type,test_data)

# relabeling dataframes 1
names(train)[1:2] <- c("train_subject","train_type_code")
names(test)[1:2]  <- c("train_subject","train_type_code")

# merge train and test datasets
data <- rbind(train,test)

# Extract only the measurements on the mean and standard deviation for each measurement
#Identify mean and std columns
column_list <- labels[grepl("mean()",labels$V2,fixed = TRUE) | grepl("std()",labels$V2,fixed = TRUE),]
#select columns
data_use <- data[,c(1,2,column_list$V1+2)]
#relabel columns
names(data_use)[3:ncol(data_use)] <- as.character(column_list$V2)


# Add names to the train types
names(training_names)[1:2] <- c("train_type_code","train_type")
data_use <- merge(data_use, training_names, by="train_type_code")



#From the data set in last step, create a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

data_use_agg <- melt(data_use,id=c("train_subject","train_type"))
data_use_agg <- dcast(data_use_agg, train_subject + train_type ~ variable, mean)

data_use_agg <- subset(data_use_agg, select = -train_type_code) #drop auxuliar column


#Output Export
write.table(x = data_use_agg, file="./output_tidy.txt",row.name=FALSE)

