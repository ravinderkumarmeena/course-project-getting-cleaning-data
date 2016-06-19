# 1. Merge the training and the test sets to create one data set.
 #setting working directory .
 setwd("C:\Users\ravinder\Desktop\coursera\UCI HAR Dataset")
xtrain<-read.table("train/x_train.txt")
xtest <- read.table("test/X_test.txt")
ytest <- read.table("test/y_test.txt")
ytrain <- read.table("train/y_train.txt")
subjecttest <- read.table("test/subject_test.txt")
subjecttrain <- read.table("train/subject_train.txt")

# creating xdata set 
xdata<-rbind(xtrain,xtest)

#creating y  data set 
ydata<-rbind(ytrain,ytest)

#create subject data
subjectdata<-rbind(subjecttrain,subjecttest)


#2.Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("features.txt")
meanandstd<-grep("-mean|std)\\(\\)".features[,2]) # for columns with mean () or std() 

#subsetting the columns
xdata <- xdata[, mean_and_std_features]

# correct the column names
names(xdata) <- features[meanandstd, 2]

#3. Use descriptive activity names to name the activities in the data set
activities <- read.table("activity_labels.txt")

#used to  update values with  the right activity names
ydata[, 1] <- activities[ydata[, 1], 2]

# correct column name
names(ydata) <- "activity"



#5. Appropriately label the data set with descriptive variable names


# correcting  column name
names(subjectdata) <- "subject"

# bind all the data in a single data set
big <- cbind(xdata, ydata, subjectdata)

#5. Create a second, independent tidy data set with the average of each variable
#for averages 
averagesdata <- ddply(alldata, .(subject, activity), function(x) colMeans(x[, 1:66]))

writing<-write.table(averagesdata, "averagesdata.txt", row.name=FALSE)
writing



