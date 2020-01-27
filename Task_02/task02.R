setwd("C:\\Users\\morgan\\Desktop\\Evolution\\Tasks\\Task_02")
Data<-read.csv("http://jonsmitchell.com/data/beren.csv", stringsAsFactors=F)
Data
length(Data)
nrow(Data)
ncol(Data)
colnames(Data)
head(Data)
Data[1]
Data[2]
Data[1:3]
Data[1:3, 4]
Data[1:5, 1:3]
Feeds<-which(Data[,9]=="bottle")
berenMilk<-Data[Feeds,]
head(berenMilk)
Feeds<-which(Data[,"event"]=="bottle")
Feeds<-which(Data$event=="bottle")
beren <- Data
dayID<-apply(beren, 1, function(x) paste(x[1:3], collapse="-"))
dateID<-sapply(dayID, as.Date, format= "%Y-%m-%d", origin="2019-04-18")
beren$age <- dateID - dateID[which(beren$event=="birth")]
head(beren)
beren2<-beren
beren3 <- beren2[order(beren$age),]
write.csv(beren3, "beren_new.csv", quote=F, row.names=FALSE)
#Question 1: The two hypotheses are inappropriate because we only have data of him eating and napping at daycare and not for when he isn't at daycare.  So, you could not base an outcome to those hypotheses to be true when there is more data that should be accounted for.
avgMilk<-mean(beren3$value[Feeds])
avgFeed<-tapply(beren3$value[Feeds], beren3$age[Feeds], mean)
avgFeed
varFeed<-tapply(beren3$value[Feeds], beren3$age[Feeds], var)
totalFeed<-tapply(beren3$value[Feeds], beren3$age[Feeds], sum)
numFeeds<-tapply(beren3$value[Feeds], beren3$age[Feeds], length)
cor(beren3$value[Feeds], beren3$age[Feeds])
cor.test(beren3$value[Feeds], beren3$age[Feeds])
berenCor<-cor.test(beren3$value[Feeds], beren3$age[Feeds])
summary(berenCor)
boxplot(beren3$value[Feeds] ~ beren3$caregiver[Feeds], xlab="who gave the bottle", ylab="amount of milk consumed (oz)")
berenANOVA<-aov(beren3$value[Feeds] ~ beren3$caregiver[Feeds])
?par
par(las=1, mar=c(5, 5, 1, 1), mgp=c(2, 0.5, 0), tck=-0.01)
plot(as.numeric(names(totalFeed)), totalFeed, type="b", pch=16, xlab="age in days", ylab="ounces of milk")
abline(h=avgFeed, lty=2, col='red')
par(las=1, mar=c(5, 5, 1, 1), mgp=c(2, 0.5, 0), tck=-0.01)
plot(as.numeric(names(totalFeed)), totalFeed, type="b", pch=16, xlab="age in days", ylab="ounces of milk")
abline(h=avgFeed, lty=2, col='red')
dev.off()
source("http://jonsmitchell.com/code/plotFxn02b.R")
#Question 2: (I was in class for this answer) The baby was not going to the daycare the same amount of time each day he went.

