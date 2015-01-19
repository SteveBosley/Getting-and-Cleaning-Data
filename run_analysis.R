run_analysis <- function (parameters) {
        ###############################################################################################################
        ## This function performs the following tasks :
        ## 1. Merge the training and the test sets to create one data set.
        ## 2. Extract only the measurements on the mean and standard deviation for each measurement. 
        ## 3. Use descriptive activity names to name the activities in the data set
        ## 4. Appropriately label the data set with descriptive variable names. 
        ## 5. From the data set in step 4, create a second, independent tidy data set with the average 
        ##    of each variable for each activity and each subject.
        ###############################################################################################################
        
        ## Set Working Directory
        setwd("D:/Coursera/Getting and Cleaning Data")
        
        ## Set libraries
        library(dplyr)
        
        ## Get Data (including activity codes)
        testX_df <<- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
        col_names <<- colnames(testX_df)
        testy_df <<- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
        subtest_df <<- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
        onetestdata <<- cbind(subtest_df,testy_df,testX_df)
        test_dim <<- dim(onetestdata)
        test_row <<- test_dim[1]
        test_col <<- test_dim[2]
        
        trainX_df <<- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
        trainy_df <<- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
        subtrain_df <<- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
        onetraindata <<- cbind(subtrain_df,trainy_df,trainX_df)
        train_dim <<- dim(onetraindata)
        train_row <<- train_dim[1]
        train_col <<- train_dim[2]
        
        ## Setup unique descriptive variable names to permit merge
        col_names <<- c("subject","activity",col_names)
        
        ## Write unique descriptive variable names to data frame
        colnames(onetestdata) <<- col_names
        colnames(onetraindata) <<- col_names
        
        #####################################################################################################
        ## Part 1. Merge data into a single dataset
        #####################################################################################################
        mergeddata <<- data.frame()
        mergeddata <<- merge(onetestdata,onetraindata, all = TRUE )
        merged_dim <<- dim(mergeddata)
        merged_row <<- merged_dim[1]
        merged_col <<- merged_dim[2]
        
        #####################################################################################################
        ## Part 3. Use descriptive activity names to name the activities in the data set
        #####################################################################################################
        for (i in 1:merged_row) {
                if (mergeddata[i,2] == 1) {
                        mergeddata[i,2] <<- "Walking"
                }
                if (mergeddata[i,2] == 2) {
                        mergeddata[i,2] <<- "Walking_Upstairs"
                }
                if (mergeddata[i,2] == 3) {
                        mergeddata[i,2] <<- "Walking_Downstairs"
                }
                if (mergeddata[i,2] == 4) {
                        mergeddata[i,2] <<- "Sitting"
                }
                if (mergeddata[i,2] == 5) {
                        mergeddata[i,2] <<- "Standing"
                }
                if (mergeddata[i,2] == 6) {
                        mergeddata[i,2] <<- "Laying"
                }
        }
        
        #####################################################################################################
        ## Part 2. Extract only the measurements on the mean and standard deviation for each measurement. 
        #####################################################################################################
        extract_df <<- data.frame()
        extract_df <<- mergeddata[1:merged_row,1:8]        
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,43:48]) 
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,83:88])
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,123:128])
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,163:168])
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,203:204])
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,216:217])
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,229:230])
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,242:243])
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,255:256])
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,268:273])
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,347:352])
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,426:431])
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,505:506])
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,518:519])
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,531:532])
        extract_df <<- cbind(extract_df,mergeddata[1:merged_row,544:545])
        
        #####################################################################################################
        ## Part 4. Appropriately label the data set with descriptive variable names.
        #####################################################################################################
        ## NB. this could also be done with dply function 'rename'.
        ext_col_names <<- c("subject","activity",##ext_col_names,
                        "mean_tbodyAcc_X","mean_tbodyAcc_Y","mean_tbodyAcc_Z",
                        "std_tbodyAcc_X","std_tbodyAcc_Y","std_tbodyAcc_Z",
                        "mean_tGravityAcc_X","mean_tGravityAcc_Y","mean_tGravityAcc_Z",
                        "std_tGravityAcc_X","std_tGravityAcc_Y","std_tGravityAcc_Z",
                        "mean_tbodyAccJerk_X","mean_tbodyAccJerk_Y","mean_tbodyAccJerk_Z",
                        "std_tbodyAccJerk_X","std_tbodyAccJerk_Y","std_tbodyAccJerk_Z",
                        "mean_tbodyGyro_X","mean_tbodyGyro_Y","mean_tbodyGyro_Z",
                        "std_tbodyGyro_X","std_tbodyGyro_Y","std_tbodyGyro_Z",
                        "mean_tbodyGyroJerk_X","mean_tbodyGyroJerk_Y","mean_tbodyGyroJerk_Z",
                        "std_tbodyGyroJerk_X","std_tbodyGyroJerk_Y","std_tbodyGyroJerk_Z",
                        "mean_tbodyAccMag","std_tbodyAccMag",
                        "mean_tGravityAccMag","std_tGravityAccMag",
                        "mean_tbodyAccJerkMag","std_tbodyAccJerkMag",
                        "mean_tbodyGyroMag","std_tbodyGyroMag",
                        "mean_tbodyGyroJerkMag","std_tbodyGyroJerkMag",
                        "mean_fbodyAcc_X","mean_fbodyAcc_Y","mean_fbodyAcc_Z",
                        "std_fbodyAcc_X","std_fbodyAcc_Y","std_fbodyAcc_Z",
                        "mean_fbodyAccJerk_X","mean_fbodyAccJerk_Y","mean_fbodyAccJerk_Z",
                        "std_fbodyAccJerk_X","std_fbodyAccJerk_Y","std_fbodyAccJerk_Z",
                        "mean_fbodyGyro_X","mean_fbodyGyro_Y","mean_fbodyGyro_Z",
                        "std_fbodyGyro_X","std_fbodyGyro_Y","std_fbodyGyro_Z",
                        "mean_fbodyAccMag","std_fbodyAccMag",
                        "mean_fbodyAccJerkMag","std_fbodyAccJerkMag",
                        "mean_fbodyGyroMag","std_fbodyGyroMag",
                        "mean_fbodyGyroJerkMag","std_fbodyGyroJerkMag"
        )        
        ## Write these descriptive variable names to the extraxt data frame
        colnames(extract_df) <<- ext_col_names
        
         
        #####################################################################################################
        ## Part 5. From the data set in step 4, create a second, independent tidy data set with the average 
        ##         of each variable for each activity and each subject.
        #####################################################################################################
        ext_table <<- tbl_df(extract_df)
        by_subject <<- arrange(ext_table,subject,activity) 
        grouped_tbl <<- group_by(by_subject,subject,activity)
        Summarised_Averages <<- summarise(grouped_tbl,
                                    mean_tbodyAcc_X = mean(mean_tbodyAcc_X),
                                    mean_tbodyAcc_Y = mean(mean_tbodyAcc_Y),
                                    mean_tbodyAcc_Z = mean(mean_tbodyAcc_Z),
                                    std_tbodyAcc_X = mean(std_tbodyAcc_X),
                                    std_tbodyAcc_Y = mean(std_tbodyAcc_Y),
                                    std_tbodyAcc_Z = mean(std_tbodyAcc_Z),
                                    mean_tGravityAcc_X = mean(mean_tGravityAcc_X),
                                    mean_tGravityAcc_Y = mean(mean_tGravityAcc_Y),
                                    mean_tGravityAcc_Z = mean(mean_tGravityAcc_Z),
                                    std_tGravityAcc_X = mean(std_tGravityAcc_X),
                                    std_tGravityAcc_Y = mean(std_tGravityAcc_Y),
                                    std_tGravityAcc_Z = mean(std_tGravityAcc_Z),
                                    mean_tbodyAccJerk_X = mean(mean_tbodyAccJerk_X),
                                    mean_tbodyAccJerk_Y = mean(mean_tbodyAccJerk_Y),
                                    mean_tbodyAccJerk_Z = mean(mean_tbodyAccJerk_Z),
                                    std_tbodyAccJerk_X = mean(std_tbodyAccJerk_X),
                                    std_tbodyAccJerk_Y = mean(std_tbodyAccJerk_Y),
                                    std_tbodyAccJerk_Z = mean(std_tbodyAccJerk_Z),
                                    mean_tbodyGyro_X = mean(mean_tbodyGyro_X),
                                    mean_tbodyGyro_Y = mean(mean_tbodyGyro_Y),
                                    mean_tbodyGyro_Z = mean(mean_tbodyGyro_Z),
                                    std_tbodyGyro_X = mean(std_tbodyGyro_X),
                                    std_tbodyGyro_Y = mean(std_tbodyGyro_Y),
                                    std_tbodyGyro_Z = mean(std_tbodyGyro_Z),
                                    mean_tbodyGyroJerk_X = mean(mean_tbodyGyroJerk_X),
                                    mean_tbodyGyroJerk_Y = mean(mean_tbodyGyroJerk_Y),
                                    mean_tbodyGyroJerk_Z = mean(mean_tbodyGyroJerk_Z),
                                    std_tbodyGyroJerk_X = mean(std_tbodyGyroJerk_X),
                                    std_tbodyGyroJerk_Y = mean(std_tbodyGyroJerk_Y),
                                    std_tbodyGyroJerk_Z = mean(std_tbodyGyroJerk_Z),
                                    mean_tbodyAccMag = mean(mean_tbodyAccMag),
                                    std_tbodyAccMag = mean(std_tbodyAccMag),
                                    mean_tGravityAccMag = mean(mean_tGravityAccMag),
                                    std_tGravityAccMag = mean(std_tGravityAccMag),
                                    mean_tbodyAccJerkMag = mean(mean_tbodyAccJerkMag),
                                    std_tbodyAccJerkMag = mean(std_tbodyAccJerkMag),
                                    mean_tbodyGyroMag = mean(mean_tbodyGyroMag),
                                    std_tbodyGyroMag = mean(std_tbodyGyroMag),
                                    mean_tbodyGyroJerkMag = mean(mean_tbodyGyroJerkMag),
                                    std_tbodyGyroJerkMag = mean(std_tbodyGyroJerkMag),
                                    mean_fbodyAcc_X = mean(mean_fbodyAcc_X),
                                    mean_fbodyAcc_Y = mean(mean_fbodyAcc_Y),
                                    mean_fbodyAcc_Z = mean(mean_fbodyAcc_Z),
                                    std_fbodyAcc_X = mean(std_fbodyAcc_X),
                                    std_fbodyAcc_Y = mean(std_fbodyAcc_Y),
                                    std_fbodyAcc_Z = mean(std_fbodyAcc_Z),
                                    mean_fbodyAccJerk_X = mean(mean_fbodyAccJerk_X),
                                    mean_fbodyAccJerk_Y = mean(mean_fbodyAccJerk_Y),
                                    mean_fbodyAccJerk_Z = mean(mean_fbodyAccJerk_Z),
                                    std_fbodyAccJerk_X = mean(std_fbodyAccJerk_X),
                                    std_fbodyAccJerk_Y = mean(std_fbodyAccJerk_Y),
                                    std_fbodyAccJerk_Z = mean(std_fbodyAccJerk_Z),
                                    mean_fbodyGyro_X = mean(mean_fbodyGyro_X),
                                    mean_fbodyGyro_Y = mean(mean_fbodyGyro_Y),
                                    mean_fbodyGyro_Z = mean(mean_fbodyGyro_Z),
                                    std_fbodyGyro_X = mean(std_fbodyGyro_X),
                                    std_fbodyGyro_Y = mean(std_fbodyGyro_Y),
                                    std_fbodyGyro_Z = mean(std_fbodyGyro_Z),
                                    mean_fbodyAccMag = mean(mean_fbodyAccMag),
                                    std_fbodyAccMag = mean(std_fbodyAccMag),
                                    mean_fbodyAccJerkMag = mean(mean_fbodyAccJerkMag),
                                    std_fbodyAccJerkMag = mean(std_fbodyAccJerkMag),
                                    mean_fbodyGyroMag = mean(mean_fbodyGyroMag),
                                    std_fbodyGyroMag = mean(std_fbodyGyroMag),
                                    mean_fbodyGyroJerkMag = mean(mean_fbodyGyroJerkMag),
                                    std_fbodyGyroJerkMag = mean(std_fbodyGyroJerkMag)
                                    )
  

## the following command is used to write out the result to the working directory
## it is not really a deliverable of the function run_analysis.R as described but is included here for completeness
write.table(Summarised_Averages, file = "summarised_averages.txt", row.names=FALSE)
}
