### Read the files into local memory
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

### Combine the train and test sets by combining the rows
subject <- rbind(subject_test, subject_train)
X <- rbind(X_test, X_train)
y <- rbind(y_test, y_train)

### Read the feature names from the provided file
features <- read.table("UCI HAR Dataset/features.txt")
colnames(X) <- features$V2
### Determine which are related to 'mean' or 'std' and just use those columns in 'X'
hasMeanOrStd <- grepl("mean\\(\\)|std\\(\\)", features$V2)
X <- X[,hasMeanOrStd]
### Insert actual activity names instead of the integer codes provided in original file
Activities <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
y <- Activities[y$V1]

### Create a data frame combining the Activities, Subjects, and mean/std data
Means <- data.frame(Activity = y, Subject = factor(subject$V1), X)

write.csv(Means, "Means.csv")

### Reshape the data to take the means by Activity and Subject
library(reshape2)
MeansMelt <- melt(Means, id=c("Activity", "Subject"))
Summary <- dcast(MeansMelt, Activity + Subject ~ variable, mean)
write.csv(Summary, "Summary.csv")

