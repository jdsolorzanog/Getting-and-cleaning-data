# Code Book

<strong> Spanish version </strong>

El script run_analysis.R inicia preparando los datos para su transformación en base a los siguientes pasos:

1. Descargar el conjunto de datos: Apoyándose en los comandos file y download.file
2. Asignación de variables a los datos: 
  - features <- features.txt: Corresponden a las señales sin procesar de 3 ejes del acelerómetro y giroscopio tAcc-XYZ y tGyro-XYZ.
  - activities <- activities.txt: Lista de actividades realizadas
  - subject_test <- test/subject_test.txt: Contiene los datos de los sujetos del grupo de prueba
  - x_test <- test/X_test.txt: Recopila los datos de prueba de las características registradas
  - y_test <- test/y_test.txt: Contiene los nombres de las actividades de los datos de prueba
  - subject_train <- test/subject_train.txt: Contiene los datos de los sujetos del grupo de entrenamiento
  - x_train <- test/X_train.txt: Contiene las características registradas en los datos de entrenamiento
  - y_train <- test/Y_train.txt: Contiene los nombres de las actividades para los datos de entrenamiento
3. Combinar los datos de entrenamiento y prueba en un solo conjunto
  - X = rbind(x_train, x_test)
  - Y = rbind(y_train, y_test)
  - Subject = rbind(subject_train, subject_test)
  - Merge <- cbind(Subject, Y, X)
 4. Extraer solo las medidas de la media y la desviación estándar de cada medida
  - Tidy <- Merge %>% select(subject,code,contains("mean"), contains("std"))
 5. Usar nombres de actividades descriptivos para nombrar las actividades en el conjunto de datos
  Tomé los códigos en el conjunto de datos Tidy y los reemplacé con la actividad correspondiente en el conjunto de actividades
 6. Etiquetar apropiadamente el conjunto de datos con nombres de variables descriptivos
  - La columna code en Tidy fue renombrada como actividades
  - Otros cambios en nombres de columnas:
    - Acc por Accelerometer
    - Gyro por Gyroscope
    - BodyBody por Body
    - Mag por Magnitude
    - Todas las que inicien con la letra f reemplazadas por Frequency
    - Todas las que inicien con la letra t reemplazadas por Time 
  7. A partir del conjunto de datos del paso 4, crear un segundo conjunto de datos ordenado e independiente con el promedio de cada variable para cada actividad y cada sujeto.
      Second se crea resumiendo Tidy, tomando las medias de cada variable para cada actividad y cada sujeto, después de agruparlos por sujeto y actividad
        
        Second <- Tidy %>% group_by(subject,activity) %>%
        summarise_all(funs(mean))
        write.table(Second, "Segundo.txt", row.name=FALSE)
  
  
<strong> English version </strong>

The run_analysis.R script starts preparing the data for transformation according to the following steps

1. Download the dataset: Using the commands file and download.file
2. Assigning variables to data: 
  - features <- features.txt: correspond to the raw 3-axis signals of the tAcc-XYZ and tGyro-XYZ accelerometer and gyro.
  - activities <- activities.txt: list of activities performed
  - subject_test <- test/subject_test.txt: Contains the data of the test group subjects
  - x_test <- test/X_test.txt: saves the test data of the registered characteristics
  - y_test <- test/y_test.txt: contains test data of activities’ code labels
  - subject_train <- test/subject_train.txt: contains the data of the subjects of the training group
  - x_train <- test/X_train.txt: contains the characteristics recorded in the training data
  - y_train <- test/Y_train.txt: contains the names of the activities for the training data
3. Merges the training and the test sets to create one data set
  - X = rbind(x_train, x_test)
  - Y = rbind(y_train, y_test)
  - Subject = rbind(subject_train, subject_test)
  - Merge <- cbind(Subject, Y, X)
 4. Extracts only the measurements on the mean and standard deviation for each measurement
  - Tidy <- Merge %>% select(subject,code,contains("mean"), contains("std"))
 5. Uses descriptive activity names to name the activities in the data set
  I took the codes in the Tidy dataset and replaced them with the corresponding activity in the activity data set
 6. Appropriately labels the data set with descriptive variable names
  - code column in Tidy renamed into activities
  - Changes in column's names:
    - Acc by Accelerometer
    - Gyro by Gyroscope
    - BodyBody by Body
    - Mag by Magnitude
    - All start with character f replaced by Frequency
    - All start with character t replaced by Time
7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
    Second is created by summarizing Tidy, taking the means of each variable for each activity and each subject, after grouping them by subject and activity
        
        Second <- Tidy %>% group_by(subject,activity) %>%
        summarise_all(funs(mean))
        write.table(Second, "Segundo.txt", row.name=FALSE)
      
  
