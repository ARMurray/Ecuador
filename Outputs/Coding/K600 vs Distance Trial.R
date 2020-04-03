library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)
library(scales)
library(here)

July18<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method07_18.csv")
July25<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method7_25.csv")
July31<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method7_31.csv")
Aug6<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method 08_06.csv")
Aug12<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method08_12.csv")

K600Total<-cbind(July18,July25$K600.Avg...m.day.,July31$K600.Avg...m.day.,Aug6$K600.Avg...m.Day.,Aug12$K600.Mid)
Distance<-K600Total$Dist...m.
July18K<-K600Total$K600.Avg...m.day.
July25K<-K600Total$`July25$K600.Avg...m.day.`
July31K<-K600Total$`July31$K600.Avg...m.day.`
Aug6K<-K600Total$`Aug6$K600.Avg...m.Day.`
Aug12K<-K600Total$`Aug12$K600.Mid`

Plot<-ggplot(K600Total,aes(x=Distance,y=July18K,colour="Red"))+
               geom_point(colour="Red",shape=19,size=2)+
               geom_point(data =K600Total,aes(x,y=K600Total$`July25$K600.Avg...m.day.`,colour="Orange",shape=19,size=2))+
               geom_point(data =K600Total,aes(x,y=July31K,colour="Yellow",shape=19,size=2))+
               geom_point(data =K600Total,aes(x,y=Aug6K,colour="Green",shape=19,size=2))+
               geom_point(data =K600Total,aes(x,y=Aug12K,colour="Blue",shape=19,size=2)))
            
##04_02 Attempting with Setting Date as Factor and Assigning a Color to Each Date
##Using GGPlot Legend By Date, change labels to Liters per second
##Update


Syn<-read.csv(here("Outputs/Gas Transfer Velocity/Raymond Method/K600 vs Distance.csv"))
#Date<-Syn$Date
#K600<-Syn$K600
#Distance<-Syn$Distance.From.Upstream

colnames(Syn) <- c("Date","Distance","K600")

ggplot(Syn)+
  geom_point(aes(x=Distance,y=K600,color= Date),shape=19,size=2)+
  scale_color_manual(values=c("18-Jul"="red","25-Jul"="orange","31-Jul"="yellow",
                             "6-Aug"="green","12-Aug"="blue"),
                     name = bquote('Discharge'~m^3~s^-1),
                     labels=c(".00851",".02283",".00702",".00418",".00251"))+
  labs(x ="Distance From Upstream (m)" ,
       y = bquote('K600'~m~d^-1))+
  theme(axis.title.x = element_text(face = "bold",size = 15),
        axis.title.y = element_text(face = "bold",size = 15),
        axis.line = element_line(colour = "black"),
        panel.border = element_rect(colour = "black",fill = NA,size = 3))
