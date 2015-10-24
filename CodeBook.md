#  codebook  #
##   This codebook describes the general procedures performed to prepare the tidy dataset
##   for the Samsung acceleration data, along with the description of what each variable
##   is. Documentation is also provided in the run_analysis.R script itself.

# DATA #
## the final dataset is CombinedData. This has been tidied up through a few procedures:
## 1.  Merging all datasets
##     The datasets to be joined are the Test and Training datasets, where each of the Test and
##     Training datasets have been split into 3 main data: the subject ID (subject_<type>.txt),
##     the corresponding measures (Acceleration etc), Activity ID (ID to describe the activity).
##     Note that the data should be read in its original sequence, and combined through a 
##     column bind (cbind) - this is how the data is structured.

## 2.  Tidying the data
##     This step involves relabelling CombinedData with descriptive and useful variables.
##     The description of each variable can be found in the root directory of the unzipped file, 
##     this is consequently used to label the relevant fields in the merged dataset. Note that
####     features.txt was initially read in, and used as the column names for when the measures 
##     dataset was read in i.e. using read.tables(<table>, col.names = <featurenames read in as vector>)
##     Note that some of the variable names required some cleansing (e.g. BodyBody), as long
##     variable names make it slightly more cumbersome to reference in the future (when analysing the data). 
##     Also for simplicity - non-alpha characters were removed (e.g. dots, parantheses).

## 3.  Retaining the relevant variables
##     the Mean and Standard Deviation measures are key to the tidy dataset (which will eventually
##     be used for analysis). Hence, we will only need to keep these measures, along with the subject
##     ID and activities performed. This was identified through using a combination of the select and 
##     contains function (from the reshape library), identifying variables which contain the words
##     mean or std. Note that the angle measure were not retained, despite it containing the words
##     "Mean" - the angle variables act to calculate the angular differences bewteen 2 vectors, of which
##     the Mean of a certain measure is used (hence this is not a mean measure).

## 4.  Summarising Data
##     A separate independent dataset (attached Summary.txt) providing the Mean and Standard 
##     Deviation average summaries of each measure, for each Subject's activity.

#  Variables  #
##   This section of the codebook describes what each variable is, contained in CombinedData.
##   Note that for simplicity - this section will not detail each individual variable available in 
##   the dataset, but will cover the general (kept) measures 
##   e.g. <MeasureType><XYZ> instead of describing it 3 times (for each direction)

#   Identifiers
##   SubjectID: this is the identifier of the 30 subjects (no names disclosed)
##   ActivityDesc: description of the activity being performed (e.g. Walking, ). Have retained the original
##                 labelling convention from the provided activity_description text file. This is
##                 the desired prediction, given a set of measures captured by the phone

#   Measures
##   The following documentation have been simplified:
##   <prefix>:     describes if the measure is time or frequency domain signal based (i.e. "t" or "f").
##                 Note that the frequency domain signals have been derived using
##                 a Fast Fourier Transform (FFT) on the signals.
##   <direction>:  this is the direction of the captured measure, captured in X, Y, Z e.g. X is the X direction. 
##                 Note that any measures that do not contain the direction is a magnitude i.e. the resulting
##                 raw magnitude of the directions combined.
##   Mag:          for variables that do not contain <direction>, this is the magnitude of the tri-axial (XYZ) direction as calculated using the Euclidean norm.

##   Both datasets measures include (noting that the Summary data is the average of these measures, for a given subjectid and activity):

## <prefix>BodyAccJerkMagmean:	Mean magnitude of the body acceleration jerk signals (derived from raw accelerometer data)
## <prefix>BodyAccJerkMagmeanFreq:	weighted average of the frequency components, from the magnitude of the body acceleration jerk signals (derived from raw accelerometer data)
## <prefix>BodyAccJerkMagstd:	standard deviation of the magnitude of the body acceleration jerk signals (derived from raw accelerometer data)
## <prefix>BodyAccJerkmean<direction>:	mean of the body acceleration jerk signals (derived from raw accelerometer data), for a given direction
## <prefix>BodyAccJerkmeanFreq<direction>:	weighted average of the frequency components, of the body acceleration jerk signals (derived from raw accelerometer data) for given direction
## <prefix>BodyAccJerkstd<direction>:	standard deviation of the magnitude of the body acceleration jerk signals (derived from raw accelerometer data), for a given direction
## <prefix>BodyAccMagmean:	Mean magnitude of the body acceleration signals (derived from raw accelerometer data)
## <prefix>BodyAccMagmeanFreq:	weighted average of the frequency components, from the magnitude of the body acceleration signals (derived from raw accelerometer data)
## <prefix>BodyAccMagstd:	standard deviation of the magnitude of the body acceleration signals (derived from raw accelerometer data)
## <prefix>BodyAccmean<direction>:	mean of the body acceleration signals (derived from raw accelerometer data), for a given direction
## <prefix>BodyAccmeanFreq<direction>:	weighted average of the frequency components, of the body acceleration signals (derived from raw accelerometer data) for given direction
## <prefix>BodyAccstd<direction>:	standard deviation of the magnitude of the body acceleration signals (derived from raw accelerometer data), for a given direction
## <prefix>BodyGyroJerkMagmean:	Mean magnitude of the body gyroscope jerk signals (derived from raw gyroscope data)
## <prefix>BodyGyroJerkMagmeanFreq:	weighted average of the frequency components, from the magnitude of the body gyroscope jerk signals (derived from raw gyroscope data)
## <prefix>BodyGyroJerkMagstd:	standard deviation of the magnitude of the body gyroscope jerk signals (derived from raw gyroscope data)
## <prefix>BodyGyroJerkmean<direction>:	Mean of the body gyroscope jerk signals (derived from raw gyroscope data), for a given direction
## <prefix>BodyGyroJerkstd<direction>:	standard deviation of the body gyroscope jerk signals (derived from raw gyroscope data), for a given direction
## <prefix>BodyGyroMagmean:	mean of the body gyroscope magnitude
## <prefix>BodyGyroMagmeanFreq:	weighted average of the frequency components, from the body gyroscope magnitude
## <prefix>BodyGyroMagstd:	standar deviation of the body gyroscope signal magnitude
## <prefix>BodyGyromean<direction>:	average of raw body gyroscope signals for a given direction
## <prefix>BodyGyromeanFreq<direction>:	weighted average of the frequency components, from the raw body gyroscope signals for a given direction
## <prefix>BodyGyrostd<direction>:	standard deviation of the raw body gyroscope reading
## <prefix>GravityAccMagmean:	gravity acceleration signal
## <prefix>GravityAccMagstd:	standard deviation of the gravity accelerometer magnitude reading
## <prefix>GravityAccmean<direction>:	mean of raw accelerometer reading, for given direction
## <prefix>GravityAccstd<direction>:	standard deviation of raw accelerometer reading, for given direction



