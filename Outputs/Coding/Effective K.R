library(tidyverse)
library(dplyr)
library(pracma)

##Organizing Flux
TotalFlux<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/FieldData/EosFD/All_Synoptic_Flux_Data.csv")
Jul18Flux<-TotalFlux[c(1:5)]
Jul25Flux<-TotalFlux[c(7:11)]
Jul31Flux<-TotalFlux[c(13:17)]
Aug6Flux<-TotalFlux[c(19:23)]
Aug12Flux<-TotalFlux[c(26:31)]

mean(Aug12Flux$Flux[1:4])
mean(Aug12Flux$Flux[5:8])
mean(Aug12Flux$Flux[9:12])
mean(Aug12Flux$Flux[13:16])
mean(Aug12Flux$Flux[17:20])
mean(Aug12Flux$Flux[21:24])
mean(Aug12Flux$Flux[25:28])
mean(Aug12Flux$Flux[29:32])
mean(Aug12Flux$Flux.4[33:36])
mean(Aug12Flux$Flux.4[37:39])

##Table of Flux
KCalc<-data.frame(.6025,.36,.455,.93,.1525,.7575,4.88,4.6575,1.195,3.35, row.names = "Flux(umoles/m^2*s)")
names(KCalc)<-c("Syn 1","Syn 5","Syn 8", "Syn 11", "Syn 14", "Syn Waterfall", "Syn 20", "Syn 23", "Syn 29","Syn 35")

KCalc25<-data.frame(.805,.4725,.4875,.32,2.1425,1.2025,4.345,5.045,row.names = "Flux(umol/m^2*s)")
names(KCalc25)<-c("Syn 1","Syn 5","Syn 10","Syn 14","Syn Waterfall","Syn 23","Syn 29","Syn 35")

KCalc31<-data.frame(.3225,.6525,.8125,.265,.18,.2925,3.5825,7.9125,9.7925,10.225,row.names = "Flux (umol/m^2*s)")
names(KCalc31)<-c("Syn 1","Syn 5","Syn 8","Syn 11","Syn 14","Syn Waterfall","Syn 20","Syn 23","Syn 29","Syn 35")

KCalc6<-data.frame(.665,.4425,.74,.835,.06,.565,4.2875,5.975,1.9775,5.2775,row.names = "Flux(umol/m^2*s)")
names(KCalc6)<-c("Syn 1","Syn 5","Syn 8","Syn 11","Syn 14","Syn Waterfall","Syn 20","Syn 23","Syn 29","Syn 35")

KCalc12<-data.frame(.8575,2.115,.4525,1.755,.3625,.475,4.7875,11.04,4.3925,5.64667,row.names = "Flux(umol/m^2*s)")
names(KCalc12)<-c("Syn 1","Syn 5","Syn 8","Syn 11","Syn 14","Syn Waterfall","Syn 20","Syn 23","Syn 29","Syn 35")

##Changing Flux to Units of moles/(m^2*Day)
FluxU<-data.frame(KCalc*.0864,row.names = "Flux(moles/m^2*Day)")
names(FluxU)<-names(KCalc)
KCalc<-rbind(KCalc,FluxU)

FluxU25<-data.frame(KCalc25*.0864,row.names = "Flux(moles/M^2*Day)")
names(FluxU25)<-names(KCalc25)
KCalc25<-rbind(KCalc25,FluxU25)

FluxU31<-data.frame(KCalc31*.0864,row.names= "Flux(moles/m^2*Day)")
names(FluxU31)<-names(KCalc31)
KCalc31<-rbind(KCalc31,FluxU31)

FluxU6<-data.frame(KCalc6*.0864,row.names = "Flux(moles/m^2*Day)")
names(FluxU6)<-names(KCalc6)
KCalc6<-rbind(KCalc6,FluxU6)

FluxU12<-data.frame(KCalc12*.0864,row.names = "Flux(moles/m^2*Day)")
names(FluxU12)<-names(KCalc12)
KCalc12<-rbind(KCalc12,FluxU12)

##Adding pCo2 aq - pCO2 air Data
Pressure<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/July 18 pCO2 aq and Air.csv")

Pressure<-data.frame(.00007887550,.00006674081,.00009707754,.00003640408,.00001213469,.00006067346,.0003579734,.0005642632,.001043584,.001013247,row.names = "pCO2(aq)-pCO2(air)")
names(Pressure)<-names(KCalc)
KCalc<-rbind(KCalc,Pressure)

Pressure<-data.frame("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Effective K/July 25 pCO2 aq and Air.csv")

Pressure25<-data.frame(.0000425,.00007893,.00006071190,.00009714,.00012142,.000004675,.00058891,.00060105, row.names = "pCO2(aq)-pCO2(air) (atm)")
names(Pressure25)<-names(KCalc25)
KCalc25<-rbind(KCalc25,Pressure25)

Pressure31<-data.frame(.0001032,.0001214,.00007895,.00009717,.00009717,.0002247,.0005285,.0008745,.001409,.001427,row.names = "pCO2(aq)-pCO2(air) (atm)")
names(Pressure31)<-names(KCalc31)
KCalc31<-rbind(KCalc31,Pressure31)

Pressure6<-data.frame(.000030466,.00018889,.000067024,.00010968,.00009799,.0002011,.00038996,.0006763,.0012491,.001347,row.names = "pCO2(aq)-pCO2(air) (atm)")
names(Pressure6)<-names(KCalc6)
KCalc6<-rbind(KCalc6,Pressure6)

