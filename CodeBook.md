This is the Code book

following Steps do The script run_analysis.R:
- downloading the file
- unzip the file
- import and read the files
- merging data test x, y and subject
- mean and std are exported to features.txt
- the activity_labels.txt file, corresponding activites WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) are setup in the dataset. 
- dataset is labeled in a descriptive way:
   tBodyAcc-mean()-X will be timeBodyAccMeanX
   tBodyAcc-std()-Y will be timeBodyAccStdY
   fBodyAcc-mean()-Z will be freqBodyAccMeanZ
   fBodyBodyGyroMag-mean() will be freqBodyGyroMagMean
   fBodyBodyGyroJerkMag-meanFreq() will be freqBodyGyroJerkMagMeanFreq
- tidy_dataset (mean value for each element and activity is saved. 
- output file is tidy_data.txt

the variables are:
    - data_test_X, 
    - data_test_Y, 
    - data_train_X, 
    - data_train_Y, 
    - data_test_subject
    - data_train_subject -->>  data from the download
    - data_all_X* 
    - data_all_Y*
    - data_all_subject* --> merge in one dataset
    - data_features --> the file features.txt. 
    - mean_std --> all the columns  with having literal 'mean' or 'std'
   -  data_activities contains the file activity_labels.txt. Correct activity name is updated from here.
    - all_data --> merge data_all_X*, data_all_Y* and data_all_subject* into one dataset. 
    - avg contains the corresponding averages which is finally stored in tidy_data.txt file.
