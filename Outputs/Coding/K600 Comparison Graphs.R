library(tidyverse)
library(ggplot2)
library(dplyr)
library(pracma)
library(plotly)
library(scales)
library(plotly)
library(here)
library(ggpubr)

##Opening K600 Comparison Document
K600Compare<-read.csv(here("Outputs/Gas Transfer Velocity/Effective K/Kinematic K Versus Effective K.csv"))

##Creating One to One Point
OnetoOne<-data.frame('x'=c(1,100),'y'=c(1,100))

##Separating K600 Comparison Document By Days
July18<-K600Compare[c(1:10),]
July25<-K600Compare[c(11:18),]
July31<-K600Compare[c(19:28),]
Aug6<-K600Compare[c(29:38),]
Aug12<-K600Compare[c(39:48),]

##Creating Data Frames for Each Individual Day
July18K<-data.frame(x=July18$Kkin,y=July18$Keff)
July25K<-data.frame(x=July25$Kkin,y=July25$Keff)
July31K<-data.frame(x=July31$Kkin,y=July31$Keff)
Aug6K<-data.frame(x=Aug6$Kkin,y=Aug6$Keff)
Aug12K<-data.frame(x=Aug12$Kkin,y=Aug12$Keff)

Jul18<-ggplot(July18K,aes(x,y),log="y",log="x",colour="red")+
  geom_point(colour="Red",shape=19,size=2)+
  geom_smooth(data = July18K,method = "lm",colour="Red")+
  geom_point(data = July25K,colour="Orange",shape=19,size=2)+
  geom_point(data = July31K,colour="Yellow",shape=19,size=2)+
  geom_point(data = Aug6K,colour="Green",shape=19,size=2)+
  geom_point(data = Aug12K,colour="Blue",shape=19,size=2)+
  geom_point(data = OnetoOne,colour="Purple",shape=19,size=2)+
  geom_smooth(data = OnetoOne,method = "lm",colour="Purple")+
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  scale_color_manual(values=c("18-Jul"="red","25-Jul"="orange","31-Jul"="yellow",
                              "6-Aug"="green","12-Aug"="blue"),
                     name = bquote('Discharge'~m^3~s^-1),
                     labels=c(".02283-Jul 18",".00702-Jul 25",".00418-Jul 31",".00251-Aug 6",".00851-Aug 12"))+
  ylab("Effective K600 (m/day)")+
  xlab("Kinematic K600 (m/day)")+
  theme(axis.title.x = element_text(face = "bold",size = 15),
        axis.title.y = element_text(face = "bold",size =15),
        axis.text.x = element_text(face="bold",size = 10),
        axis.text.y=element_text(face="bold",size = 10),
        axis.line = element_line(colour = "black"),
        panel.border = element_rect(colour = "black", fill=NA, size=3))

Jul31<-ggplot(July18K,aes(x,y),log="y",log="x",colour="red")+
  geom_point(colour="Red",shape=19,size=2)+
  geom_point(data = July25K,colour="Orange",shape=19,size=2)+
  geom_point(data = July31K,colour="Yellow",shape=19,size=2)+
  geom_smooth(data = July31K,method = "lm",colour="Yellow")+
  geom_point(data = Aug6K,colour="Green",shape=19,size=2)+
  geom_point(data = Aug12K,colour="Blue",shape=19,size=2)+
  geom_point(data = OnetoOne,colour="Purple",shape=19,size=2)+
  geom_smooth(data = OnetoOne,method = "lm",colour="Purple")+
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  scale_color_manual(values=c("18-Jul"="red","25-Jul"="orange","31-Jul"="yellow",
                              "6-Aug"="green","12-Aug"="blue"),
                     name = bquote('Discharge'~m^3~s^-1),
                     labels=c(".02283-Jul 18",".00702-Jul 25",".00418-Jul 31",".00251-Aug 6",".00851-Aug 12"))+
  ylab("Effective K600 (m/day)")+
  xlab("Kinematic K600 (m/day)")+
  theme(axis.title.x = element_text(face = "bold",size = 15),
        axis.title.y = element_text(face = "bold",size =15),
        axis.text.x = element_text(face="bold",size = 10),
        axis.text.y=element_text(face="bold",size = 10),
        axis.line = element_line(colour = "black"),
        panel.border = element_rect(colour = "black", fill=NA, size=3))

