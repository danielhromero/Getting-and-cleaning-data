#Getting and Cleaning Data
#Daniel Romero

#First lets read the data, all relevants files were placed in the same folder

x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")

subject_train <- read.table("subject_train.txt")

x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# Combining data
y_data <- rbind(y_train, y_test)
x_data <- rbind(x_train, x_test)
subject_data <- rbind(subject_train, subject_test)

# Now lets find the mean and standard deviation

features <- read.table("features.txt")

statistics_features <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, statistics_features]
names(x_data) <- features[statistics_features, 2]

# Now lets add descriptive names

activities <- read.table("activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"
names(subject_data) <- "subject"
all_data <- cbind(x_data, y_data, subject_data)

# Finally lets create a second tidy dataset

mean_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(mean_data, "mean_data.txt", row.name=FALSE)