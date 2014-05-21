CodeBook
========================================================

This document describes the data, variables, and work performed to complete the course project for Getting and Cleaning Data.

The original data was broken apart into a test and training set. To create a comprehensive data set, it required merging three distinct data files for both the test set and training set.  The files for each set were as follows:

#### Test                     
- X_test.txt                    
- y_test.txt
- subject_test.txt

#### Train
- X_train.txt                    
- y_train.txt
- subject_train.txt

#### Other files
- features.txt
- activity_labels.txt

The first step that was taken was to bring all the data into R for both the test and training set.  This included the subject identifiers (subject_test.txt and subject_train.txt), the activity labels (activity_labels.txt), the columns names (features.txt), the actual data(X_test,X_train) and the activity indentifier for each row(y_test,y_train). This required the reading in of 3 files for the test set (X-test.txt,y_test.txt,subject_test.txt) and 3 files for the training set (X-train.txt,y_train.txt,subject_train.txt).  The data files in the sub folders 'Inertial Signals' was not used in this analysis.

Each of the files were read in separately using the read.table function and then combined, using cbind, to create a data frame for the test set, called test, and a data frame for the training set, called train.  Then the test and training set data was merged using rbind into one data frame called *allData*.

*colnames* was created by reading in the features.txt file and setting stringsAsFactors to false. The column names of the allData data frame were set to "subject", "activity", and then the second column of the colnames data frame.

At this point a subset of the data was extracted to contain only measurements for mean and standard deviation. I decided to only extract columns that measured the mean or standard deviation and NOT the mean frequency. Since there was no requirement specifying these measurements be included, I excluded them to keep the final data set smaller. *subNames* was used to store the subset of column names that we wanted to included the final data set.  *subData* was as a subset of *allData* with only the mean and std. deviation measurements of interest.

The *labels* data frame stored the mapping of the numrical activity labels to the qualitative activity labels that were read in from the activity_labels.txt file. The activity names were read in as factors, but we converted them to characters.

The *labels* data frame was merged with the *subData* data frame to create the data frame *mergeData*.  The numerical activity identifier was removed from *mergeData* leaving the subject id, the qualitative activity description, and 66 mean/standard deviation measurements.

The column names of *mergeData* were cleaned up to remove both dashes and parentheses and the pharses "mean" and "std" were replaced with "Mean" and "Std" to follow camel-case formatting.

To allow for easier calcuation of the means in the next step, *mergeData* was converted to a data table named *DT*.  Once *DT* was created we were able to created the *tidy* data table using the following code to calculate the mean for each column by subject and activity:

```{r}
tidy<-DT[,lapply(.SD,mean),by=list(activityName,subject)]
```

Finally, the *tidy* data table was written out to the current working directory as a text file using commas as the delimiter.It was not written as a csv because the Coursera file upload did not allow for the csv format.




