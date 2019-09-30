library(here)

library(ggplot2)
v <- read.csv(here("FieldData/Vaisala/Synoptics2.csv"))

plot <- ggplot(v) + geom_point(aes(x= Distance, y= Syn1_071819), color = "purple", size = 2) +
   geom_point(aes(x= Distance, y= Syn2_072519), color = "green", size = 2) +
   geom_point(aes(x= Distance, y= Syn4_073119), color = "black", size = 2) + 
  geom_point(aes(x= Distance, y= Syn5_080619), color = "blue", size = 2) +
  geom_point(aes(x= Distance, y= Syn6_081219), color = "red", size = 2) 
plot
