Code Book
=========
#1-Introduction


| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

The input data are the result of an experiment about 30 people doing different physical activities, in which a Smartphone equipped with two devices, an accelerometer and a Gyroscope, record data on such activities.
 
The purpose of this assignment is to design a program in R (“run_analysis.R”)that, from the raw data obtained in the experiment, generates two tidy data set: One of them, named  data_4.txt, contains the data to the level of detail presented in the original. The second, called data_5.txt, contains a summary of the last data set with the average, for all observations, of each activity-subject combination.

A more comprehensive description is in the next link:
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

#2-Process of transformation: from the raw data to the tidy data

##2.1-Row data: input files

The necessary row-data for the assignment are, with their descriptions, into the files of the next table. The files with dimensions contain the row data and will be the inputs of the program. Additionally, there are two files that contain information about the rest of them.

| Directorio |	Fichero |	Description |	Dimensiones |
| :-------------: | :-------------: | :-------------: | :-------------: |
UCI/HAR Dataset|activity_labels.txt|	2 columns, with the activity label and the name of the activity.|	6*2|
	|features.txt|	2 columns, with the label and the name of the measurement   feature.|	561*2
	|features_info.txt|	Description of the measurement feature.| 	
	|README.txt|	Description of the whole set of files.|	
UCI/HAR Dataset/test|	subject_test.txt|	1 column, with the person label who did the activity in one observation and was selected for the test subset. 
(There are two subsets: one of them,with 2947 people, –test- is defined in that column)|	2947*1|
	|X_test.txt|	561 columns with the measurements registered in the observations from the people of the test set. Each column contains the observations of each measurement feature.|2947*561
	|y_test	1 column, with the activity label  done by the person in each observation from the test subset|
	2947*1
UCI/HAR Dataset/train|	subject_train.txt|	1 column, with the label of the person who did the activity in one observation and was selected for the train subset.(There are two subsets: one of them, with 7352 people, –train- is defined in that column) |	7352*1
	|X_train.txt|	561 columns with the measurements registered in the observations from the people of the train set. Each column contains the observations of each measurement feature.| 	7352*561
	|y_train.txt|	1 column, with the label of the activity done by the person in each observation from the train label.|	7352*1

Note: The files included into the directories named “./Inertial Signals”, that are in UCI/HAR Dataset/test  and in UCI/HAR Dataset/train, won’t be treated in this assignment.

##2.2-merging data

The first task is to obtain a unique data set with the whole of the relevant variables and  recorded observations. It will be done in two steps:

-Adding two columns to the “X” data: The measurement information for feature measurement is completed by adding two variables, subject and activity, that are respectively in the “subject” and “y”   tables.  This operation is performed on each of the two subsets, train and test.

-Merging the two files created in the last step. This is a sensible operation because  the variables are similar in both subsets. The result file is named data_1.txt, that contains the whole of the observations and variables: (10299*563).

##2.3-selecting data

In order to select the columns required by the assignment, it is necessary to rename the columns that contain the measurement features. So, they will be renamed using the information from the features table (2th column) which is transferred to the first row (row names) of our data, giving the name to the last 561 columns.
 
Now it is possible to select, such as the assignment says, the measurement features that contain in its description the words “mean” or “std” (arithmetic mean and standard deviation). A selection from data of the columns whose name contains any of these two words is performed, and the number of features measurement is reduced to 66 (from 561 initial).

##2.4-reshaping data

We believe that the most suitable form to represent a tidy data format is a narrow form: the 66 columns representing the measurement features are, actually, values of a single variable, which we call "feature". Therefore , for each observation we will have a combination of subject + activity + feature, to which will correspond to a "measurement" .

In order to do that, we will substitute the 66 columns by two columns: one (“feature”) with the key-variable and other (“measurement”) with the associated value. The result is a Data Frame with 4 variables: subject, activity, feature and measurement.

##2.5-renaming variables
 
The two first columns are renamed to “subject” and “activity”.

##2.6-renaming variable values

-activity: The values of the column that contains the activity in the raw data (numeric:1 to 6) are updated to their names(WALKING,SITTING,….), linking and updating each of the keys with the name contained in the activity_labels table.

-feature: The values in this variable (66 values) are updated according to the following changes in the texts of them:
-	“t” and “f” prefix are renamed to “time” and “frequency”
-	Acc y Gyro : No changes, because they are representative enough of Accelerometer and Gyroscope.  
-	BodyBody :  The mistake is corrected with Body
-	-“-“ y “()” are removed.
-	I decided not to apply the rule of letters in lower case, because the high number of letters in the values of feature  would reduce the readability a lot.

Once applied these changes, the values are like we can see in the detail of the feature variable in section 3.3

The process of transformation of the raw data in a set of tidy-data ends with a data set that is presented in the file data_4.txt.
  
##2.7-summarizing data

