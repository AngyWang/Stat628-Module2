#Yiran Wang: data cleaning part, use CV to diagnose the model.
#Xiaofeng Wang: Model testing, selection and try different method of modeling.
#Jiawei Huang: add new method of data cleaning and do the anova test for interaction and square.

#Step 1  Analyzing Raw Data

data<-read.csv("BodyFat.csv")
#We first look into the Bodyfat data.
head(sort(data$BODYFAT))
tail(sort(data$BODYFAT))
#Ok, we find there is an extreme data whose bodyfat is 0, so we delete it.
data<-data[-which(data$BODYFAT==0),]
#Second, we look into WEIGHT data
head(sort(data$WEIGHT))
tail(sort(data$WEIGHT))
#Then we first find there is an extreme data whose WEIGHT is 363.1, it's too high, so we delete it.
data<-data[-which(data$WEIGHT==363.15),]
#Third, we look into HEIGHT data
head(sort(data$HEIGHT))
tail(sort(data$HEIGHT))
#There is an outlier which is too small, so we delete it.
data<-data[-which(data$HEIGHT==29.50),]
#Then we use summary and see that the data is fine, no obvious outliers.
summary(data)
#Now let's use BMI to see whether there are some outliers.
BMI<-data$WEIGHT/(data$HEIGHT)^2 #This is the formula of BMI
plot(BMI,data$ADIPOSITY,xlab = "BMI",ylab = "ADIPOSITY")
#Ok, we find 2 points that are extreme points, now we can get their No.
#identify(x=BMI,y=data$ADIPOSITY,n=2)
#Then we will delete them.
data<-data[-218,]
data<-data[-161,]
#Now we use another method: siri equation to detect the extreme points.
Siri_equation<-(495/data$DENSITY)-450#This equation is from the reference and Internet.
plot(Siri_equation,data$BODYFAT,xlab = "Siri equation",ylab = "BODYFAT")
#Ok, we find 3 points that are extreme points, now we can get their No.
#identify(x=Siri_equation,y=data$BODYFAT,n=3)
#Then we delete them 
data<-data[-94,]
data<-data[-74,]
data<-data[-46,]


#Step 2  Model
data_new<-data[,-c(1,3)]
#First we want to use a model that is easy for the user to use, which means that the data should be easy for user to get. Here we use AGE, WEIGHT, HEIGHT.
model001<-lm(BODYFAT~AGE+WEIGHT+HEIGHT, data = data_new)
summary(model001)
#By searching online we find that the relationship between BodyFat and these variables are linear and there are no interactions, so 
#we use BIC to choose the best model. But in order to prove it, we use anova to show it.
#anova
model_2nd = lm(BODYFAT~.^2,data = data_new)
summary(model_2nd)
model_1st = lm(BODYFAT~.,data = data_new)
summary(model_1st)
#by the summary we can find that the adj R square doesn't change too much, so we know that the model without interactions would be better by the result of anova.

data_new1 = data_new^2
colnames(data_new1) = paste0(colnames(data_new1),"2")
data_new1 = cbind(data_new1,data_new)
model_square = lm(BODYFAT~WEIGHT+ADIPOSITY+HEIGHT+CHEST+ABDOMEN+THIGH+KNEE+ANKLE+FOREARM+WRIST+BICEPS+HIP+AGE+NECK+WEIGHT2+HEIGHT2+CHEST2+ABDOMEN2+THIGH2+KNEE2+ANKLE2+FOREARM2+WRIST2+BICEPS2+HIP2+AGE2+NECK2+ADIPOSITY2,data = data_new1)
summary(model_square)
anova(model_1st,model_square,model_2nd)
#by the summary we can find that the adj R square doesn't change too much, so we know that the model with square would be better by the result of anova.

#Next we use all the variables except the ADIPOSITY to do the model because it has relation with HEIGHT and WEIGHT. This is our model 2
model01<-lm(BODYFAT~1, data = data_new)
model02<-lm(BODYFAT~(WEIGHT+HEIGHT+CHEST+ABDOMEN+THIGH+KNEE+ANKLE+FOREARM+WRIST+BICEPS+HIP+AGE+NECK), data = data_new)
model03<-step(model01,scope=list(upper=model02),direction = "both")
summary(model03)
#Then we delete thes insignificant variables and do it again, this is our model 3
model1<-lm(BODYFAT~1, data = data_new)
model2<-lm(BODYFAT~(WEIGHT+ABDOMEN+WRIST), data = data_new)
model3<-step(model1,scope=list(upper=model2),direction = "both")
summary(model3)
#Ok, now the adj R square is fine and we don't put in too much variables, it is a good model



#here we use cross vaildation to check.
if (!require("DAAG")) {
  install.packages("DAAG")
  stopifnot(require("DAAG"))
}
cv.lm(data = data_new, form.lm = model001, m=7)
mybest001.mse<-sum((data_new$BODYFAT-model001$fitted.values)^2)/(length(data_new$BODYFAT)-3)
mybest001.mse
cv.lm(data = data_new, form.lm = model03, m=7)
mybest03.mse<-sum((data_new$BODYFAT-model03$fitted.values)^2)/(length(data_new$BODYFAT)-4)
mybest03.mse
cv.lm(data = data_new, form.lm = model3, m=7)
mybest3.mse<-sum((data_new$BODYFAT-model3$fitted.values)^2)/(length(data_new$BODYFAT)-3)
mybest3.mse

head(predict(model3,level=0.95,interval = "c"))
#model diagnostic
par(mfrow = c(1,1))
plot(predict(model3),resid(model3),pch=19,cex=1.2,cex.lab=1.5,cex.main=1.5,
     xlab="Predicted Body Fat %", ylab="Standardized Residuals",main="Standardized Residual Plot")
abline(a=0,b=0,col="black",lwd=3)

qqnorm(rstandard(model3),pch=19,cex=1.2,cex.lab=1.5,cex.main=1.5,
       main="Normal Q-Q Plot of the Residuals")
abline(a=0,b=1,col="red",lwd=3)

pii = hatvalues(model3)
cooki = cooks.distance(model3)


n = length(data_new$BODYFAT)
plot(1:n,pii,type="p",pch=19,cex=1.2,cex.lab=1.5,cex.main=1.5,
     xlab="Index (Each Observation)",ylab="Pii",main="Leverage Values (Pii)")
#identify(x=1:n,y=pii,n=5)
plot(1:n,cooki,type="p",pch=19,cex=1.2,cex.lab=1.5,cex.main=1.5,
     xlab="Index (Each Observation)",ylab="Cook's Distance",main="Influence Values (Cook's Distance)")
#identify(x=1:n,y=cooki,n=2)


par(mfrow = c(1,1))
plot(data_new$BODYFAT,col="red",type="l",ylab = "Body Fat")
lines(model3$fitted.values,col="blue",type="l")

