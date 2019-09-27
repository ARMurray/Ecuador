library(here) 
library(ggplot2) 
library(tidyr) 
library(dplyr) 
library(wesanderson) 

syn <- read.csv(here("FieldData/Vaisala/synavg.csv"))

plot1 <- ggplot(syn) + 
  geom_errorbar(aes(x= Distance, y= Avg, ymin= Avg - Stdv, ymax= Avg + Stdv), width=0.2, size=1, color="darkblue") +   
  geom_point(aes(x= Distance, y= Avg), color = "darkblue", size = 2) +   
  labs(x = "Distance from Upstream (m)", y = "Average CO2 (ppm)") 

ggplotly(plot1)
