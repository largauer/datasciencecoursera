##Getting and Cleaning Data Course Project

##Step 1--------------------------------
##Read in the train data - merge with train subject and activity
data<-read.table("./train/X_train.txt", header=FALSE)
activity<-read.table("./train/y_train.txt",header=FALSE)
subject<-read.table("./train/subject_train.txt",header=FALSE)

train<-cbind(subject,activity,data)

##Read in the test data - merge with test subject and activity
data<-read.table("./test/X_test.txt", header=FALSE)
activity<-read.table("./test/y_test.txt",header=FALSE)
subject<-read.table("./test/subject_test.txt",header=FALSE)

test<-cbind(subject,activity,data)

##Merge train and test data
allData<-rbind(train,test)
##End Step 1----------------------------


##Step 2--------------------------------
##Give the columns names
colnames<-read.table("./features.txt",header=FALSE,
                     stringsAsFactors=FALSE)
colnames(allData)<-c("subject","activity", colnames[,2])

##Create a subset of column names that are only for mean and standard deviation
subNames<-colnames(allData)[grep("mean\\(|std\\(",colnames(allData))]
##Create the subset of data that only contains the mean and std readings
subData<-allData[,c("subject","activity",subNames)]
##End Step 2------------------------------


##Step 3 & 4--------------------------------
##Read in the activity labels
labels<-read.table("./activity_labels.txt",header=FALSE)
colnames(labels)<-c("activityIndex","activityName")
labels$activityName<-as.character(labels$activityName)

##Merge the activty labels with our dataset
mergeData<-merge(labels,subData,by.x="activityIndex",by.y="activity",all=TRUE)
#Remove the activity index column
mergeData<-mergeData[c(2:69)]
##Fix column names by removing bad characters (dashes and parentheses)
colnames(mergeData)<-gsub("-","",colnames(mergeData))
colnames(mergeData)<-gsub("\\(","",colnames(mergeData))
colnames(mergeData)<-gsub("\\)","",colnames(mergeData))
##Capitalize mean and std to create camel case
colnames(mergeData)<-gsub("mean","Mean",colnames(mergeData))
colnames(mergeData)<-gsub("std","Std",colnames(mergeData))


##Step 5-----------------------------------
## Create data table
library(data.table)
DT<-data.table(mergeData)
## Calculate the mean for each column by subject and activity
tidy<-DT[,lapply(.SD,mean),by=list(activityName,subject)]
##write out the tidy dataset to a file
write.table(tidy,"./tidy.txt",sep=",")