setwd("./UCI HAR Dataset/")
library(dplyr)
library(tidyr)
  ##read in and merge the data
feat<-read.table("features.txt")
act.labels<-read.table("activity_labels.txt")
test.subject<-read.table("./test/subject_test.txt")
x.test<-read.table("./test/X_test.txt")
y.test<-read.table("./test/Y_test.txt")
train.subject<-read.table("./train/subject_train.txt")
x.train<-read.table("./train/X_train.txt")
y.train<-read.table("./train/Y_train.txt")
subject.merge<-rbind(test.subject,train.subject)
x.merge<-rbind(x.test,x.train)
y.merge<-rbind(y.test,y.train)
  ##index is a vector of the 86 variables that contain mean or std in their description
index<-c(1:3,41:43,81:83,121:123,161:163,201,214,227,240,253,266:268,294:296,
          345:347,373:375,424:426,452:454,503,513,516,526,529,539,542,552,555:561,
          4:6,44:46,84:86,124:126,164:166,202,215,228,241,254,269:271,348:350,
          427:429,504,517,530,543)
colnames(x.merge)<-feat$V2 ##label the variables
x.subset<-x.merge[,index] ##subset only the mean and std variables
dat<-cbind(subject.merge,y.merge,x.subset) ##bind everything into one data set
colnames(dat)[c(1,2)]<-c("subject","activity") ##rename the first two columns
  ##label the activities
dat<-merge(act.labels,dat,by.x="V1",by.y="activity",sort=FALSE)
  ##remove the extra column added and reorder with subject first, and rename activity column
dat<-dat%>%select(-V1)%>%select(subject,activity=V2,everything())
  ##group by subject and activity, and calculate mean of each measurement
dat.final<-dat %>% group_by(subject,activity) %>% summarize_each(funs(mean))
  ##export to text file
write.table(dat.final,file="dat.final.txt",row.names=FALSE)