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
activity_labels$ActivityLabel <- tolower(activity_labels$ActivityLabel)

final_data <- merge(activity_labels,filtered_data_2,by.x="ActivityID",by.y="Activity")
#remove "ActivityID column"
final_data <- final_data[,-1]
#translate columns to variables
melted_data <- melt(final_data,id.vars=c("ActivityLabel","Subject"))
melted_data$variable <- sub("^f","frequency.",melted_data$variable)
melted_data$variable <- sub("^t","time.",melted_data$variable)
melted_data$variable <- gsub("Body","body.",melted_data$variable)
melted_data$variable <- sub("Gravity","gravity.",melted_data$variable)
melted_data$variable <- sub("Acc","acceleration.",melted_data$variable)
melted_data$variable <- sub("Jerk","jerk.",melted_data$variable)
melted_data$variable <- sub("Gyro","gyroscope.",melted_data$variable)
melted_data$variable <- sub("\\-mean\\(\\)","mean.",melted_data$variable)
melted_data$variable <- sub("\\-std\\(\\)","standard_dev.",melted_data$variable)
melted_data$variable <- sub("Mag","magnitude.",melted_data$variable)
melted_data$variable <- sub("\\-X","xaxis",melted_data$variable)
melted_data$variable <- sub("\\-Y","yaxis",melted_data$variable)
melted_data$variable <- sub("\\-Z","zaxis",melted_data$variable)
colnames(melted_data) <- c("ActivityLabel","Subject","Measure","Value")
#summarized_data = crosstab by Activity, Subject and variable name
tidy_data <- ddply(melted_data,c("ActivityLabel","Subject","Measure"),summarize,mean=mean(Value))
colnames(tidy_data) <- c("ActivityLabel","Subject","Measure","MeanValue")
write.table(tidy_data,"tidydata.txt",row.names=FALSE)