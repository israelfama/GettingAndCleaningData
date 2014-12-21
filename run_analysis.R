## Please, remember to download the files and to update the file directories in the following steps
##Reading the X_train data 
train_set = read.csv("C:/Users/israelfama/Documents/Coursera/Getting and cleaning data/UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
##Inserting the Y_train and subject_train data just after the last column
train_set[,562] = read.csv("C:/Users/israelfama/Documents/Coursera/Getting and cleaning data/UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
train_set[,563] = read.csv("C:/Users/israelfama/Documents/Coursera/Getting and cleaning data/UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
##Reading the X_test data
test_set = read.csv("C:/Users/israelfama/Documents/Coursera/Getting and cleaning data/UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
##Inserting the X_train and subject_train data just after the last column
test_set[,562] = read.csv("C:/Users/israelfama/Documents/Coursera/Getting and cleaning data/UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
test_set[,563] = read.csv("C:/Users/israelfama/Documents/Coursera/Getting and cleaning data/UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
##Reading the activities labels
activity = read.csv("C:/Users/israelfama/Documents/Coursera/Getting and cleaning data/UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

## Reading features
features = read.csv("C:/Users/israelfama/Documents/Coursera/Getting and cleaning data/UCI HAR Dataset/features.txt", sep="", header=FALSE)
##These three instrutions are a walk around for getting only features with -mean and -std in their names
##I've tried really hard, but couldn't come up with another solution
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

##Merging train_set and test_set
merged_data = rbind(train_set, test_set)

## Get only the data on mean and std. dev.
columns <- grep(".*Mean.*|.*Std.*", features[,2])
# First reduce the features table to what we want
features <- features[columns,]
# Adding subject and activity columns
columns <- c(columns, 562, 563)
# Removing columns from merged_data, hat won't bem used
merged_data <- merged_data[,columns]
# Add the column names (features) to merged_data
colnames(merged_data) <- c(features$V2, "Activity", "Subject")
colnames(merged_data) <- tolower(colnames(merged_data))

currentActivity = 1
for (currentActivityLabel in activity$V2) {
  merged_data$activity <- gsub(currentActivity, currentActivityLabel, merged_data$activity)
  currentActivity <- currentActivity + 1
}

merged_data$activity <- as.factor(merged_data$activity)
merged_data$subject <- as.factor(merged_data$subject)

tidy = aggregate(merged_data, by=list(activity = merged_data$activity, subject=merged_data$subject))
##Remove the subject and activity column
tidy[,90] = NULL
tidy[,89] = NULL
##Remove the last columns, since they show angle measurements
tidy[,88]=NULL
tidy[,87]=NULL
tidy[,86]=NULL
tidy[,85]=NULL
tidy[,84]=NULL
tidy[,83]=NULL
tidy[,82]=NULL
tidy[,81]=NULL
write.table(tidy, "C:/Users/israelfama/Documents/Coursera/Getting and cleaning data/tidy.txt", sep="\t")
