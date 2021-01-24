#Compare Vaisala PPM from Handheld and Station

#Problem- No time stamps on Vaisala handheld

#Goals- Match similar time stamps from Vaisala handheld to station.
#Find validity within each measurement. 
#Plot points in different colors
#Difference between each point for percent error

#Assumptions- Each day started when the EosFD at station 2 was reset/ removed. This caused an irregular time stamp in the eosFD data.
#July 18th began at 10:56 am. Ended at 4:00PM. July 25th began at 11:45 am. Ended at 4:00PM
#July 29th began at 11am.  July 31st began at 11am. Ended at unknown. 
#August 6th began at 11:30. Ended 3:00P.M. August 12th began at 11am. Ended at 2pm
#Station 4= Syn 1-9; Station 3= Syn 10-18; Station 2= Syn 19-27; Station 1= Syn 28-35

library(tidyverse)
library(pracma)
library(dplyr)
library(ggplot2)
library(plotly)

#Opening Handheld Vaisala Data
Handheld<-read.csv("C:/Users/14434/Desktop/Ecuador/FieldData/Quick CO2 Comparison/synoptic.Viasala_2021-01-08.csv")
Station<-read.csv("C:/Users/14434/Desktop/Ecuador/FieldData/Quick CO2 Comparison/All_Stream_Data_forCalibration.csv")

Station$DateTime <- as.POSIXct(Station$DateTime, format="%m/%d/%Y %H:%M", tz="UTC")

##Making July 18th Station Table
July18HH<-Handheld[(1:36),]
July18S<-Station[seq(3388,3436,4),]
July18S2<-Station[seq(3443,3483,4),]
July18s3<-Station[seq(3488,3543,5),]
July18Total<-rbind(July18S,July18S2,July18s3)


July18V4<-data.frame(July18Total[1:9,c(6)])
July18v4A<-data.frame(July18Total[1:9,c(9)])
July18V3<-data.frame(July18Total[10:18,c(5)])
July18v3A<-data.frame(July18Total[10:18,c(8)])
July18V2<-data.frame(July18Total[19:27,c(4)])
July18v2A<-data.frame(July18Total[19:27,c(10)])
July18V1<-data.frame(July18Total[28:36,c(3)])
July18v1A<-data.frame(July18Total[28:36,c(7)])

colnames(July18V4)<-c("CO2")
colnames(July18V3)<-c("CO2")
colnames(July18V2)<-c("CO2")
colnames(July18V1)<-c("CO2")
colnames(July18v1A)<-c("CO2A")
colnames(July18v2A)<-c("CO2A")
colnames(July18v3A)<-c("CO2A")
colnames(July18v4A)<-c("CO2A")
July18SB<-data.frame(rbind(July18V4,July18V3,July18V2,July18V1))
July18SBA<-data.frame(rbind(July18v1A,July18v2A,July18v3A,July18v4A))
July18F<-cbind(July18HH,July18SB,July18SBA)
July18F$Error<-((July18F$CO2-July18F$CO2_ppm)/July18F$CO2)
July18F$ErrorA<-((July18F$CO2A-July18F$CO2_ppm)/July18F$CO2A)
write.csv(July18F,"C:/Users/14434/Desktop/Ecuador/FieldData/Quick CO2 Comparison/July18 Final.csv", col.names = TRUE, row.names = FALSE)                

Plot<-ggplot()+ geom_point(data=July18F, aes(x=dist.m,y=CO2_ppm),shape=2, color="green")+
  geom_point(data=July18F, aes(x=dist.m, y=CO2), shape= 4, color="red")+
  geom_point(data=July18F, aes(x=dist.m,y=CO2A), shape=7, color="Blue")+
  xlab("Distance")+
  ylab("CO2 PPM")+
  ggtitle("July 18th\nCO2 Comparisons")+
  scale_fill_discrete(name="CO2 Comparisons", labels=c("Handheld","Station"))

  
Plot
##Making July 29th Station Table
July25HH<-Handheld[(37:72),]
July25S<-Station[seq(7074,7214,4),]

July25V4<-data.frame(July25S[1:9,c(6)])
July25v4A<-data.frame(July25S[1:9,c(9)])
July25V3<-data.frame(July25S[10:18,c(5)])
July25v3A<-data.frame(July25S[10:18,c(8)])
July25V1<-data.frame(July25S[19:36,c(3)])
July25v1A<-data.frame(July25S[19:36,c(7)])

colnames(July25V4)<-c("CO2")
colnames(July25V3)<-c("CO2")
colnames(July25V2)<-c("CO2")
colnames(July25V1)<-c("CO2")
colnames(July25v1A)<-c("CO2A")
colnames(July25v2A)<-c("CO2A")
colnames(July25v3A)<-c("CO2A")
colnames(July25v4A)<-c("CO2A")
July25SB<-data.frame(rbind(July25V4,July25V3,July25V2,July25V1))
July25SBA<-data.frame(rbind(July25v1A,July25v2A,July25v3A,July25v4A))
July25F<-cbind(July25HH,July25SB,July25SBA)
July25F$Error<-((July25F$CO2-July25F$CO2_ppm)/July25F$CO2)
July25F$ErrorA<-((July25F$CO2A-July25F$CO2_ppm)/July25F$CO2A)
write.csv(July25F,"C:/Users/14434/Desktop/Ecuador/FieldData/Quick CO2 Comparison/July25 Final.csv", col.names = TRUE, row.names = FALSE)                


#Storing Date Time Script
July18STrial<- subset(Station, 
              DateTime > as.POSIXct('2019-07-18 10:50:00', tz="UTC") &
                DateTime < as.POSIXct('2019-07-18 17:25:00', tz="UTC"))

