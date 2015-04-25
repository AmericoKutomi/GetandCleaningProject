## setting the data folder as Working Directory
#setwd("C:/Users/Americo/Estudos/Coursera/Getting and Cleaning Data/Project/Dados")
#
### Reading the Test Dataset
#
fileConn <- file("X_test.txt")
testX<-read.fwf(fileConn, widths=c(16), sep = "\n")
# > str(testX)
#'data.frame':  2947 obs. of  1 variable:
#  $ V1: num  0.257 0.286 0.275 0.27 0.275 ...
#
fileConn <- file("Y_test.txt")
testY<-read.fwf(fileConn, widths=c(1), sep = "\n")
#> str(testY)
#'data.frame':  2947 obs. of  1 variable:
#  $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
#
fileConn <- file("subject_test.txt")
testSubject<-read.fwf(fileConn, widths=c(2), sep = "\n")
#> str(testSubject)
#'data.frame':  2947 obs. of  1 variable:
#  $ V1: int  2 2 2 2 2 2 2 2 2 2 ...
#
### Merging the Test Dataset in one data frame using cbind
#
test <- cbind(testSubject,testY,testX)
#> str(test)
#'data.frame':  2947 obs. of  3 variables:
#  $ V1: int  2 2 2 2 2 2 2 2 2 2 ...
#$ V1: int  5 5 5 5 5 5 5 5 5 5 ...
#$ V1: num  0.257 0.286 0.275 0.27 0.275 ...
#
#
### Reading the Train Dataset
#
fileConn <- file("X_train.txt")
trainX<-read.fwf(fileConn, widths=c(16), sep = "\n")
#> str(trainX)
#'data.frame':  7352 obs. of  1 variable:
#  $ V1: num  0.289 0.278 0.28 0.279 0.277 ...
#
fileConn <- file("Y_train.txt")
trainY<-read.fwf(fileConn, widths=c(1), sep = "\n")
#> str(trainY)
#'data.frame':  7352 obs. of  1 variable:
#  $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
#
fileConn <- file("subject_train.txt")
trainSubject<-read.fwf(fileConn, widths=c(2), sep = "\n")
#> str(trainSubject)
#'data.frame':  7352 obs. of  1 variable:
#  $ V1: int  1 1 1 1 1 1 1 1 1 1 ...
#
### Merging the Train Dataset in one data frame using cbind
#
train <- cbind(trainSubject,trainY,trainX)
#> str(train)
#'data.frame':  7352 obs. of  3 variables:
#$ V1: int  1 1 1 1 1 1 1 1 1 1 ...
#$ V1: int  5 5 5 5 5 5 5 5 5 5 ...
#$ V1: num  0.289 0.278 0.28 0.279 0.277 ...
#
### Merging the Test and Train using rbind
#
alldata <- rbind(train,test)
#> str(alldata)
#'data.frame':  10299 obs. of  3 variables:
#  $ V1: int  1 1 1 1 1 1 1 1 1 1 ...
#$ V1: int  5 5 5 5 5 5 5 5 5 5 ...
#$ V1: num  0.289 0.278 0.28 0.279 0.277 ...
#
# Changing variables named V1 to names more significant
names(alldata) <- c('Id','Activity','Measurement')
#
library(plyr)
## Sorting the data to put all measurements in order of subjects and activities
alldatasorted <- arrange(alldata, Id, Activity)
#
## Calculating mean and standard deviation by subject and activity, using ddply
databySubjectActivity <- ddply(alldata, .(Id, Activity), summarize, mean=mean(Measurement), std_dev=sd(Measurement))
#> str(databySubjectActivity)
#'data.frame':  180 obs. of  4 variables:
#  $ Id      : int  1 1 1 1 1 1 2 2 2 2 ...
#$ Activity: int  1 2 3 4 5 6 1 2 3 4 ...
#$ mean    : num  0.277 0.255 0.289 0.261 0.279 ...
#$ std_dev : num  0.04639 0.04996 0.08416 0.06333 0.00799 ...
#
# There are six lines for each subject in the data.frame, corresponding to activities
#
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