August6<-ggplot(July18K,aes(x,y),log="y",log="x",colour="red")+
  geom_point(colour="Red",shape=19,size=2)+
  geom_point(data = July25K,colour="Orange",shape=19,size=2)+
  geom_point(data = July31K,colour="Yellow",shape=19,size=2)+
  geom_point(data = Aug6K,colour="Green",shape=19,size=2)+
  geom_smooth(data = Aug6K,method = "lm",colour="Green")+
  geom_point(data = Aug12K,colour="Blue",shape=19,size=2)+
  geom_point(data = OnetoOne,colour="Purple",shape=19,size=2)+
  geom_smooth(data = OnetoOne,method = "lm",colour="Purple")+
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  scale_color_manual(values=c("18-Jul"="red","25-Jul"="orange","31-Jul"="yellow",
                              "6-Aug"="green","12-Aug"="blue"),
                     name = bquote('Discharge'~m^3~s^-1),
                     labels=c(".02283-Jul 18",".00702-Jul 25",".00418-Jul 31",".00251-Aug 6",".00851-Aug 12"))+
  ylab("Effective K600 (m/day)")+
  xlab("Kinematic K600 (m/day)")+
  theme(axis.title.x = element_text(face = "bold",size = 15),
        axis.title.y = element_text(face = "bold",size =15),
        axis.text.x = element_text(face="bold",size = 10),
        axis.text.y=element_text(face="bold",size = 10),
        axis.line = element_line(colour = "black"),
        panel.border = element_rect(colour = "black", fill=NA, size=3))


SynEff<-read.csv(here("Outputs/Gas Transfer Velocity/Effective K/Kinematic K Versus Effective K.csv"))

colnames(SynEff)<-c("Date","Synoptic","Distance (m)","KKin","KEff")

Total<-ggplot(SynEff)+
  geom_point(aes(x=KKin,y=KEff,color=Date),shape=19,size=2)+
  geom_smooth(data = SynEff,aes(x=KKin,y=KEff,color=Date),method = "lm")+
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  scale_color_manual(values=c("18-Jul"="red","25-Jul"="orange","31-Jul"="yellow",
                              "6-Aug"="green","12-Aug"="blue"),
                     name = bquote('Discharge'~m^3~s^-1),
                     labels=c(".02283-Jul 18",".00702-Jul 25",".00418-Jul 31",".00251-Aug 6",".00851-Aug 12"))+
  labs(x= bquote('K600 Kinematic'~m~d^-1),
       y= bquote('K600 Effective'~m~d^-1))+
  theme(axis.title.x = element_text(face = "bold",size = 15),
        axis.title.y = element_text(face = "bold",size = 15),
        axis.line = element_line(colour = "black"),
        panel.border = element_rect(colour = "black",fill = NA,size = 3))

##Combining Graphs
tiff(here("Final_Figures/Nehemiah/K600_Comparisons.tiff"), width = 7, height = 6, units = 'in', res = 600)
ggarrange(Total,Jul18,Jul31,August6,
                   labels=c("Total","July 18","July 31","Aug 6"),
          label.x = .15,label.y = .95,
          common.legend=TRUE,legend="bottom",
                   ncol=2,nrow=2)
dev.off()


##Regression Lines
geom_smooth(data = July25K,method = "lm",colour="Orange")+
  geom_smooth(data = July31K,method = "lm",colour="Yellow")+
  geom_smooth(data = Aug6K,method = "lm",colour="Green")+
  geom_smooth(data = Aug12K,method = "lm",colour="Blue")+
  geom_smooth(data = OnetoOne,method = "lm",colour="Purple")+
  geom_smooth(method = "lm", fill = NA,colour="red")