Pressure12<-data.frame(.0001823,.0001823,.000200511,.0001641,.0001397,.0002795,.0005589,.0009296,.001914,.002017,row.names = "pCO2(aq)-pCO2(air) (atm)")
names(Pressure12)<-names(KCalc12)
KCalc12<-rbind(KCalc12,Pressure12)

#Adding Henry's Constant
Henrys<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Effective K/Henry's Constant.csv")

HenrysC<-data.frame(20.167,20.167,20.167,20.167,20.167,20.167,20.167,20.167,20.167,20.167,row.names = "Kh (mol/m^3*atm)")
names(HenrysC)<-names(KCalc)
KCalc<-rbind(KCalc,HenrysC)

HenrysC25<-data.frame(19.7758926871448,19.7758926871448,19.7758926871448,19.7758926871448,19.7758926871448,19.7758926871448,19.7758926871448,19.7758926871448,row.names = "Kh (mol/m^3*atm)")
names(HenrysC25)<-names(KCalc25)
KCalc25<-rbind(KCalc25,HenrysC25)

HenrysC31<-data.frame(18.9582097937561,18.9582097937561,18.9582097937561,18.9582097937561,18.9582097937561,18.9582097937561,18.9582097937561,18.9582097937561,18.9582097937561,18.9582097937561,row.names = "Kh (mol/m^3*atm)")
names(HenrysC31)<-names(KCalc31)
KCalc31<-rbind(KCalc31,HenrysC31)

HenrysC6<-data.frame(19.3309345795479,19.3309345795479,19.3309345795479,19.3309345795479,19.3309345795479,19.3309345795479,19.3309345795479,19.3309345795479,19.3309345795479,19.3309345795479,row.names = "Kh (mol/m^3*atm)")
names(HenrysC6)<-names(KCalc6)
KCalc6<-rbind(KCalc6,HenrysC6)

HenrysC12<-data.frame(19.8548653036569,19.8548653036569,19.8548653036569,19.8548653036569,19.8548653036569,19.8548653036569,19.8548653036569,19.8548653036569,19.8548653036569,19.8548653036569,row.names = "Kh (mol/m^3*atm)")
names(HenrysC12)<-names(KCalc12)
KCalc12<-rbind(KCalc12,HenrysC12)

##Multiplying kH times Pressure Difference to get Slope of Effective K 
Slope<-data.frame(HenrysC*Pressure,row.names = "Slope (mol/m^3)")
names(Slope)<-names(KCalc)
KCalc<-rbind(KCalc,Slope)

Slope25<-data.frame(HenrysC25*Pressure25,row.names = "Slope (mol/ m^3)")
names(Slope25)<-names(KCalc25)
KCalc25<-rbind(KCalc25,Slope25)

Slope31<-data.frame(HenrysC31*Pressure31,row.names = "Slope (mol/m^3)")
names(Slope31)<-names(KCalc31)
KCalc31<-rbind(KCalc31,Slope31)

Slope6<-data.frame(HenrysC6*Pressure6,row.names = "Slope (mol/m^3)")
names(Slope6)<-names(KCalc6)
KCalc6<-rbind(KCalc6,Slope6)

Slope12<-data.frame(HenrysC12*Pressure12,row.names = "Slope (mol/m^3)")
names(Slope12)<-names(KCalc12)
KCalc12<<-rbind(KCalc12,Slope12)

##Dividing Flux by Slope to get KCO2
KCO2<-data.frame(FluxU/Slope,row.names = "KCO2 (m/Day)")
names(KCO2)<-names(KCalc)
KCalc<-rbind(KCalc,KCO2)

KCO225<-data.frame(FluxU25/Slope25,row.names = "KCO2 (m/Day)")
names(KCO225)<-names(KCalc25)
KCalc25<-rbind(KCalc25,KCO225)

KCO231<-data.frame(FluxU31/Slope31,row.names = "KCO2 (m/Day)")
names(KCO231)<-names(KCalc31)
KCalc31<-rbind(KCalc31,KCO231)

KCO26<-data.frame(FluxU6/Slope6,row.names = "KCO2 (m/Day)")
names(KCO26)<-names(KCalc6)
KCalc6<-rbind(KCalc6,KCO26)

KCO212<-data.frame(FluxU12/Slope12,row.names = "KCO2 (m/Day)")
names(KCO212)<-names(KCalc12)
KCalc12<-rbind(KCalc12,KCO212)

#Correcting KCO2 to Schmidt Number of 600
##Hydrochemistry and Dissolved Inorganic Carbon (DIC) Cycling in a Tropical Agricultural River, Mun River Basin, Northeast Thailand

K600<-data.frame(KCO2*.6764420832, row.names = "K600 (m/Day)")
names(K600)<-names(KCalc)
KCalc<-rbind(KCalc,K600)

K60025<-data.frame(KCO225*.6764420832,row.names = "K600 (m/Day)")
names(K60025)<-names(KCalc25)
KCalc25<-rbind(KCalc25,K60025)

K60031<-data.frame(KCO231*.6764420832,row.names = "K600 (m/Day)")
names(K60031)<-names(KCalc31)
KCalc31<-rbind(KCalc31,K60031)

K6006<-data.frame(KCO26*.6764420832,row.names = "K600 (m/Day)")
names(K6006)<-names(KCalc6)
KCalc6<-rbind(KCalc6,K6006)

K60012<-data.frame(KCO212*.6764420832,row.names = "K600 (m/Day)")
names(K60012)<-names(KCalc12)
KCalc12<-rbind(KCalc12,K60012)

write.csv(KCalc,"C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Effective K/July 18 K600.csv")
write.csv(KCalc12,"C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Effective K/Aug 12 K600.csv", row.names = TRUE,col.names = TRUE)
