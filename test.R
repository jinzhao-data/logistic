library(tidyverse)
library(plotly)
####测试na替换 
df <- dplyr::data_frame(
  x = c(1, 2, NA),
  y = c("a", NA, "b")
)
df
df %>% replace_na(list(x = 0, y = "unknown"))
####测试####
dt <- read_delim("~/Desktop/dau/留存/logistic.tsv", "\t", escape_double = FALSE, trim_ws = TRUE)
colnames(dt)
ggplot(dt,aes(x= vvtimes)) + geom_histogram(binwidth = 2) + xlim(c(-10,100))
ploy <- dt %>% mutate(vtime = vvtimes/vv) %>% ggplot(aes(x = vtime,colour = win)) + geom_density(stat = 'density') + xlim(c(-1,1000))
ggplotly(ploy)
dt %>% mutate(vtime = vvtimes/vv) %>% ggplot(aes(x = vtime,colours = win)) + geom_histogram(binwidth = 2) + xlim(c(-1,1000))
