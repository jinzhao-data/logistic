#####1.加载包#####
library(tidyverse)
library(rpivotTable)
library(rpart)
library(caret)
#####2.读取数据####
dt <- read_delim("~/Desktop/dau/留存/logistic.tsv", "\t", escape_double = FALSE, trim_ws = TRUE)
#####数据整理####
dt$win <- as.factor(dt$win) #因子化
dt <- dt %>% mutate(ctr = click / showtimes, p_compl = vvtimes / alltimes) %>% replace_na(list(ctr = 0, p_compl = 0))
dt$ctr[which(dt$ctr==Inf)] = 100
dt$p_compl[which(dt$p_compl==Inf)] = 100
train <- sample_frac(dt,size = 0.7)
test <- setdiff(dt,train)
#####模型训练####
fit <- rpart(win~appstrart+showtimes+click+vv+vvtimes+alltimes+ctr+p_compl,data = train)
#####结果展现####
summary(fit)
plot(fit)
text(fit)
#####预测####
testfinal <- predict(fit,test,type = 'class')
confusionMatrix(table(testfinal,test$win))
