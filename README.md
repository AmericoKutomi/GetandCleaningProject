Project for Getting and Cleaning Data Course

In order to complete the tasks, it was done the following.

1. Reading the Test Dataset
   The files X_test.txt, Y_test.txt, and subject_test.txt were read using read.fwf because they are text files.
   It was produced one data.frame for each text file.
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
6. 

## Converting activities in lines into columns in a new data.frame
#  The final data.frame is tidy considering each Subject in one single line
#  It is possible because the set of activities is fixed in 6 items
#
## The operation is done using reshape to convert data in lines into columns
tidydata <- reshape(databySubjectActivity, idvar="Id", timevar="Activity", direction="wide")
#
#> str(tidydata)
#'data.frame':  30 obs. of  13 variables:
#  $ Id       : int  1 2 3 4 5 6 7 8 9 10 ...
#$ mean.1   : num  0.277 0.276 0.276 0.279 0.278 ...
#$ std_dev.1: num  0.0464 0.0513 0.0475 0.0292 0.0508 ...
#$ mean.2   : num  0.255 0.247 0.261 0.271 0.268 ...
#$ std_dev.2: num  0.05 0.0595 0.077 0.0626 0.0953 ...
#$ mean.3   : num  0.289 0.278 0.292 0.28 0.294 ...
#$ std_dev.3: num  0.0842 0.0803 0.0808 0.0789 0.1027 ...
#$ mean.4   : num  0.261 0.277 0.257 0.272 0.274 ...
#$ std_dev.4: num  0.0633 0.0231 0.0866 0.0313 0.0266 ...
#$ mean.5   : num  0.279 0.278 0.28 0.28 0.283 ...
#$ std_dev.5: num  0.00799 0.01406 0.02518 0.02843 0.03481 ...
#$ mean.6   : num  0.222 0.281 0.276 0.264 0.278 ...
#$ std_dev.6: num  0.1689 0.0242 0.0141 0.0884 0.0322 ...
#- attr(*, "reshapeWide")=List of 5
#..$ v.names: NULL
#..$ timevar: chr "Activity"
#..$ idvar  : chr "Id"
#..$ times  : int  1 2 3 4 5 6
#..$ varying: chr [1:2, 1:6] "mean.1" "std_dev.1" "mean.2" "std_dev.2" ...
#
## Last operation is to put meaningful names to the variables
names(tidydata) <- c("Id","mean_WALKING","stddev_WALKING","mean_WALKING_UPSTAIRS","stddev_WALKING_UPSTAIRS","mean_WALKING_DOWNSTAIRS","stddev_WALKING_DOWNSTAIRS","mean_SITTING","stddev_SITTING","mean_STANDING","stddev_STANDING","mean_LAYING","stddev_LAYING")
#> str(tidydata)
#'data.frame':  30 obs. of  13 variables:
#  $ Id                       : int  1 2 3 4 5 6 7 8 9 10 ...
#$ mean_WALKING             : num  0.277 0.276 0.276 0.279 0.278 ...
#$ stddev_WALKING           : num  0.0464 0.0513 0.0475 0.0292 0.0508 ...
#$ mean_WALKING_UPSTAIRS    : num  0.255 0.247 0.261 0.271 0.268 ...
#$ stddev_WALKING_UPSTAIRS  : num  0.05 0.0595 0.077 0.0626 0.0953 ...
#$ mean_WALKING_DOWNSTAIRS  : num  0.289 0.278 0.292 0.28 0.294 ...
#
## tidydata contains 30 lines, one for each subject, with the mean and standard deviation
##   for each of 6 activities measured
##


