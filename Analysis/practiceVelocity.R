library(here)

library(ggplot2)
v <- read.csv(here("FieldData/Vaisala/Synoptics2.csv"))
syn1 <- v$Syn1_071819
syn2 <-v$Syn2_072519
syn3 <- v$Syn4_073119
syn4 <-v$Syn5_080619
syn5 <- v$Syn6_081219
dis <- v$Distance



plot <- ggplot(v) + geom_point(aes(x= Distance, y= Syn1_071819), color = "purple", size = 2) +
plot
