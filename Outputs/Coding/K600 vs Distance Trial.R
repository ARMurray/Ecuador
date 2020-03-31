library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)
library(scales)

July18<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method07_18.csv")
July25<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method7_25.csv")
July31<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method7_31.csv")
Aug6<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method 08_06.csv")
Aug12<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method08_12.csv")

K600Total<-cbind(July18,July25$K600.Avg...m.day.,July31$K600.Avg...m.day.,Aug6$K600.Avg...m.Day.,Aug12$K600.Mid)
Distance<-K600Total$Distance.From.Upstream
July18K<-K600Total$K600.Avg...m.day.
July25K<-K600Total$`July25$K600.Avg...m.day.`
July31K<-K600Total$`July31$K600.Avg...m.day.`
Aug6K<-K600Total$`Aug6$K600.Avg...m.Day.`
Aug12K<-K600Total$`Aug12$K600.Mid`

Plot<-ggplot(K600Total,aes(x=Distance,y=July18K,colour="Red"))+
               geom_point(colour="Red",shape=19,size=2)+
               geom_point(data =K600Total,aes(x=Distance,y=July25K,colour="Orange",shape=19,size=2))+
               geom_point(data =K600Total,aes(x=Distance,y=July31K,colour="Yellow",shape=19,size=2))+
               geom_point(data =K600Total,aes(x=Distance,y=Aug6K,colour="Green",shape=19,size=2))+
               geom_point(data =K600Total,aes(x=Distance,y=Aug12K,colour="Blue",shape=19,size=2))
            
Plot        
 