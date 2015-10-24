# read in necessary libraries
library(dplyr)
library(reshape)

############## Step 1: Merges the training and the test sets to create one data set ##############

## download zip if it doesnt exist ##
if(!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")|!file.exists("UCI HAR Dataset")){
  ZipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(ZipURL, destfile="./getdata-projectfiles-UCI HAR Dataset.zip")
  ZipFile <- unzip("getdata-projectfiles-UCI HAR Dataset.zip", exdir = getwd())
}


## create tables from the unzipped files ##
dir_name <- "./UCI HAR Dataset/"
features_data <- read.table(paste(dir_name, "features.txt", sep="")) # read in features name, these are variables for each test and training datasets
features <- features_data$V2 #these are the column names for each dataset
rm("features_data") # clear unnecessary data from the workspace for memory management

## read in training data ##
sub_train <- read.table(paste(dir_name, "train/subject_train.txt", sep=""), col.names = "SubjectID") #corresponding subject ID
X_train <- read.table(paste(dir_name, "train/X_train.txt", sep=""), col.names = features) # training features
Y_train <- read.table(paste(dir_name, "train/Y_train.txt", sep=""), col.names = "activityID") # these are the activity labels (as ID)
train  <- cbind(X_train, sub_train, Y_train) # combine the features and labels into 1 training dataset

## read in test data ##
sub_test <- read.table(paste(dir_name, "test/subject_test.txt", sep=""), col.names = "SubjectID") #corresponding subject ID
X_test <- read.table(paste(dir_name, "test/X_test.txt", sep=""), col.names = features) # testing features
Y_test <- read.table(paste(dir_name, "test/Y_test.txt", sep=""), col.names = "activityID") # these are the activity labels (as ID)
test  <- cbind(X_test, sub_test, Y_test) # combine the features and labels into 1 testing dataset


## combine into one dataset ##
CombinedData  <- rbind(train, test)

# clear unnecessary data from the workspace for memory management (retain the unzipped files just in case required)
rm("X_train", "Y_train", "X_test", "Y_test", "train", "test")

############## Step 2: Extract only the measurements on the mean and std for each measurement ##############

# find out which columns contain the names mean and std, then create a vector on the columns to retain
Col_Mean <- names(select(CombinedData, contains("mean", ignore.case = FALSE))) # dont want to get the angles
Col_Std <- names(select(CombinedData, contains("std", ignore.case = "FALSE"))) # dont want to get the angles
Col_Retain <- c("SubjectID", "activityID", Col_Mean, Col_Std)# create a vector of the columns to retain

CombinedData <- CombinedData[, Col_Retain] # retain only the relevant columns

############## Step 3: use descriptive activity names to name the activities in the data set ##############
# read in the descriptive activity names data
Desc_Activity <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activityID", "ActivityDesc"))
# merge the activity descriptions by activity ID, dont need the merge by vars, this automatically puts the merge key at the front of the data
CombinedData <- merge(CombinedData, Desc_Activity) # this will merge by activityID
CombinedData <- select(CombinedData, -(activityID)) # drop the activityID since data now contains desc
############## Step 4: appropriately label the dataset with descriptive variable names ##############
# get rid of the dots first - apply the rename on the final vector
names(CombinedData) <- gsub("[.]", "", names(CombinedData))
# get rid of the repeated words for Body
names(CombinedData) <- tolower(gsub("BodyBody", "Body", names(CombinedData)))

#remove unnecessary R objects
rm("Desc_Activity", "Col_Mean", "Col_Std")

# use the codebook, will also have to create a codebook


############## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# melt the data
Summary <- melt(CombinedData, id = c("subjectid", "activitydesc"))
Summary <- cast(Summary, subjectid + activitydesc ~ variable, mean) #obtain the average for each item
write.table(Summary, file = "./Summary.txt", row.names = FALSE)