library(openxlsx)
library(GGally)
keep <- read.xlsx('/Users/jinzhao/Desktop/dau/留存/次留关系.xlsx',sheet = 3)
keep
cov(keep[6:12])
cor(keep[6:12])
pairs(keep[6:12])
keep<- keep %>%  rename(date ="日期",plat="平台",type ="用户",pcid="渠道",vname = "版本",dau="日活",keep="次留",
       alltime="人均使用时长(分)",vvtime="人均播放时长(分)",vv_p="人均播放量",shows_p="人均曝光视频数",starttime="人均启动次数") %>% filter(keep != 0)
ggscatmat(keep,columns = 6:12)
#####视频维度####
keep_v <- read.xlsx('/Users/jinzhao/Desktop/dau/留存/次留关系.xlsx',sheet = 4)
colnames(keep_v)
ggscatmat(keep_v,columns = 4:14)
