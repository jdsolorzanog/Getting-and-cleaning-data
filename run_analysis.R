# Getting and cleaning data project
# Author: Juan Diego Solórzano Gómez

# Cargar paquetes requeridos/Load packages
library(dplyr)

# Descargar conjunto de datos / Download dataset
filename <- "project.zip"

#Verificar la existencia del archivo / Verify if the file exists
if(!file.exists(filename)){
  link<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(link,filename,method="curl")
}

#Verificar la existencia de la carpeta / Verify if the folder exists
if(!file.exists("UCI HAR Dataset")){
  unzip(filename)
}

# Crear dataframes / Create dataframes
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Mezclar los datos / Merge the data
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merge <- cbind(Subject, Y, X)

# Extraer solo los datos de la media y la desviación estándar
# Extract mean and standard deviation

Tidy <- Merge %>% select(subject,code,contains("mean"), contains("std"))

# Usar nombres de actividades descriptivas para nombrar las actividades en el conjunto de datos
# Uses descriptive activity names to name the activities in the data set

Tidy$code <- activities[Tidy$code, 2]

# Etiquetar con nombres de variables descriptivos
# Appropriately labels the data set with descriptive variable names

names(Tidy)[2] = "activity"
names(Tidy)<-gsub("Acc", "Accelerometer", names(Tidy))
names(Tidy)<-gsub("Gyro", "Gyroscope", names(Tidy))
names(Tidy)<-gsub("BodyBody", "Body", names(Tidy))
names(Tidy)<-gsub("Mag", "Magnitude", names(Tidy))
names(Tidy)<-gsub("^t", "Time", names(Tidy))
names(Tidy)<-gsub("^f", "Frequency", names(Tidy))
names(Tidy)<-gsub("tBody", "TimeBody", names(Tidy))
names(Tidy)<-gsub("-mean()", "Mean", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("-std()", "STD", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("-freq()", "Frequency", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("angle", "Angle", names(Tidy))
names(Tidy)<-gsub("gravity", "Gravity", names(Tidy))

# crea un segundo conjunto de datos ordenado e independiente con el promedio de cada variable para cada actividad y cada tema
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject

Second <- Tidy %>% group_by(subject,activity) %>%
summarise_all(funs(mean))
write.table(Second, "Segundo.txt", row.name=FALSE)
