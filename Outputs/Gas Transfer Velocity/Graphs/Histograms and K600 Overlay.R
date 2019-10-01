library(ggplot2)
library(tidyverse)
library(pracma)

##Histograms of Raymond Paper Method
Syn1<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Raymond Method Total.csv")
axis<-axis(side = 1,at=seq(0,10000,by=1000), labels=TRUE)
breaks<-seq(0,10000, by=200)
Plot<-hist(Syn1$K600.Mid,breaks,main = "Histogram of K600 Raymond Method 08_12", xlab = "K600 (m/Day)", ylim = c(0,20) ,col = "blue",freq = TRUE)
lines(frequency(Syn1$K600.Avg..by.Dist.))

##Overlaying K600 Graphs By Color
Syn<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Raymond Method Total.csv")
Plot<-ggplot(Syn,aes(Syn$Dist..From.Upstream))+ 
  geom_point(aes(y=Syn$X18.Jul), colour= "Blue1")+  
  geom_point(aes(y=Syn$X25.Jul),colour="Red")+ 
  geom_point(aes(y=Syn$X31.Jul), color= "Green")+
  geom_point(aes(y=Syn$X6.Aug), color="orange")+ 
  geom_point(aes(y=Syn$Aug.12), color="cadetblue2")+
  scale_color_manual("",
                     breaks= c("Syn1","Syn2", "Syn3", "Syn4", "Syn5"),
                     values = c("Syn1"="Blue 1","Syn2"="Red","Syn3"="Green","Syn4"="orange","Syn5"="cadetblue2"))+
  xlab("Position (m) ") +
  scale_y_continuous("K600 (m/Day)", limits = c(0,25000)) + 
  labs(title="Overlay of All Synoptic Days")

Plot

