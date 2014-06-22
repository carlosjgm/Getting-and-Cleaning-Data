#Loads data ----------------------------
#load X
x_train <- read.table("train/X_train.txt")
x_test <- read.table("test/X_test.txt")
features <- read.table("features.txt")
#load y
y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")
activity_labels <- read.table("activity_labels.txt")
#load subject
subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")

# 1. Merges the training and the test sets to create one data set.
x <- rbind(x_train,x_test)
y <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
selected_features <- which(grepl("mean\\(\\)|std\\(\\)",features[,2]))
x <- x[,selected_features]

# 3. Uses descriptive activity names to name the activities in the data set
y <- activity_labels[y[,1],2]

# 4. Appropriately labels the data set with descriptive variable names. 
colnames(x) <- features[selected_features,2]
tidydata <- cbind(subject,y,x)
colnames(tidydata)[1:2] <- c("subject","activity")

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
library(reshape2)
tidydata.melted <- melt(tidydata, id = c("subject", "activity"))
tidydata.casted <- dcast(tidydata.melted, subject+activity~variable,mean)

#Saves cleaned dataset and means dataset.
write.table(tidydata, "Tidy Dataset.txt")
write.table(tidydata.casted, "Means of Tidy Dataset.txt")

#Generates codebook.md
codebook <- array()
codebook[1] <- "#Code Book"
codebook[2] <- "##Feature List in Tidy Dataset.txt"
codebook[3] <- "`[1] subject` - the subjects' ids (integers between 1 and 30)"
codebook[4] <- "`[2] activity` - the activity label"
for(i in 1:6) 
  codebook[4+i] <- paste(">",i,". ",activity_labels[i,2],sep="")
for(i in 1:length(selected_features))
  codebook[10+i] <- paste("`[",2+i,"] ",features[selected_features[i],2],"`",sep="")
offset <- 10 + length(selected_features)
codebook[offset+1] <- "*-mean(): Mean value*"
codebook[offset+2] <- "*-std(): Standard deviation*"
codebook[offset+3] <- "##Feature List in Means of Tidy Dataset.txt"   

for(i in 1:length(colnames(tidydata.casted)))
  codebook[offset+3+i] <- paste("`[",i,"] ",colnames(tidydata.casted[i]),"`",sep="")

write(codebook,"codebook.md")

