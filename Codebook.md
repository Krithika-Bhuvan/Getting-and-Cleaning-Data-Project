### Code book - description of variables (Getting and Cleaning Data Coursera project)

* Training dataset
  *	```x_train``` : measurement data in training set (7352 x 561 )
  * ```subject_train``` : variable contains the subject ids corresponding to each row of ```x_train``` data. (7352 x 1 )
  * ```y_train```: contains activity ids corresponding to each row of ```x_train```(7352 x 1 )
* Test set
  * ```x_test``` : measurement data in test set (2947 x 561 )
  * ```subject_test``` : variable contains the subject ids corresponding to each row of ```x_test``` data. (2947 x 1 )
  * ```y_test```: contains activity ids corresponding to each row of ```x_test```(2947 x 1 )
* ```features``` : Contains 561 rows. Each row is the label for each column of ```x_train``` and ```x_test``` 
* ```complete_train``` : combination of the three training set variables mentioned in step 1, and features. This is a 7532 x 563 data frame. The first column is the ```subject_id``` and the second column is ```activity_id```. 
*  ```complete_test``` : combination of the above three test set variables mentioned in step 2, and features. This is a 2947 x 563 data frame. The first column is the  ```subject_id``` and the second column is ```activity_id```. 
*  ```complete_df``` : Contains an ```“Rbind”``` on ```complete_train``` and ```complete_test```  a 10299 x 563 data frame
* ```short_df``` : data frame which has subject id, activity id, 33 columns that contain ```“mean()” ``` and 33 columns that contain ```“sd()"``` - 33 0299 x 68 data frame 

* Method 1
  *  ```group1``` : Data frame from Arranging ```short_df```, first based on ```subject_id``` and then on ```activity_id``` to get a d
  * ```melt1``` : output of application of ```melt()``` on ```group1```, so that it will keep ```subject_id``` and ```activity_id``` and melt everything else into a narrow column called "variable"
  * ```dcast1``` :  Obtained from application of ```dcast()``` on ```“variable”``` column, Keeping the ```subject_id``` and ```activity_id``` on the left side
  * Saving this output as ```tidy.data1.txt``` : 180x68 data frame 

* OR use Method 2 (using loops)
  * Creat object ```aggr``` obtained using ```aggregate()``` function on the thrid column of ```group1```.
  * ```aggr2```: output of sapply (using function) that calculalates mean for every subject id and every activity id for all other columns
  * ```final.aggr```: ```cbind``` of ```aggr```  and ```aggr2``
  * Final table: Saving this output as ```tidy.data2.txt``` : 180x68 data frame 
