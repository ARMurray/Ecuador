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
Station<-read.csv("C:/Users/14434/Desktop/Ecuador/FieldData/Quick CO2 Comparison/StationViasalaData_adjusted_2020-01-08.csv")
Station$DateTime <- as.POSIXct(Station$DateTime, format="%m/%d/%Y %H:%M", tz="UTC")

##Making July 18th Station Table
July18HH<-Handheld[(1:36),]
July18S<-Station[seq(2373,2465,4),]
July18S2<-Station[seq(2470,2527,5),]
July18Total<-rbind(July18S,July18S2)


July18V4<-data.frame(July18Total[1:9,c(6)])
July18V3<-data.frame(July18Total[10:18,c(5)])
July18V2<-data.frame(July18Total[19:27,c(4)])
July18V1<-data.frame(July18Total[28:36,c(3)])
colnames(July18V4)<-c("CO2")
colnames(July18V3)<-c("CO2")
colnames(July18V2)<-c("CO2")
colnames(July18V1)<-c("CO2")
July18SB<-data.frame(rbind(July18V4,July18V3,July18V2,July18V1))
July18F<-cbind(July18HH,July18SB)
write.csv(July18F,"C:/Users/14434/Desktop/Ecuador/FieldData/Quick CO2 Comparison/July18 Final.csv", col.names = TRUE, row.names = FALSE)                


##Making July 29th Station Table
July29HH<-Handheld[(73:103),]
July25S<-Station[seq()]

#Storing Date Time Script
July18STrial<- subset(Station, 
              DateTime > as.POSIXct('2019-07-18 10:50:00', tz="UTC") &
                DateTime < as.POSIXct('2019-07-18 17:25:00', tz="UTC"))