At last, in order to present the second of the tables requested in the assignment, an operation of data-summarizing is performed in this part.  the mean of the measurement is calculated for the whole of the observations included in each of the combinations subject/ activity. This process generates a smaller table with 180 observations (30 subj * 6 activ) with three variables table: activity,subject, and mean. This last table is named data_5.txt, within the outputs of the program.
 

#3-Codebook

For each one of the output tables, the description and values of each one of their variables is performed below.

##3.1-CODEBOOK  of data_4.txt

		
			
	|Variable|	Description|	Values|
	|subject|	Code of the person who makes the experiment|	30 values|
			||	with numeric code|
			||from 1 to 30|
	|activity|	activity that is made by the person while is making the| 	6 values|
		|experiment.|	WALKING|
		||	WALKING_UPSTAIRS|
		||	WALKING_DOWNSTAIRS|
		||	SITTING|
		||	STANDING|
		11	LAYING|
	|feature|	measurement class registered, depending of a set of| 	view the values| 
	||	features like signal type, device class, indicator, axis.	|In section 9.3|
	|measurement|	numeric value registered in the experiment, according the|	Numeric|
	||	 conditions defined in the feature variable|	betwin -1 and 1|
	||	This is a normalized value between -1 and 1	|
			
		
			
			
			
			
			
		

##3.2-CODEBOOK  of data_5.txt

subject	Code of the person who makes the experiment	the same as dat_4.txt
activity	activity that is made by the person while is making the 	the same as dat_4.txt
	experiment.	
mean	mean of all the values of measurement in 	numeric
	the set subject/activity	







			
