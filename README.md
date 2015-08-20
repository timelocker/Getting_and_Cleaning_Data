# Getting_and_Cleaning_Data
course project for Getting and Cleaning Data in Coursera

This repo contains four files

1. CODEBOOK.md that explains where the raw data came from, and how variables were set
2. run_analysis.R which is R script that can be run with R
3. tidy_data.txt which is a result form run_analysis.R
4. README.md

- tidy_data.txt can be acquired by adding this code after running run_analysis.R
~~~~
write.table(tidydf, file = "tidy_data.txt", row.names = FALSE) 
~~~~



## Script description
~~~~
### OPENING FILES FROM WORKING DIRECTORY

# from the folder "UCI HAR Dataset"
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# from the folder "UCI HAR Dataset/test"
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# from the folder "UCI HAR Dataset/train"
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/y_train.txt")


### GIVING NAMES TO TABLES 

##   & Using descriptive activity names to name the activities in the data set

# Y files were in number so I used 'merge' function to create a row of activity names 
Y_test <- merge(Y_test, activity_labels, by.x = "V1", by.y = "V1")
Y_train <- merge(Y_train, activity_labels, by.x = "V1", by.y = "V1")

# creating column names for activity label
colnames(Y_test) <- c("activity_number", "activity_name")
colnames(Y_train) <- c("activity_number", "activity_name")

# creating column names for feature
featurenames <- as.vector(features$V2)
colnames(X_test) <- featurenames
colnames(X_train) <- featurenames

# creating column name for subject
colnames(subject_train) <- "Subject"
colnames(subject_test) <- "Subject"


### MERGING TRAINING SETS and DATA SETS

  #binding columns according to each group by using cbind()
test <- cbind(subject_test, Y_test, X_test)
train <- cbind(subject_train, Y_train, X_train)

  #binding two groups merging into one data set by using rbind()
rawdata <- rbind(test, train)
rawdata <- tbl_df(rawdata)


### SELECTING COLUMNS with MEAN or STANDARD DEVIATION.

#(I actually used 'names(rawdata)' and looked for every column that contains 'mean' and 'std')
df <- rawdata[,c(1:9, 44:49, 84:89, 124:129, 164:169, 204:205, 217:218,
                 230:231, 243:244, 256:257, 269:274, 348:353, 427:432,
                 506:507, 519:520, 532:533, 545:546)]


### CREATING A SECOND, INDEPENDENT TIDY DATA SET

### with the average of each variable for each activity and each subject.

# First, I grouped them
df2 <- group_by(df, Subject, activity_name)

# used summarise_each function to find means for every column
tidydf <- summarise_each(df2, funs(mean))

print(tidydf)
~~~~
