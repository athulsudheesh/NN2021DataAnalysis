library(nptest)
library(psych)
library(ggplot2)
library(ltm)
library(Gifi)
dpath = file.path("..","cleanData", "X1.csv")
data = read.csv(dpath)

data = as.matrix(data)

## Non parametric bootstrap sampling with replacement 
ix = sample(1:nrow(data), 200, replace = T)
npbootdata = data[ix,]
npbootdf <- as.data.frame(npbootdata)
datasum <- describe(npbootdata)
describe(data)

plot(datasum$mean, ylim = c(0,1), pch=19, xlab = "Item Number", ylab = "% Correct")
axis(1,at = 1:12,labels = colnames(data))

PL1.rasch<-rasch(npbootdata)
plot(PL1.rasch,type=c("ICC"))
plot(PL1.rasch,type=c("IIC"))
plot(PL1.rasch,type=c("IIC"),items=c(0))
item.fit(PL1.rasch,simulate.p.value=T)
summary(PL1.rasch)
priNN <- princals(npbootdata, ndim = 4)
plot(priNN)

dscp <- descript(npbootdata)
plot(dscp)

sc <- factor.scores(PL1.rasch)
hist(sc$score.dat$z1, xlab="Estimated Ability Parameters (Rasch Model)")
co <- rcor.test(npbootdata)
library(corrplot)
corrplot(co$cor.mat, method="square", order="AOE")
plot(sc, include.items = TRUE, main = "KDE for Person Parameters")
person.fit(PL1.rasch)
