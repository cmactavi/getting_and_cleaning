tidy_data <- function(path, outfile) {
        
        #Set working dir, downlowd data and unzip
        setwd(path)
        fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        filename <- paste(path,"/Dataset.zip", sep="")
        download.file(fileURL,dest = filename, method="curl")
        unzip(filename)

        #Reading raw data sets
        print("Reading test data...")
        subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
        X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
        y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

        print("Reading train data...")
        subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
        X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
        y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

        #Read in the activity labels key
        activity_lab <- read.table("UCI HAR Dataset/activity_labels.txt")

        #Read in the features names
        features <- read.table("UCI HAR Dataset/features.txt")
        
        #Get indices for mean and std fields
        mean_idx<-grep("mean\\(\\)", features$V2)
        std_idx<-grep("std\\(\\)", features$V2)
        tidy_idx <- sort(c(mean_idx, std_idx))

        #Create tidy subset of mean and std data
        tidy_X_test <- X_test[,tidy_idx]
        tidy_X_train <- X_train[,tidy_idx]
        tidy_X <- rbind(tidy_X_test, tidy_X_train)

        #Combine test and train subjects and activities fields
        y <- rbind(y_test, y_train)
        subject <- rbind(subject_test, subject_train)

        #Give columns decriptive names
        colnames(tidy_X) <- features$V2[tidy_idx]
        colnames(y) <- "activity"
        colnames(subject) <- "subject"

        #Use aggregate to find the mean of feature observations (having extracted only 
        # the measurements on the mean and standard deviation for each measurement) 
        # for each subject and each activity.
        df2 <- aggregate(df1, by=list(df1$activity, df1$subject), mean)
        
        #Convert activity numbers into activity names
        df2$activity <- lookup(df2$activity, activity_lab)

        #Remove columns not required 
        df2$Group.1 <- NULL
        df2$Group.2 <- NULL
        
        #Write out data to outfile
        write.table(df2, file = outfile, row.name=FALSE)
}
