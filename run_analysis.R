#set directory

setwd("/Users/nakicam/Dropbox/R/getting-and-cleaning-data/course-project")

#download data
library(httr) 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "data.zip"
if(!file.exists(file)){
	print("download started")
	download.file(url, file, method="curl")
}

#unzip and create folders (if those ain't exist)
datafolder <- "UCI HAR Dataset"
resultsfolder <- "result"
if(!file.exists(datafolder)){
	print("unzip started")
	unzip(file, list = FALSE, overwrite = TRUE)
} 
if(!file.exists(resultsfolder)){
	print("creating folder")
	dir.create(resultsfolder)
} 

#read the  txt and covnert to data.frame
importtables <- function (filename,cols = NULL){
	print(paste("Processing table:", filename))
	processing <- paste(datafolder,filename,sep="/")
	data <- data.frame()
	if(is.null(cols)){
		data <- read.table(processing,sep="",stringsAsFactors=F)
	} else {
		data <- read.table(processing,sep="",stringsAsFactors=F, col.names= cols)
	}
	data
}

#importing tables
imp <- importtables("processing.txt")

#read data and build database
getdaten <- function(type, imp){
	print(paste("Getting data", type))
	subject_data <- importtables(paste(type,"/","subject_",type,".txt",sep=""),"id")
	y_data <- importtables(paste(type,"/","y_",type,".txt",sep=""),"activity")
	x_data <- importtables(paste(type,"/","X_",type,".txt",sep=""),imp$V2)
	return (cbind(subject_data,y_data,x_data))
}

#run getdaten
test <- getdaten("test", imp)
train <- getdaten("train", imp)

#save the resulting data in the indicated folder
result <- function (daten,name){
	print(paste("saving", name))
	file <- paste(resultsfolder, "/", name,".csv" ,sep="")
	write.csv(daten,file)
}

#1) Merges the training and the test sets to create one data set -> daten
library(plyr)
daten <- rbind(train, test)
daten <- arrange(daten, id)

#2) Extracts only the measurements on the mean and standard deviation for each measurement in mean_and_std
mean_and_std <- daten[,c(1,2,grep("std", colnames(daten)), grep("mean", colnames(daten)))]
saveresults(mean_and_std,"mean_and_std")

#3) descriptive activity names to name the activities in the data set
activity_labels <- gettables("activity_labels.txt")

#4) labels the data set with descriptive variable names 
daten$activity <- factor(daten$activity, levels=activity_labels$V1, labels=activity_labels$V2)

#5) Create tidy data set tidy_dataset.csv 
tidy_dataset <- ddply(mean_and_std, .(id, activity), .fun=function(x){ colMeans(x[,-c(1:2)]) })
colnames(tidy_dataset)[-c(1:2)] <- paste(colnames(tidy_dataset)[-c(1:2)], "_mean", sep="")
saveresults(tidy_dataset,"tidy_dataset.csv")
