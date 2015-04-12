# get.clean.data.project
Project for Getting and Cleaning Data Coursera project

* Training dataset
  *	```x_train``` : measurement data in training set (7352 x 561 matrix)
  * ```subject_train``` : variable contains the subject ids corresponding to each row of ```x_train``` data. (7352 x 1 matrix)
  * ```y_train```: contains activity ids corresponding to each row of ```x_train```(7352 x 1 matrix)
* Test set
  * ```x_test``` : measurement data in test set (2947 x 561 matrix)
  * ```subject_test``` : variable contains the subject ids corresponding to each row of ```x_test``` data. (2947 x 1 matrix)
  * ```y_test```: contains activity ids corresponding to each row of ```x_test```(2947 x 1 matrix)
* ```features``` : Contains 561 rows. Each row is the label for each column of ```x_train``` and ```x_test``` 
* combine the three training set variables mentioned in step 1, and ```features``` to get ```complete_train``` object which is a 7532 x 563 matrix. The first  column of this matrix is the subject_id and the second column is activity_id.
* combine the above three test set variables mentioned in step 2, and ```features``` to get ```complete_test``` object which is a 2947 x 563 matrix. The first  column of this matrix is the subject_id and the second column is activity_id.
* Perform an ```“Rbind”``` on ```complete_train``` and ```complete_test``` to get ```complete_df``` which is  a 10299 x 563 matrix. The first  column of this matrix is the subject_id and the second column is activity_id
* Use ```“Grep”``` on the column names of ```complete_df``` to get 33 columns that contain ```“mean()”``` and 33 columns that contain ```“sd()”```.
 Extract only those columns to get a 10299 x 68 matrix called ```short_df```
* Label the activity names as follows

Activity id   | New Activity ID
------------- | -------------
1             | 1_WALKING
2             | 2_WALKING_UPSTAIRS
3             | 3_WALKING_DOWNSTAIRS
4             | 4_SITTING
5             | 5_STANDING
6             | 6_LAYING
*	```Arrange``` the data frame, first based on ```subject_id``` and then on ```activity_id``` to get a dataframe called ```“group1”```

* Method 1 (using melt() and dcast())
  * melt the grouped data, so that it will keep subject_id and activity_id and melt everything else into a narrow column called "variable"
  * Keeping the subject_id and activity ID on the left side, apply mean() on the "variable" column using dcast

* OR use Method 2 (using loops)
  * Use aggregate and sapply (using function ) to calculalate mean for every subject id and every activity id

* Final table: 180x68 data frame 
  * Write final data frame to text file
