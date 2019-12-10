library(tidyverse)
library(here)
library(dplyr)
library(ggplot2)
library(plotly)

## Synoptic- Vaisala

Synoptics <- read.csv(here("FieldData/Vaisala/Synoptics2.csv"))
plot <- ggplot(Synoptics) +
  geom_point(aes(x= Distance, y= Syn1_071819, color= "29.7"), size = 3) +
  geom_point(aes(x= Distance, y= Syn2_072519, color= "57.7"), size = 3) +
  geom_point(aes(x= Distance, y= Syn3_072919, color= "24.7"), size = 3) +
  geom_point(aes(x= Distance, y= Syn4_073119, color= "24.3"), size = 3) +
  geom_point(aes(x= Distance, y= Syn5_080619, color= "19.1"), size = 3) +
  geom_point(aes(x= Distance, y= Syn6_081219, color= "14.5"), size = 3) +
    scale_color_manual(values=c("#009e73","#d55e00","blue","#FDE725FF","#cc79a7","#56B4E9")) +
  labs(x = "Distance from Wetland [m]", y= expression(bold(pCO["2"]~"[ppm]")), color= "Discharge [L/s]") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=20,face="bold"),
        axis.title.y = element_text(size = 20))+
  theme(legend.position= c(0.8, 0.65),
        legend.title = element_text(size = 14,face="bold"),
        legend.text = element_text(size = 12)) +
  theme(legend.background = element_rect(colour = 'black', fill = 'white', linetype='solid')) +
  theme(panel.border = element_rect(fill=NA, colour = "black", size=1.5))

plot

##Same as synoptic 2: edited for Diego

Synoptics <- read.csv(here("FieldData/Vaisala/Synoptics2.csv"))
plot1 <- ggplot(Synoptics) +
  geom_point(aes(x= Distance, y= Syn2_072519), color= "#56B4E9", size = 3) +
#    scale_color_manual(values=c("#56B4E9")) +
  labs(x = "Distance from Wetland [m]", y= expression(bold(pCO["2"]~"[ppm]")), color= "Discharge [L/s]") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(axis.text=element_text(size=12),
    axis.title=element_text(size=20,face="bold"),
    axis.title.y = element_text(size = 20))+
#  theme(legend.position= c(0.8, 0.65),
#    legend.title = element_text(size = 14,face="bold"),
#    legend.text = element_text(size = 12)) +
#  theme(legend.background = element_rect(colour = 'black', fill = 'white', linetype='solid')) +
  theme(panel.border = element_rect(fill=NA, colour = "black", size=1.5)) +
  ylim(250,3850)
      
plot1

##Synoptic Average and Standard Deviation

syn <- read.csv(here("FieldData/Vaisala/synavg.csv"))

plot2 <- ggplot(syn) + 
  geom_errorbar(aes(x= Distance, y= Avg, ymin= Avg - Stdv, ymax= Avg + Stdv), width=0.2, size=1, color="black") +   
  geom_point(aes(x= Distance, y= Avg), color = "darkblue", size = 2) +   
  labs(x = "Distance from Wetland [m]", y = expression(bold(pCO["2"]~"[ppm]"))) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(axis.text=element_text(size=12),
      axis.title=element_text(size=20,face="bold"),
      axis.title.y = element_text(size = 20))+
  theme(panel.border = element_rect(fill=NA, colour = "black", size=1.5)) +
ylim(250,3850)

plot2

