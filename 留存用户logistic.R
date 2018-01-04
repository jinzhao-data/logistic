library(tidyverse)
library(rpivotTable)
dt <- read_delim("~/Desktop/dau/留存/logistic.tsv", 
                      "\t", escape_double = FALSE, trim_ws = TRUE)
dt$win <- as.factor(dt$win)
dt <- dt %>% mutate(ctr = click/showtimes,p_compl = vvtimes/alltimes) %>% replace_na(list(ctr = 0,p_compl = 0))
dt$ctr[which(dt$ctr==Inf)] = 100
dt$p_compl[which(dt$p_compl==Inf)] = 100
train <- sample_frac(dt,size = 0.7)
test <- setdiff(dt,train)
fit <- glm(win~appstrart+showtimes+click+vv+vvtimes+alltimes+ctr+p_compl,data = train,family=binomial())
summary(fit)
model2 <- step(object = fit,trace = 0)
summary(model2)
prob <- predict(object = model2,newdata = test,type = 'response')
pred <- ifelse(prob>=0.5,'1','0')
t <- table(test$win,pred)

library(randomForest)
fit.forest <- randomForest(win~appstrart+showtimes+click+vv+vvtimes+alltimes+ctr+p_compl,
                           data = train,na.action = na.roughfix,importance = TRUE)
fit.forest
importance(fit.forest, type = 2)
forest.pred <- predict(fit.forest,test)
forest.perf <- table(test$win, forest.pred)
forest.perf
