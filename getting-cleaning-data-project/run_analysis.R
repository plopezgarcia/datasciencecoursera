library(plyr)

features <- read.table("./data/features.txt", colClasses = c("character"))

x_train <- read.table("./data/train/X_train.txt")
y_train <- read.table("./data/train/y_train.txt")
subject_train <- read.table("./data/train/subject_train.txt")

x_test <- read.table("./data/test/X_test.txt")
y_test <- read.table("./data/test/y_test.txt")
subject_test <- read.table("./data/test/subject_test.txt")

# 1 - Merges the training and the test sets to create one data set.

sensor_train <- cbind(cbind(x_train, subject_train), y_train)
sensor_test <- cbind(cbind(x_test, subject_test), y_test)
sensor_all <- rbind(sensor_train, sensor_test)
names(sensor_all) <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]

# 2 - Extracts only the measurements on the mean and standard deviation for each measurement.

sensor_all_mean_std <- sensor_all[,grepl("mean|std|Subject|ActivityId", names(sensor_all))]

# 3. Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table("./data/activity_labels.txt", col.names = c("ActivityId", "Activity"))

sensor_all_mean_std <- join(sensor_all_mean_std, activity_labels, by = "ActivityId", match = "first")
sensor_all_mean_std <- sensor_all_mean_std[,-1]

# 4. Appropriately labels the data set with descriptive names.

names(sensor_all_mean_std) <- gsub('\\(|\\)',"",names(sensor_all_mean_std), perl = TRUE)
names(sensor_all_mean_std) <- make.names(names(sensor_all_mean_std))

names(sensor_all_mean_std) <- gsub('Acc',"Acceleration",names(sensor_all_mean_std))
names(sensor_all_mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(sensor_all_mean_std))
names(sensor_all_mean_std) <- gsub('Gyro',"AngularSpeed",names(sensor_all_mean_std))
names(sensor_all_mean_std) <- gsub('Mag',"Magnitude",names(sensor_all_mean_std))
names(sensor_all_mean_std) <- gsub('^t',"TimeDomain.",names(sensor_all_mean_std))
names(sensor_all_mean_std) <- gsub('^f',"FrequencyDomain.",names(sensor_all_mean_std))
names(sensor_all_mean_std) <- gsub('\\.mean',".Mean",names(sensor_all_mean_std))
names(sensor_all_mean_std) <- gsub('\\.std',".StandardDeviation",names(sensor_all_mean_std))
names(sensor_all_mean_std) <- gsub('Freq\\.',"Frequency.",names(sensor_all_mean_std))
names(sensor_all_mean_std) <- gsub('Freq$',"Frequency",names(sensor_all_mean_std))

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

sensor_avg_by_act_sub = ddply(sensor_all_mean_std, c("Subject","Activity"), numcolwise(mean))
write.table(sensor_avg_by_act_sub, file = "sensor_avgerage_by_activity_subject2.txt", row.name=FALSE)