library("ggplot2")
install.packages("colorspace")
library("gapminder")
library(here)

data <- read.csv(here("FieldData","lvllgr06182019rogersroad.csv"), skip = 11)

plot <- ggplot(new)+
  geom_line(aes(x= Time, y= LEVEL))     
