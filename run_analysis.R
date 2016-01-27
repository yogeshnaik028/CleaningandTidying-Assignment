## Getting and Cleaning Data Course Project - Week 4 Exercise
##
## Analysis and Tidying Data -  Human Activity Recognition Using Smartphones Dataset[1]
##
## Reference:
## [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
##
## Steps:
##1. Reads X train and test files and merges them 
##2. Reads the features file and add the features (attributes/columns) as header to the data set from step 1
##3. Removes all columns from data set from stpe 2 which do not have features with "Mean" or "Std" in them
##4. Tidies up the header for the data frame in step 3 with meaningful names
##5. Reads activity (i.e.Y) train and test files and merge them
##6. Reads the activity labels
##7. Changes the activity levels in the data frame from step 5 to the labels from step 6
##8. Reads train and test subject files and merge them to create a subject data frame
##9. Selects the column name for subjects data files from step 8
##10. Combines the subject data frame from step 9, activity data frame from step 7, and data frame from step 4 to create a final data frame
##11. Converts the final data frame from step 10 to a data frame table 
##12. Groups the data frame table from step 11 by subject and Actvity
##13. Summarizes the results using the data frame table from step 12
##14. Outputs the results from step 12 to an output file
##
runAnalysis <- function() 
{

#load dplyr library
library(dplyr)

#read X text files into data frames
dfXTrain <- read.table("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", stringsAsFactors=FALSE)
dfXTest <- read.table("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", stringsAsFactors=FALSE)

#merge the two data sets into one
dfX<- rbind(dfXTrain, dfXTest)

#read the features text file
dffeatures <- read.table("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")

#add header to the merged data frame using values from dffeatures
names(dfX) <- dffeatures[,2]

#extract only measurements for mean and std
dfXSubset <- dfX[,grep("[Mm][Ee][Aa][Nn]|[Ss][Tt][dd]", names(dfX))]

#tidy up attribute names
names(dfXSubset) <- gsub("\\()", "", names(dfXSubset))
names(dfXSubset) <- gsub("^t", "", names(dfXSubset))
names(dfXSubset) <- gsub("^f", "", names(dfXSubset))
names(dfXSubset) <- gsub("^angle\\(", "Angle-", names(dfXSubset))
names(dfXSubset) <- gsub("^t", "", names(dfXSubset))
names(dfXSubset) <- gsub("\\)", "", names(dfXSubset))
names(dfXSubset) <- gsub("\\,", "-", names(dfXSubset))
names(dfXSubset) <- gsub("BodyBody", "Body", names(dfXSubset))
names(dfXSubset) <- gsub("tBody", "Body", names(dfXSubset))
names(dfXSubset) <- gsub("-", "", names(dfXSubset))
names(dfXSubset) <- gsub("mean", "Mean", names(dfXSubset))
names(dfXSubset) <- gsub("std", "Std", names(dfXSubset))

# read y train file
dfYTrain <- read.table("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", stringsAsFactors=FALSE)
# read y test file
dfYTest <- read.table("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", stringsAsFactors=FALSE)

#merge the two Y data sets into one
dfY<- rbind(dfYTrain, dfYTest)

# read the activity labels from activity_labels.txt 
dfactivity = read.table("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", sep = "")
activityLabels = as.character(dfactivity$V2)

#change levels to activity names
names(dfY) <- "Activity"
dfY$Activity <- as.factor(dfY$Activity)
levels(dfY$Activity)<- activityLabels

# read train subject file
dfTrainSubjects <- read.table("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", sep = "")

# read test subject file
dfTestSubjects <- read.table("./data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", sep = "")

#merge the two subject data sets into one
dfSubjects<- rbind(dfTrainSubjects, dfTestSubjects)

#change the column name for subjects
names(dfSubjects) <- "Subject"
dfSubjects$Subject <- as.factor(dfSubjects$Subject)

#create the final data frame
dffinal <- cbind(dfSubjects, dfY, dfXSubset)

#remove any duplicate columns
dffinal <- dffinal[ , !duplicated(colnames(dffinal))]

# create data frame table from data frame
dftable <- tbl_df(dffinal) 		

#group by subject and actvity
bySubjectActivity<-group_by(dftable,Subject, Activity)

#out the result to a new table
tbl_sum <- summarise_each(bySubjectActivity, funs(mean))

#write the data set as a txt file 
write.table(tbl_sum, file= "summary.txt", row.name=FALSE)

}

