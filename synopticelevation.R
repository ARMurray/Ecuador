library(here)
library(dplyr)
library(ggplot2)
library(plotly)
library(crayon)
library(cowplot)


ele <- read.csv(here::here("syn1.csv"))



dve <- ggplot(data=ele, aes(x=Distance, y=Elevation)) +
  geom_line(linetype = "dashed")+
  geom_point(aes(x= Distance, y= Elevation), color= "#56B4E9", size = 2) +
  geom_point(aes(x= Distance.for.Eos, y= Elevation), color= "black", size = 2) +
  labs(x = "Distance from Wetland [m]", y= "Elevation [m]")  +
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill = "transparent", color = NA)) +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=10,face="bold"),
        axis.title.y = element_text(size = 10)) 
  #  theme(legend.position= c(0.8, 0.65),
  #    legend.title = element_text(size = 14,face="bold"),
  #    legend.text = element_text(size = 12)) +
  #  theme(legend.background = element_rect(colour = 'black', fill = 'white', linetype='solid')) +
#  theme(panel.border = element_rect(fill=NA, colour = "black", size=1.5))

dve

dev.copy(png,'Rplot19.png')
dev.off()
