setwd("./uci/UCI HAR Dataset/")
library(dplyr)
library(tidyr)
##
##step 0) load the data
##
feat<-read.table("features.txt")
act.labels<-read.table("activity_labels.txt")
test.subject<-read.table("./test/subject_test.txt")
x.test<-read.table("./test/X_test.txt")
y.test<-read.table("./test/Y_test.txt")
train.subject<-read.table("./train/subject_train.txt")
x.train<-read.table("./train/X_train.txt")
y.train<-read.table("./train/Y_train.txt")
##
##step 1) merge test and training datasets
##
subject.merge<-rbind(test.subject,train.subject)
x.merge<-rbind(x.test,x.train)
y.merge<-rbind(y.test,y.train)
##
##step 2) extract only mean and std measurements
##
##index is a vector where where condition contains "mean" or "std" is true
index<-c(1:3,41:43,81:83,121:123,161:163,201,214,227,240,253,266:268,294:296,
          345:347,373:375,424:426,452:454,503,513,516,526,529,539,542,552,555:561,
          4:6,44:46,84:86,124:126,164:166,202,215,228,241,254,269:271,348:350,
          427:429,504,517,530,543)
colnames(x.merge)<-feat$V2 ##label the variables
x.subset<-x.merge[,index] ##subset only the mean and std variables
dat<-cbind(subject.merge,y.merge,x.subset) ##bind everything into one data set
colnames(dat)[c(1,2)]<-c("subject","activity") ##rename the first two columns
##
##step 3)
##
##label the activities
dat<-merge(act.labels,dat,by.x="V1",by.y="activity",sort=FALSE)
##remove the extra column added and reorder with subject first, and rename activity column
dat<-dat%>%select(-V1)%>%select(subject,activity=V2,everything())
##
##step 4)
##already performed beforehand in line 29
##
##step 5)
##
##create new, tidy dataset with avg of each var for each activity and subject
##group by subject and activity, and calculate mean of each measurement
dat.final<-dat %>% group_by(subject,activity) %>% summarize_each(funs(mean))
##export to text file
write.table(dat.final,file="dat.final.txt",row.names=FALSE)