library (here)
library(ggplot2)
library (plotly)
library(wesanderson)

Synoptics <- read.csv(here("FieldData/Vaisala/Synoptics2.csv"))

plot<- ggplot(Synoptics) +
  geom_point(aes(x= Distance, y= Syn1_071819), color= "blue", size = 2) +
  geom_point(aes(x= Distance, y= Syn2_072519), color= "cornflowerblue", size = 2) +
  geom_point(aes(x= Distance, y= Syn3_072919), color= "darkgoldenrod1", size = 2) +
  geom_point(aes(x= Distance, y= Syn4_073119), color= "darkolivegreen3", size = 2) +
  geom_point(aes(x= Distance, y= Syn5_080619), color= "darkgreen", size = 2) +
  geom_point(aes(x= Distance, y= Syn6_081219), color= "darkblue", size = 2) +
  labs(x = "Distance from Upstream (m)",y= "pCO2") +
  ggtitle("Synoptics")

ggplotly(plot)


