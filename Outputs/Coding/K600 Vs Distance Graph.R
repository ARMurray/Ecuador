library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)
library(scales)

##Uploading K600 Total
K600Total<-read.csv("C:/Users/14434/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Raymond Method/Raymond Method Total.csv")

Jul18K<-data.frame(x=Distance,y=K600Total$X18.Jul)
Distance<-K600Total$Dist..From.Upstream
Jul25K<-data.frame(x=Distance,y=K600Total$X25.Jul)
Jul31K<-data.frame(x=Distance,y=K600Total$X31.Jul)
Aug6K<-data.frame(x=Distance,y=K600Total$X6.Aug)
Aug12K<-data.frame(x=Distance,y=K600Total$X12.Aug)


Plot<-ggplot(Jul18K,aes(x,y),log="y",colour="Red")+
  geom_point(colour="Red",shape=19,size=2)+
  geom_point(data = Jul25K,colour="Orange",shape=19,size=2)+
  geom_point(data = Jul31K,colour="Yellow",shape=19,size=2)+
  geom_point(data = Aug6K,colour="Green",shape=19,size=2)+
  geom_point(data = Aug12K,colour="Blue",shape=19,size=2)+
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  ylab("K600 (m/day)")+
  xlab("Distance from Wetland")+
  theme(axis.title.x = element_text(face = "bold",size = 15),
        axis.title.y = element_text(face = "bold",size =15),
        axis.text.x = element_text(face="bold",size = 10),
        axis.text.y=element_text(face="bold",size = 10),
        axis.line = element_line(colour = "black"),
        panel.border = element_rect(colour = "black", fill=NA, size=3)+
          scale_fill_manual(values = c("red","orange","yellow","green","blue"),
                            name="Synoptic\nDay",
                            breaks = c("Jul18K","Jul25K","Jul31K","Aug6K","Aug12K"),
                            labels=c("July 18","July 25","July 31","Aug 6", "Aug 12")))  

Plot
##Code to add Log Y axis
scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
              labels = trans_format("log10", math_format(10^.x)))+

##Failed Code to Add legend and Border around Graph 
theme(panel.border = element_rect(linetype = "Solid",fill = NA,size = 5))+
  scale_fill_discrete(name="Synoptic Date",
                      breaks=c("July18","July25","July31","Aug 6","Aug 12"),
                      values=c("Red","Orange","Yellow","Green","Blue"),
                      labels=c("July 18","July 25","July 31","Aug 6","Aug 12"))


panel.background = element_blank(),
panel.grid.major = element_blank(), 
panel.grid.minor = element_blank(),
axis.line = element_line(colour = "black"),
panel.border = element_rect(colour = "black", fill=NA, size=5)
ggplot(A,aes(x,y)) +geom_point() +geom_point(data=B,colour='red') + xlim(0, 10) 

