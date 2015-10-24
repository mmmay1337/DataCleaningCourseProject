#  READ ME #
##   this READ ME file will describe the relevant files required for preparing the tidy dataset,
##   along with what is required to run the run_analysis.R file.

#  RUNNING THE SCRIPT #
##   The R script has been set up in an automated manner - it will automatically detect if the
##   current directory contains the relevant files to be read in (otherwise it will download it).
##   This is achieved by using the file.exists() function.
##   All that is required is to run the script to generate the outputs.

#  RELEVANT FILES #
##   the following files come from the zip file, in the UCI HAR Dataset folder. 

#   features identifiers #
##   activity_labels.txt: this is the corresponding description for each activity ID
##   features.txt: this is the descriptive names of the features captured in the X_<test/train> dataset

#  relevant features / activity #
##   <test/train>/Subect_<test/train>: this is the corresponding subject ID observation
##                                     for each row, in the <test/train> dataset
##   <test/train>/X_<test/train>:  this file contains the relevant features, from 
##                                 the <test/train> dataset
##   <test/train>/y_<test/train>:  this is the activity ID for the task being performed, 
##                                 from the <test/train> dataset

#  EXPECTED OUTPUTS #
## note that any intermediate datasteps are cleared throughout the code, so that the only 
## remaining R objects are the CombinedData and Summary data.

## for more information on the general procedures of preparing the dataset (and variables),
## please refer to the codebook.