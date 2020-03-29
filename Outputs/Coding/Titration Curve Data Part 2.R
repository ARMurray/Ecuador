library(tidyverse)
library(pracma)
library(ggplot2)
library(here)

#Vaisala Data Upload and Subset July 16
Vaisala<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/data_4_analysis/Vaisala_Stations_AllData.csv", header= TRUE)
V4<-Vaisala[c(7966:8172),c(1:4)]

#Creating Time Lapse column
V3$TimeLapse<-as.integer(rownames(V3))-7966
V3$TimeLapseSec<-V3$TimeLapse*60

#Creating Moles and Volume of CO2 Columns
V3$Moles<-V3$PPM*V3$TimeLapseSec*.0018*.0462/44.01
V3$mL<-V3$PPM*V3$TimeLapseSec*.0018*.0462/.001977
write.csv(V3,here("Outputs/Titration Curve/CO2PPM 07_22.csv"))
V3$Join<-paste0(V3$TimeLapse,V3$TimeLapseSec)

#Uploading pH Data
pH<-read.csv("C:/Users/nehemiah/Documents/CarbonShed Lab/pH Data/pH Data7_22_19.csv")
pH$TimeLapse<-as.integer(rownames(pH))-1
pH$TimeLapseSec<-pH$TimeLapse*60
write.csv(pH,here("Outputs/Titration Curve/pH07_22.csv"))

#Create data Frame combining Vaisala data and pH data by Time
Merge<-merge(V2,pH,by.x="Join",by.y="Serial")
Combine<-merge(V2,pH, TimeLapseSec= TRUE)
write.csv(Combine,here("Outputs/Titration Curve/pH and CO2 7_22_19.csv"))

#Plotting
Plot<-ggplot()+geom_line(aes(x=Combine$Moles,y=Combine$pH))
Plot

#Making Date and Time recognized by R as Time with as.posixct function
YSIsub$DateTime<-as.POSIXct(as.character(YSIsub$DateTime),format= "%m/%d/%Y %H:%M")
pH<-YSIsub$pH
V3sub$pH<-pH

#Making Date and Time one column and recognized by R using as.poxict, as.character, and as.paste0
V3$DateTime<-as.POSIXct(paste0(as.character(V3$Date), " ", as.character(V3$Time)), format= "%m/%d/%Y %H:%M:%OS")
V3sub<-V3[192:2892,]
##TRYV3<-row_number(V3[192:2892], n=24)

#Calculating PPM and Moles of CO2 and adding to V3sub
PPM<-V3sub$Volts*10000
view(PPM)
V3sub$PPM<-PPM
TimeLapse<-seq(from=0, to= 13500, by=5)
V3sub$TimeLapse<-TimeLapse
MicroMoles<-V3sub$PPM*.000000896*V3sub$TimeLapse
V3sub$Moles<-Moles

#Separating V3 into Needed rows
list<- seq(1,nrow(V3sub),26)
V3needed<-V3sub[list,]
V3needed$pH<-pH

plot<-ggplot(aes(x=Moles,y=pH))
