# Getting-and-Cleaning-Data
R Programme for analysis of Samsung smartphone accelerometer and gyroscope data


This function performs the following tasks :

1. Merge the training and the test sets to create one data set.

2. Extract only the measurements on the mean and standard deviation for each measurement. 

3. Use descriptive activity names to name the activities in the data set

4. Appropriately label the data set with descriptive variable names. 

5. From the data set in step 4, create a second, independent tidy data set with the average 
  of each variable for each activity and each subject.

In addition, a final step is included to write out the final result to the working directory

NB. although the function has input variables (parameters), in fact this was never required to complete the task
and so the program can be successfully executed using the command run_analysis()

# Programme Design Summary
The programme works as follows:

1. First it establishes its working directory and loads the dplyr library 

2. Next it reads in the X, Y and subject datasets for the testing data and cbinds them together

3. This is repeated for the training data

4. The column names are they adjusted to ensure uniqueness

4. The training and testing datasets are then joined using merge

5. Next, the Activity codes are converted to meaningful text ("Laying" etc) for ease of interpretation

6. Now, the required rows are gathered by cbinding each contiguous set in turn until they are all held in extract_df

7. The column names are now modified to provide the variable names for the final output dataset

8. extract_df is now written to tbl_df extract_df and this can now be sorted by activity within subject, using 'arrange'

9. once sorted, the data is next grouped by subject and activity (using group_by)

10. The data is finally summarised to calculate and store the mean of each variable as per the grouping.

11. The final dataset "Summarised_Averages" is then written to the working directory


# CODE BOOK
Using the variable names found in dataset "features_info", the following measurements were identified in the input data

tBodyAcc-XYZ ,
tGravityAcc-XYZ ,
tBodyAccJerk-XYZ ,
tBodyGyro-XYZ ,
tBodyGyroJerk-XYZ ,
tBodyAccMag ,
tGravityAccMag ,
tBodyAccJerkMag ,
tBodyGyroMag ,
tBodyGyroJerkMag ,
fBodyAcc-XYZ ,
fBodyAccJerk-XYZ ,
fBodyGyro-XYZ ,
fBodyAccMag ,
fBodyAccJerkMag ,
fBodyGyroMag ,
fBodyGyroJerkMag .

The exercise only requires an extract of the measurements of mean and standard deviation for these variables
These were identified and extracted. 

NB. the final three variables were incorrectly named in the "features" dataset that
was used to identify the columns for each variable (body was repeated, so fBodyBodyGyroMag instead of fBodyGyroMag !!)

NB. XYZ above indicates that there are 3 separate values for these variables (with suffixes X, Y, Z)

In the output dataset, the names of the variables have been modified slightly using the prefix 'mean' and 'std' to
identify the mean value and standard deviation for each measurement

This means that for each X, Y, Z and Mag version of a variable there are two output variables, so for example, looking at the BodyAcc measurements, the output dataset contains ...

mean_tBodyAcc_X, mean_tBodyAcc_Y, mean_tBodyAcc_Z, 
std_tBodyAcc_X, std_tBodyAcc_Y, std_tBodyAcc_Z,
mean_tBodyAccMag, std_tBodyAccMag ,
mean_fBodyAcc_X, mean_fBodyAcc_Y, mean_fBodyAcc_Z, 
std_fBodyAcc_X, std_fBodyAcc_Y, std_fBodyAcc_Z,
mean_fBodyAccMag, std_fBodyAccMag

The output dataset contains 6 rows for each participant (so 180 rows for the sample data provided). This is because
the data is summarised over each of the six defined activities (Laying, Sitting, Standing, Walking, Walking Downstairs, and Walking Upstairs), for each participant.
