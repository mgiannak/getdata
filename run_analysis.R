#libraries loading
library(plyr)
library(reshape2)

test_raw_data <- read.csv("test/X_test.txt",sep="",header=FALSE,colClasses="numeric")
train_raw_data <- read.csv("train/X_train.txt",sep="",header=FALSE,colClasses="numeric")
raw_data_merged <- rbind(test_raw_data,train_raw_data)

data_headers <- read.csv("features.txt",sep="",header=FALSE)
colnames(data_headers) <- c("ColumnIndex","Measure")
colnames(raw_data_merged) <- data_headers$Measure
#filters on column with "mean()" or "std()"
headers_to_keep <- data_headers[grep("mean\\(\\)|std\\(\\)",
                                     data_headers$Measure,
                                     ignore.case=TRUE),]
filtered_data <- raw_data_merged[,headers_to_keep$ColumnIndex]

test_activity <- read.csv("test/Y_test.txt",sep="",header=FALSE)
train_activity <- read.csv("train/Y_train.txt",sep="",header=FALSE)
activity_merged   <- rbind(test_activity,train_activity)

colnames(activity_merged) <- "Activity"
filtered_data_1 <- cbind(activity_merged,filtered_data)

test_subjects <- read.csv("test/subject_test.txt",sep="",header=FALSE,colClasses="numeric")
train_subjects <- read.csv("train/subject_train.txt",sep="",header=FALSE,colClasses="numeric")
subject_merged   <- rbind(test_subjects,train_subjects)
colnames(subject_merged) <- "Subject"
filtered_data_2 <- cbind(subject_merged,filtered_data_1)

activity_labels <- read.csv("activity_labels.txt",sep="",header=FALSE)
colnames(activity_labels) <- c("ActivityID","ActivityLabel")

final_data <- merge(activity_labels,filtered_data_2,by.x="ActivityID",by.y="Activity")
#translate columns to variables
melted_data <- melt(final_data,id.vars=c("ActivityID","ActivityLabel","Subject"))
#summarized_data = crosstab by Activity, Subject and variable name
tidy_data <- ddply(melted_data,c("ActivityID","ActivityLabel","Subject","variable"),summarize,mean=mean(value))
tidy_data <- tidy_data[,-1]
tidy_data$variable <- sub("^f","frequency.",tidy_data$variable)
tidy_data$variable <- sub("^t","time.",tidy_data$variable)
tidy_data$variable <- gsub("Body","body.",tidy_data$variable)
tidy_data$variable <- sub("Gravity","gravity.",tidy_data$variable)
tidy_data$variable <- sub("Acc","acceleration.",tidy_data$variable)
tidy_data$variable <- sub("Jerk","jerk.",tidy_data$variable)
tidy_data$variable <- sub("Gyro","gyroscope.",tidy_data$variable)
tidy_data$variable <- sub("\\-mean\\(\\)","mean.",tidy_data$variable)
tidy_data$variable <- sub("\\-std\\(\\)","standard_dev.",tidy_data$variable)
tidy_data$variable <- sub("Mag","magnitude.",tidy_data$variable)
tidy_data$variable <- sub("\\-X","xaxis",tidy_data$variable)
tidy_data$variable <- sub("\\-Y","yaxis",tidy_data$variable)
tidy_data$variable <- sub("\\-Z","zaxis",tidy_data$variable)
colnames(tidy_data) <- c("ActivityLabel","Subject","Measure","MeanValue")
