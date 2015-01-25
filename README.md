Course Project
==============
# 1-getting data
The data are obtained downing the next zip file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
in our working directory.
Once downloaded, it will be unzipped, answering “yes” to all the default directories. At the end, we should have the next directories structure, rooted in our working directory:

./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/

The necessary files downloaded and unzipped will be the next 9 files :

Into the /UCI HAD Dataset directory:

 + activity_labels.txt
 + features.txt
 + features_info.txt
  
Into the UCI/HAR Dataset/test directory

 . subject_test.txt
 . X_test.txt
 . y_test.txt
  
And into the UCI/HAR Dataset/train directory:

 . subject_train.txt
 . X_train.txt
 . y_train
  
2-running “run_analysis.R”
This file is runned in R; It is necessary to have installed the libraries tidyr and dplyr.

After the execution, we can view, in the working directory, the 5 text files which correspond to the result of the five assignment specifications:

1.	Merges the training and the test sets to create one data set : fichero data_1.txt
2.	Extracts only the measurements on the mean and standard deviation for each measurement: fichero data_2.txt file
3.	Uses descriptive activity names to name the activities in the data set: data_3.txt file
4.	Appropriately labels the data set with descriptive variable names: data_4.txt file 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject: data_5.txt file
	
In order to see, for instance, the file number 5 in R, you must write the next command line:

data5<-read.table(“data_5.txt”,header=TRUE)






