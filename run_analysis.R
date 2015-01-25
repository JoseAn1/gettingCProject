## run_analysis.R

### 0-getting raw data

loc_gen<-"./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/"
loc_test<-paste0(loc_gen,"test/")
loc_train<-paste0(loc_gen,"train/")

activity_labels<-read.table(paste0(loc_gen,"activity_labels.txt"))
features<-read.table(paste0(loc_gen,"features.txt"))

subject_test<-read.table(paste0(loc_test,"subject_test.txt"))
y_test<-read.table(paste0(loc_test,"y_test.txt"))
X_test<-read.table(paste0(loc_test,"X_test.txt"))

subject_train<-read.table(paste0(loc_train,"subject_train.txt"))
y_train<-read.table(paste0(loc_train,"y_train.txt"))
X_train<-read.table(paste0(loc_train,"X_train.txt"))


### 1-merging test and training in a unique data set

##   1.1-merging test subject,activity and features in measuring_test
measurement_test<-data.frame(cbind(subject_test,y_test,X_test),check.names=T)

##   1.2-merging train subject,activity and features in measuring_train
measurement_train<-data.frame(cbind(subject_train,y_train,X_train),check.names=T)

##   1.3-merging test and training
data<-rbind(measurement_test,measurement_train)

data_1<-data
write.table(data_1,row.name=FALSE,file="data_1.txt")

### 2-Extracting the measurements on the mean and standard deviation for each measurement 
  
##   2.1-renaming the last 561 columns ( from V1.2 to V561), that contain measurements.
names(data)[3:563]<-as.character(features$V2)

##   2.2-selecting measurements for "mean" and "std"
sel<-grep("mean[^F]|std",names(data))
data<-data[c(1:2,sel)]

data_2<-data
write.table(data_2,row.name=FALSE,file="data_2.txt")

### 3-Using descriptive activity names to name the activities in the data set
##  creating new variable for the name of the activity from activity_label
data<-merge(data,activity_labels,by.x="V1.1",by.y="V1")
##  dropping activity label, because one variable, one column. 
data<-data[-1]

data_3<-data
write.table(data_3,row.name=FALSE,file="data_3.txt")
data_o<-data
### 4-Appropriately labels the data set with descriptive variable names.
##   4.1-naming V1 and V2
names(data)[1]<-"subject"
names(data)[68]<-"activity"
##   4.2-the features columns
##   reshaping data: the  66 columns aren't variables. (they contain values of one variable)
library(tidyr)
data<-gather(data,feature,measurement,-c(subject,activity))

##   cleaning and separating data for the analysis:

data$feature<-gsub("^t","time-",data$feature)
data$feature<-gsub("^f","frequency-",data$feature)
data$feature<-gsub("mean","Mean",data$feature)
data$feature<-gsub("std","Std-",data$feature)
data$feature<-gsub("Acc","-Acc-",data$feature)
data$feature<-gsub("Gyro","-Gyro-",data$feature)
data$feature<-gsub("Acc-Jerk-","AccJerk-",data$feature)
data$feature<-gsub("Acc-Mag-","AccMag-",data$feature)
data$feature<-gsub("Acc-JerkMag-","AccJerkMag-",data$feature)
data$feature<-gsub("Gyro-Jerk-","GiroJerk-",data$feature)
data$feature<-gsub("Gyro-Mag-","GiroMag-",data$feature)
data$feature<-gsub("Gyro-JerkMag-","GyroJerkMag-",data$feature)
data$feature<-gsub("--","-",data$feature)
data$feature<-gsub("BodyBody","Body",data$feature)
data$feature<-gsub("\\()","",data$feature)
data<-separate(data,col=feature,into=c("domain","signal","device","variable","axial"),sep="-",extra="merge")
##naming NA values in axial: observations where there aren't axials.
na<-is.na(data$axial)
nad_v<-data[na,"axial"]
nad_v<-c(rep("",length(nad_v)))
data$axial[na]<-nad_v

data$feature<-paste0(data$domain,data$signal,data$device,data$variable,data$axial)
data<-data[c(1,2,9,8)]
data$subject<-as.factor(data$subject)
data$feature<-as.factor(data$feature)

library(dplyr)


data_4<-data
write.table(data_4,row.name=FALSE,file="data_4.txt")

###5. From the data set in step 4, creates a second, independent tidy data set with the average of each
#variable for each activity and each subject.
data<-tbl_df(data)
by_activity_subject<-group_by(data,activity,subject)
data<-summarize(by_activity_subject,mean=mean(measurement))

data_5<-data
write.table(data_5,row.name=FALSE,file="data_5.txt")









