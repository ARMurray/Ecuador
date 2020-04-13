library(tidyverse)
library(ggplot2)
library(dplyr)
library(pracma)
library(plotly)
library(scales)
library(plotly)
library(here)

##Opening K600 Comparison Document
K600Compare<-read.csv(here("C:/Users/nehemiah/Desktop/Ecuador - Copy/Outputs/Gas Transfer Velocity/Effective K and Raymond K Comparison.csv"))
OnetoOne<-data.frame('x'=c(100,1000),'y'=c(100,1000))
July18<-K600Compare[c(3:12),]
July25<-K600Compare[c(13:20),]
July31<-K600Compare[c(21:30),]
Aug6<-K600Compare[c(31:40),]
Aug12<-K600Compare[c(41:50),]

July18K<-data.frame(x=July18$Raymond.K,y=July18$Effective.K)
July25K<-data.frame(x=July25$Raymond.K,y=July25$Effective.K)
July31K<-data.frame(x=July31$Raymond.K,y=July31$Effective.K)
Aug6K<-data.frame(x=Aug6$Raymond.K,y=Aug6$Effective.K)
Aug12K<-data.frame(x=Aug12$Raymond.K,y=Aug12$Effective.K)
OnetoOneK<-data.frame(x=OnetoOne$Raymond.K,y=OnetoOne$Effective.K)

Plot<-ggplot(July18K,aes(x,y),log="y",log="x",colour="red")+
  geom_point(colour="Red",shape=19,size=2)+
  geom_point(data = July25K,colour="Orange",shape=19,size=2)+
  geom_point(data = July31K,colour="Yellow",shape=19,size=2)+
  geom_point(data = Aug6K,colour="Green",shape=19,size=2)+
  geom_point(data = Aug12K,colour="Blue",shape=19,size=2)+
  geom_smooth(data = Aug12K,method = "lm",colour="Blue")+
  geom_point(data = OnetoOne,colour="Purple",shape=19,size=2)+
  geom_smooth(data = OnetoOne,method = "lm",colour="Purple")+
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  ylab("Effective K600 (m/day)")+
  xlab("Kinematic K600 (m/day)")+
  theme(axis.title.x = element_text(face = "bold",size = 15),
        axis.title.y = element_text(face = "bold",size =15),
        axis.text.x = element_text(face="bold",size = 10),
        axis.text.y=element_text(face="bold",size = 10),
        axis.line = element_line(colour = "black"),
        panel.border = element_rect(colour = "black", fill=NA, size=3))

Plot

##Regression Lines
geom_smooth(data = July25K,method = "lm",colour="Orange")+
  geom_smooth(data = July31K,method = "lm",colour="Yellow")+
  geom_smooth(data = Aug6K,method = "lm",colour="Green")+
  geom_smooth(data = Aug12K,method = "lm",colour="Blue")+
  geom_smooth(data = OnetoOne,method = "lm",colour="Purple")+
  geom_smooth(method = "lm", fill = NA,colour="red")+



