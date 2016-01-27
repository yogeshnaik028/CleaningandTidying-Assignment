==================================================================
Getting and Cleaning Data Course Project - Week 4 Exercise

Analysis and Tidying Data -  Human Activity Recognition Using Smartphones Dataset[1]

==================================================================
The dataset includes the following files:
==================================================================

- 'README.md': this file

- 'summary.txt': Contain summary information for subjects and their activities.

- 'code book.txt': Code book
------------------------------------------------------------------

How the script works


Steps:

1. Reads X train and test files and merges them 
2. Reads the features file and add the features (attributes/columns) as header to the data set from step 1
3. Removes all columns from data set from stpe 2 which do not have features with "Mean" or "Std" in them
4. Tidies up the header for the data frame in step 3 with meaningful names
5. Reads activity (i.e.Y) train and test files and merge them
6. Reads the activity labels
7. Changes the activity levels in the data frame from step 5 to the labels from step 6
8. Reads train and test subject files and merge them to create a subject data frame
9. Selects the column name for subjects data files from step 8
10. Combines the subject data frame from step 9, activity data frame from step 7, and data frame from step 4 to create a final data frame
11. Converts the final data frame from step 10 to a data frame table 
12. Groups the data frame table from step 11 by subject and activity
13. Summarizes the results using the data frame table from step 12
14. Outputs the results from step 12 to an output file
--------------------------------------------------------------------

References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

