library(tidyverse)
library(dplyr)
library(pracma)
library(ggplot2)

##Reading Water Level Data for Temp
WaterLevel<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/FieldData/LevelLogger/WaterLevel_All.csv")
Station1Level<-WaterLevel[c(1:6,10212:13379),]
Station3Level<-WaterLevel[c(1:6,1:3167),]

#July 18 Temp-7.220821 Degrees Celsius
#July 25 Temp-6.58433 Degrees Celsius
#July 31 Temp- 5.209219 Degrees Celsius
#August 6 Temp- 5.837657 D                      egrees Celsius
#Aug 12 Temp- 6.707708 Degrees Celsius
##Kh CO2 at SATP= .0336Mol/L*atm SATP=298.15 K=2400

HenrysConstant<-data.frame(7.220821,6.58433,5.209219,5.837657,6.707708,row.names = "Avg. Temp. (C)")
names(HenrysConstant)<-c("July 18","July 25", "July 31","Aug 6","Aug 12")

#New Data Frame with Kelvin Temp
KelvinTemp<-data.frame(280.37,279.73,278.36,278.99,279.86,row.names = "KelvinTemp")
names(KelvinTemp)<-names(HenrysConstant)
HenrysConstant<-rbind(HenrysConstant,KelvinTemp)

##Reciprocal of Kelvin Temp
Reciprocal<-data.frame(1/KelvinTemp, row.names = "Reciprocal")
names(Reciprocal)<-names(HenrysConstant)
HenrysConstant<-rbind(HenrysConstant,Reciprocal)

#Subtracting 1/Temp at SATP from Field Values
Difference<-data.frame(Reciprocal-(1/298.15), row.names = "Difference")
names(Difference)<-names(HenrysConstant)
HenrysConstant<-rbind(HenrysConstant,Difference)

#Multiplying by 2400 for Constant of Temperature Dependence Due to Enthalpy
Constant<-data.frame(-2400*Difference,row.names = "Constant")
names(Constant)<-names(HenrysConstant)
HenrysConstant<-rbind(HenrysConstant,Constant)

#Raising the Constant to Exponent
Exponent<-data.frame(exp(Constant),row.names = "Exponent")
names(Exponent)<-names(HenrysConstant)
HenrysConstant<-rbind(HenrysConstant,Exponent)
                                                                                                                                                                                 
#Multiplying by Kh at SATP
Kh<-data.frame(.0336*Exponent,row.names = "Kh (mol/L*atm)")
names(Kh)<-names(HenrysConstant)
HenrysConstant<-rbind(HenrysConstant,Kh)

Khm3<-data.frame(Kh*1000,row.names = "Kh (mol/m^3*atm)")
names(Khm3)<-names(HenrysConstant)
HenrysConstant<-rbind(HenrysConstant,Khm3)
      
write.csv(HenrysConstant,file = "C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Henry's Constant.csv", row.names = TRUE,col.names = TRUE)
#Removing Bad Rows
HenrysConstant<-HenrysConstant[-c(3),]

##https://www.ready.noaa.gov/documents/TutorialX/files/Chem_henry.pdf
