library(tidyverse)
library(rpivotTable)
pcid <- read.delim('/Users/jinzhao/Desktop/dau/留存/核心渠道打开数.tsv',header = TRUE,sep = '\t')
rpivotTable(pcid)
pcid_exit <- read.delim('/Users/jinzhao/Desktop/dau/留存/核心渠道退出方式.tsv',header = TRUE,sep = '\t')
rpivotTable(pcid_exit)
pcid_exit_vname <- read.delim('/Users/jinzhao/Desktop/dau/留存/vivo按版本退出次数.tsv',header = TRUE,sep = '\t')
rpivotTable(pcid_exit_vname)



data <- read.table(pipe("pbpaste"), sep="\t", header=T)
View(data)
