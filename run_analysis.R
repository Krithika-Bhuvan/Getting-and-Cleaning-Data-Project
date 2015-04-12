#setwd("C:\\1_TO_BE_SYNCED\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset")
setwd("/Users/krithikabhuvaneshwar/krithika_laptop/4_personal/tutorials/2015Coursera_DataScience/Getting_and_cleaning_data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")

#### Merges the training and the test sets to create one data set.

## 1 and 4 : load test and trainng set
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

features <- read.table("features.txt")

names(x_train) <- unlist(features[,2])
complete_train <- cbind(subject_train[,1],y_train, x_train) # complete traning set
names(complete_train)[1] <- "subject_id"
names(complete_train)[2] <- "activity_id"

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")
names(x_test) <- unlist(features[,2])
complete_test <- cbind(subject_test[,1],y_test,x_test) # complete test set
names(complete_test)[1] <- "subject_id"
names(complete_test)[2] <- "activity_id"
#combine test and train set
complete_data <- rbind(complete_train,complete_test)
complete_df <- as.data.frame(complete_data)

####2. Extracts only the measurements on the mean and standard deviation for each measurement. 
ckages("dplyr")
#detach("plyr") 
library(dplyr)

columnNames <- colnames(complete_df)
columnNamesMean <- grep(".*mean\\().*",columnNames,ignore.case = T) #33 columns
columnNamesSD <- grep(".*std\\().*",columnNames,ignore.case = T) #33 columns

short_Mean <- select(.data = complete_df,columnNamesMean)
short_SD <- select(.data = complete_df,columnNamesSD)
short_df <- cbind(complete_df$subject_id,complete_df$activity_id,short_Mean,short_SD) #66 columns of measurement s + subject id + activity id

#
colnames(short_df)[1] <- "subject_id"
colnames(short_df)[2] <- "activity_id"

####3. labeling activity names
#adding proper labels
x1 <- gsub(pattern = 1, "1_WALKING", x=short_df[,2])
x1 <- gsub(pattern = 2 ,"2_WALKING_UPSTAIRS", x=x1)
x1 <- gsub(pattern = 3 ,"3_WALKING_DOWNSTAIRS", x=x1)
x1 <- gsub(pattern = 4 ,"4_SITTING", x=x1)
x1 <- gsub(pattern = 5 ,"5_STANDING", x=x1)
x1 <- gsub(pattern = 6 ,"6_LAYING", x=x1)

short_df[,2] <- x1

### How to make tidy data

# first group the data frame by subject_id and then activity_id. Make sure that both values are "factors" and not numbers.
group1 <- arrange(short_df,subject_id,activity_id)
# melt the grouped data, so that it will keep subject_id and activity_id and melt everything else into a narrow column called "variable"
melt1 <- melt(group1, id.vars = c("subject_id","activity_id") , measure.vars = 3:68)
# Keeping the subject_id and activity ID on the left side, apply mean() on the "variable" column
dcast1 <- dcast(melt1,subject_id + activity_id ~ variable, mean)
write.table(dcast1,"tidy.data1.txt",quote = F,row.names = F)

#### Another way to make the tidy data using loop
library(reshape2)

aggr1 <- aggregate(group1[,3] ~ subject_id + activity_id, data=group1, mean)
colnames(aggr1)[3] <- colnames(group1)[3]
#doing this to get the correct subject id and activity id format

#calling function to get the rest of the values
aggr2 <- sapply(group1[,4:68],FunctionAggregate) # you will get same answer with mapply()   

FunctionAggregate <- function(m) {
    aggr <- aggregate( m ~ subject_id + activity_id, data=group1, mean)
    return(aggr[,3])
}
       
final.aggr <- cbind(aggr1,aggr2)
write.table(final.aggr,"tidy.data2.txt",quote = F,row.names = F)

