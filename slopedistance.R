#graphing slope vs. welocity 


library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)
library(viridis)
library(grid)
library(gridExtra)

#some aes

largernumbers <- element_text(face = "bold", size = 14)
largernumbers2 <- element_text(face = "bold", size = 12)



#load in the data

slope <- read.csv(here("K600_calculate_newslope_newV_2020-03-12.csv"))

#make a grapg of dist.m vs. slope.unitless

slope2 <- ggplot(slope)+
  geom_point(slope, mapping=aes(x=dist.m, y=slope.unitless, color="purple"))+
  labs(x="Distance from Outlet [m]", y="Slope [unitless]")+
  ggtitle("Distance vs. Slope")+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.text.x = largernumbers2, axis.title.x=largernumbers,
        axis.text.y=largernumbers2, axis.title.y=largernumbers,plot.title = element_text(margin = margin(t= 10, b = -20), face="bold"),
        legend.position="none")
  

slope2


