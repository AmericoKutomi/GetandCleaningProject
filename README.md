Project for Getting and Cleaning Data Course

In order to complete the tasks, it was done the following.

1. Reading the Test Dataset
   The files X_test.txt, Y_test.txt, and subject_test.txt were read using read.fwf because they are text files.
   It was produced one data.frame for each text file.
   Inertial Signals files were ingnored according to discussion on Forum. The procedures would be almost the same with X_test.txt file.
2. Merging the Test Dataset into one data frame
   It was created a new data frame using cbind with Subjetcs, Y, and X data frames.
3. Reading the Train Dataset and Merging the Train Dataset into one data frame
   It was done with Train Dataset the same procedure as to the Test Dataset.
4. Merging the Test and Train data
   It was use rbind because the Test and Train data have the same structure, and the lines of one was appended to the other.
   The rbind function generated a new data frame called alldata.
   For convenience, the names of the columns were changed from "V1" to Id, Activity and Measurement, respectively.
   Using arrange function of plyr library, the data was sorted by Id and Activity.
   The resulting data frame was alldatasorted.
5. Summarizing data and calculating mean and standard deviation
   In alldatasorted, each line corresponds to a single measurement of an activity of a subject.
   The next step was to calculate mean and standard deviation by activity and subject.
   It was used ddply function do summarize and do the calculations.
   The resulting data frame, databySubjectActivity, has 180 lines, 6 lines of activities for each of 30 subjects.
   This file could be considered a tidy data frame if considering a line for each subject and activity.
   The choice was to go on and have a data frame with a single line per subject.
6. Reshaping data to have a single line per subject in the data frame: the Tidy Data Set
   The activities in lines were convert into columns in a new data.frame by using reshape function.
   It was generated the tidydata data frame with 30 lines, corresponding to each Subject.
   For each Subject, there are 12 columns for to the 6 activities represented by their mean and standard deviation.
7. Changing variable names:
   Last operation is to put meaningful names to the variables / columns. The variables are described below.
   
   CODEBOOK:
   Id: numeric identification of the observed Subject
   mean_WALKING: mean of the measurements for Walking activity
   stddev_WALKING: standard deviation of the measurements for Walking activity
   mean_WALKING_UPSTAIRS: mean of the measurements for Walking Upstairs activity
   stddev_WALKING_UPSTAIRS: standard deviation of the measurements for Walking Upstairs activity
   mean_WALKING_DOWNSTAIRS: mean of the measurements for Walking Downstairs activity
   stddev_WALKING_DOWNSTAIRS: standard deviation of the measurements for Walking Downstairs activity
   mean_SITTING: mean of the measurements for Sitting activity
   stddev_SITTING: standard deviation of the measurements for Sitting activity
   mean_STANDING: mean of the measurements for Standing activity
   stddev_STANDING: standard deviation of the measurements for Standing activity
   mean_LAYING: mean of the measurements for Laying activity
   stddev_LAYING: standard deviation of the measurements for Laying activity
