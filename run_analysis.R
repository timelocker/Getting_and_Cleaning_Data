## opened files from working directory

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

## Giving names to tables 
##   & Using descriptive activity names to name the activities in the data set
Y_test <- merge(Y_test, activity_labels, by.x = "V1", by.y = "V1")
Y_train <- merge(Y_train, activity_labels, by.x = "V1", by.y = "V1")
colnames(Y_test) <- c("activity_number", "activity_name")
colnames(Y_train) <- c("activity_number", "activity_name")

featurenames <- as.vector(features$V2)
colnames(X_test) <- featurenames
colnames(X_train) <- featurenames

colnames(subject_train) <- "Subject"
colnames(subject_test) <- "Subject"


## MERGING training sets and data sets
  #binding columns according to each group
test <- cbind(subject_test, Y_test, X_test)
train <- cbind(subject_train, Y_train, X_train)
  #binding two groups merging into one data set
rawdata <- rbind(test, train)
rawdata <- tbl_df(rawdata)

## selecting columns with mean or standard deviation.
df <- rawdata[,c(1:9, 44:49, 84:89, 124:129, 164:169, 204:205, 217:218,
                 230:231, 243:244, 256:257, 269:274, 348:353, 427:432,
                 506:507, 519:520, 532:533, 545:546)]

## creating a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
df2 <- group_by(df, Subject, activity_name)
tidydf <- summarise_each(df2, funs(mean))

print(tidydf)