##3.3-CODEBOOK of the values of feature variable
			
			
raw data feature values	tidy data feature values		Description		
feature		domain	signal	device	indicator	axial
tBodyAcc-mean()-X	timeBodyAccMeanX	time	Body	Acc	Mean	X
tBodyAcc-mean()-Y	timeBodyAccMeanY	time	Body	Acc	Mean	Y
tBodyAcc-mean()-Z	timeBodyAccMeanZ	time	Body	Acc	Mean	Z
tBodyAcc-std()-X	timeBodyAccStdX	time	Body	Acc	Std	X
tBodyAcc-std()-Y	timeBodyAccStdY	time	Body	Acc	Std	Y
tBodyAcc-std()-Z	timeBodyAccStdZ	time	Body	Acc	Std	Z
tGravityAcc-mean()-X	timeGravityAccMeanX	time	Gravity	Acc	Mean	X
tGravityAcc-mean()-Y	timeGravityAccMeanY	time	Gravity	Acc	Mean	Y
tGravityAcc-mean()-Z	timeGravityAccMeanZ	time	Gravity	Acc	Mean	Z
tGravityAcc-std()-X	timeGravityAccStdX	time	Gravity	Acc	Std	X
tGravityAcc-std()-Y	timeGravityAccStdY	time	Gravity	Acc	Std	Y
tGravityAcc-std()-Z	timeGravityAccStdZ	time	Gravity	Acc	Std	Z
tBodyAccJerk-mean()-X	timeBodyAccJerkMeanX	time	Body	AccJerk	Mean	X
tBodyAccJerk-mean()-Y	timeBodyAccJerkMeanY	time	Body	AccJerk	Mean	Y
tBodyAccJerk-mean()-Z	timeBodyAccJerkMeanZ	time	Body	AccJerk	Mean	Z
tBodyAccJerk-std()-X	timeBodyAccJerkStdX	time	Body	AccJerk	Std	X
tBodyAccJerk-std()-Y	timeBodyAccJerkStdY	time	Body	AccJerk	Std	Y
tBodyAccJerk-std()-Z	timeBodyAccJerkStdZ	time	Body	AccJerk	Std	Z
tBodyGyro-mean()-X	timeBodyGyroMeanX	time	Body	Gyro	Mean	X
tBodyGyro-mean()-Y	timeBodyGyroMeanY	time	Body	Gyro	Mean	Y
tBodyGyro-mean()-Z	timeBodyGyroMeanZ	time	Body	Gyro	Mean	Z
tBodyGyro-std()-X	timeBodyGyroStdX	time	Body	Gyro	Std	X
tBodyGyro-std()-Y	timeBodyGyroStdY	time	Body	Gyro	Std	Y
tBodyGyro-std()-Z	timeBodyGyroStdZ	time	Body	Gyro	Std	Z
tBodyGyroJerk-mean()-X	timeBodyGiroJerkMeanX	time	Body	GiroJerk	Mean	X
tBodyGyroJerk-mean()-Y	timeBodyGiroJerkMeanY	time	Body	GiroJerk	Mean	Y
tBodyGyroJerk-mean()-Z	timeBodyGiroJerkMeanZ	time	Body	GiroJerk	Mean	Z
tBodyGyroJerk-std()-X	timeBodyGiroJerkSstdX	time	Body	GiroJerk	Std	X
tBodyGyroJerk-std()-Y	timeBodyGiroJerkSstdY	time	Body	GiroJerk	Std	Y
tBodyGyroJerk-std()-Z	timeBodyGiroJerkSstdZ	time	Body	GiroJerk	Std	Z
tBodyAccMag-mean()	timeBodyAccMagMmean	time	Body	AccMag	Mean	no axial
tBodyAccMag-std()	timeBodyAccMagStd	time	Body	AccMag	Mean	no axial
tGravityAccMag-mean()	timeGravityAccMagMean	time	Gravity	AccMag	Mean	no axial
tGravityAccMag-std()	TimeGravityAccMagStd	time	Gravity	AccMag	Std	no axial
tBodyAccJerkMag-mean()	TimeBodyAccJerkMagMean	time	Body	AccJerkMag	Mean	no axial
tBodyAccJerkMag-std()	TimeBodyAccJerkMagStd	time	Body	AccJerkMag	Std	no axial
tBodyGyroMag-mean()	TimeBodyGiroMagMean	time	Body	GiroMag	Mean	no axial
tBodyGyroMag-std()	TimeBodyGiroMagStd	time	Body	GiroMag	Std	no axial
tBodyGyroJerkMag-mean()	TimeBodyGyroJerkMagMean	time	Body	GyroJerkMag	Mean	no axial
tBodyGyroJerkMag-std()	TimeBodyGyroJerkMagStd	time	Body	GyroJerkMag	Std	no axial
fBodyAcc-mean()-X	FrequencyBodyAccMeanX	frequency	Body	Acc	Mean	X
fBodyAcc-mean()-Y	FrequencyBodyAccMeanY	frequency	Body	Acc	Mean	Y
fBodyAcc-mean()-Z	FrequencyBodyAccMeanZ	frequency	Body	Acc	Mean	Z
fBodyAcc-std()-X	FrequencyBodyAccStdX	frequency	Body	Acc	Std	X
fBodyAcc-std()-Y	FrequencyBodyAccStdY	frequency	Body	Acc	Std	Y
fBodyAcc-std()-Z	FrequencyBodyAccStdZ	frequency	Body	Acc	Std	Z
fBodyAccJerk-mean()-X	FrequencyBodyAccJerkMeanX	frequency	Body	AccJerk	Mean	X
fBodyAccJerk-mean()-Y	FrequencyBodyAccJerkMeanY	frequency	Body	AccJerk	Mean	Y
fBodyAccJerk-mean()-Z	FrequencyBodyAccJerkMeanZ	frequency	Body	AccJerk	Mean	Z
fBodyAccJerk-std()-X	FrequencyBodyAccJerkStdX	frequency	Body	AccJerk	Std	X
fBodyAccJerk-std()-Y	FrequencyBodyAccJerkStdY	frequency	Body	AccJerk	Std	Y
fBodyAccJerk-std()-Z	FrequencyBodyAccJerkStdZ	frequency	Body	AccJerk	Std	Z
fBodyGyro-mean()-X	FrequencyBodyGyroMeanX	frequency	Body	Gyro	Mean	X
fBodyGyro-mean()-Y	FrequencyBodyGyroMeanY	frequency	Body	Gyro	Mean	Y
fBodyGyro-mean()-Z	FrequencyBodyGyroMeanZ	frequency	Body	Gyro	Mean	Z
fBodyGyro-std()-X	FrequencyBodyGyroStdX	frequency	Body	Gyro	Std	X
fBodyGyro-std()-Y	FrequencyBodyGyroStdY	frequency	Body	Gyro	Std	Y
fBodyGyro-std()-Z	FrequencyBodyGyroStdZ	frequency	Body	Gyro	Std	Z
fBodyAccMag-mean()	FrequencyBodyAccMagMean	frequency	Body	AccMag	Mean	no axial
fBodyAccMag-std()	FrequencyBodyAccMagStd	frequency	Body	AccMag	Std	no axial
fBodyBodyAccJerkMag-mean()	frequencyBodyAccJerkMagMean	frequency	Body	AccJerkMag	Mean	no axial
fBodyBodyAccJerkMag-std()	frequencyBodyAccJerkMagStd	frequency	Body	AccJerkMag	Std	no axial
fBodyBodyGyroMag-mean()	FrequencyBodyGiroMagMean	frequency	Body	GiroMag	Mean	no axial
fBodyBodyGyroMag-std()	FrequencyBodyGiroMagStd	frequency	Body	GiroMag	Std	no axial
fBodyBodyGyroJerkMag-mean()	frequencyBodyGyroJerkMagMean	frequency	Body	GyroJerkMag	Mean	no axial
fBodyBodyGyroJerkMag-std()	frequencyBodyGyroJerkMagStd	frequency	Body	GyroJerkMag	Std	no axial
			
			
			
