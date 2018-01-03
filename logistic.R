x <- seq(-10,10,0.01) #生成序列
y <- 1/(1+exp(-x))
library(ggplot2)
curve(1/(1+exp(-x)),from = -10,to = 10,n = 100)
library(C50)
library(forcats)
data(churn)
train <- churnTrain
test <- churnTest
train <- train[,-3] #邮政编码无意义
test <- test[,-3]
fct_relevel(test$churn,"no")
fct_relevel(train$churn,"no")
model <- glm(churn~.,data = train,family = 'binomial')
summary(model)
model2 <- step(object = model,trace = 0)
summary(model2)
anova(object = model2,test = 'Chisq')
prob <- predict(object = model2,newdata = test,type = 'response')
pred <- ifelse(prob>=0.5,'yes','no')
pred <- factor(pred,levels = c('no','yes'))
table(test$churn,pred)

prob<-predict(object =model2,newdata=test,type = "response")
pred<-ifelse(prob>=0.5,"yes","no")
pred
pred<-factor(pred,levels = c("no","yes"),order=TRUE)
table(test$churn,pred)
library(pROC)
roc_curve <- roc(test$churn,prob)
names(roc_curve)
x <- 1-roc_curve$specificities
y <- roc_curve$sensitivities

library(ggplot2)
p <- ggplot(data = NULL, mapping = aes(x= x, y = y))
p + geom_line(colour = 'red') +geom_abline(intercept = 0, slope = 1) + annotate('text', x = 0.4, y = 0.5, label =paste('AUC=',round(roc_curve$auc,2)))
+ labs(x = '1-specificities',y = 'sensitivities', title = 'ROC Curve')
