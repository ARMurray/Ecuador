library(here)
library(dplyr)
library(ggplot2)
library(plotly)
library(crayon)

df <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))%>%
  select(DateTime,Inj,V1,V2,V3,V4)%>%
  filter(!(Inj == "Yes"))
df$DateTime <- as.POSIXct(df$DateTime)  

df <- df%>%
  filter(DateTime > as.POSIXct("2019-07-10 11:30:00") & DateTime < as.POSIXct("2019-08-13 12:15:00"))

outplot <- ggplot(df)+
  geom_point(aes(x= DateTime, y= V1,color="Station 1"), size = 1) +
  geom_point(aes(x= DateTime, y= V2,color="Station 2"), size = 1) +
  geom_point(aes(x= DateTime, y= V3,color="Station 3"), size = 1) +
  geom_point(aes(x= DateTime, y= V4,color="Station 4"), size = 1) +
    scale_color_manual(values=c("#F3C519","#1A5807", "#1B48A9", "#63ABF9"))+
  labs(x = "Date", y= bold(pCO["2"]~"[ppm]")) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=20),
        axis.title.y = element_text(size = 20))+
  theme(legend.position= c(0.8,0.8)) +
  theme(legend.title = element_text(colour="black", size=10, face="bold"), 
       legend.text = element_text(size = 12)) +
  theme(legend.background = element_rect(colour = 'black', fill = 'white', linetype='solid')) +
  theme(panel.border = element_rect(fill=NA, colour = "black", size=1.5)) +
  labs(color = "Location")

outplot

