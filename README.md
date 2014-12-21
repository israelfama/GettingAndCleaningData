This repo contains the R script for my course project in the Getting and Cleaning Data course.

These script doesn't download the files. So, before running it, the files must be downloaded and you have to update the file 
directory in the script lines, so R can "know" where your files are.

At first, the training data (X_train, Y_train and subject_train) are merged.
The same is done for the test data (X_test,Y_test and subject_test).
Then, both test and training data sets are merged.

The activity labels and features are also loaded.
I have included in my data sets, only the features which represent mean or standard deviation of measurements.
Please refer to the CodeBook, in this repo, for more information on that.





