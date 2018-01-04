library(tidyverse)
####测试na替换 
df <- dplyr::data_frame(
  x = c(1, 2, NA),
  y = c("a", NA, "b")
)
df
df %>% replace_na(list(x = 0, y = "unknown"))
####测试
