library(tidyverse)
library(pracma)
library(dplyr)
library(ggplot2)

##Organizing BaroLogger
BaroLogger<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Effective K/BaroLogger Total.csv")
Jul18Baro<-BaroLogger[529:625,]
Jul25Baro<-BaroLogger[1201:1297,]
Jul31Baro<-BaroLogger[1777:1872,]
Aug6Baro<-BaroLogger[2353:2448,]

mean(Jul18Baro$LEVEL)
mean(Jul25Baro$LEVEL)
mean(Jul31Baro$LEVEL)
mean(Aug6Baro$LEVEL)

#Organizing Relative Humidity
RelHumidity<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Effective K/M5025_Humedad del aire.csv")
Jul18Humid<-RelHumidity[409:432,]
Jul25Humid<-RelHumidity[577:600,]
Jul31Humid<-RelHumidity[721:744,]
Aug6Humid<-RelHumidity[865:888,]
Aug12Humid<-RelHumidity[1009:1032,]

mean(Jul18Humid$Valor)
mean(Jul25Humid$Valor)
mean(Jul31Humid$Valor)
mean(Aug6Humid$Valor)
mean(Aug12Humid$Valor)

#Starting pCO2 Table
pCO2<-data.frame(7.220821,6.58433,5.209219,5.837657,6.707708,row.names = "Avg. Temp. (C)")
names(pCO2)<-c("July 18","July 25","July 31","Aug 6","Aug 12")

#Convert Temp to Kelvin
KelvinTemp<-data.frame(280.37,279.73,278.36,278.99,279.86,row.names = "KelvinTemp")
names(KelvinTemp)<-names(pCO2)
pCO2<-rbind(pCO2,KelvinTemp)

#Add in Baro Logger Pressure
PressurekPa<-data.frame(62.47814,62.47629,62.42683,62.56439,62.5,row.names = "Air Pressure (kPa)")
names(PressurekPa)<-names(pCO2)
pCO2<-rbind(pCO2,PressurekPa)

#Convert Pressure to MicroAtm
Pressureuatm<-data.frame(PressurekPa*9869.23,row.names = "Air Pressure (uatm)")
names(Pressureuatm)<-names(pCO2)
pCO2<-rbind(pCO2,Pressureuatm)

Pressureatm<-data.frame(PressurekPa*.00986923,row.names = "Air Pressure (atm)")
names(Pressureatm)<-names(pCO2)
pCO2<-rbind(pCO2,Pressureatm)

#Add Saturation Pressure Using Online Calculator
##https://www.weather.gov/epz/wxcalc_vaporpressure
SatPressurembar<-data.frame(10.17,9.74,9.3,9.25,9.82,row.names = "Sat. Pressure (mbar)")
names(SatPressurembar)<-names(pCO2)
pCO2<-rbind(pCO2,SatPressurembar)

SatPressureatm<-data.frame(SatPressurembar*(1/1013.25),row.names = "Sat. Pressure (atm)")
names(SatPressureatm)<-names(pCO2)
pCO2<-rbind(pCO2,SatPressureatm)

SatPressureuatm<-data.frame(SatPressureatm*1000000,row.names = "Sat. Pressure (uatm)")
names(SatPressureuatm)<-names(pCO2)
pCO2<-rbind(pCO2,SatPressureuatm)

RelativeHum<-data.frame(.9840148,.9855653,.9579715,.8924373,.9520947,row.names = "Relative Humidity")
names(RelativeHum)<-names(pCO2)
pCO2<-rbind(pCO2,RelativeHum)

pH2Oatm<-data.frame(RelativeHum*SatPressureatm,row.names = "pH20 (atm)")
names(pH2Oatm)<-names(pCO2)
pCO2<-rbind(pCO2,pH2Oatm)


pH2ouatm<-data.frame(pH2Oatm*1000000,row.names = "pH2o (uatm)")
names(pH2ouatm)<-names(pCO2)
pCO2<-rbind(pCO2,pH2ouatm)

Differenceatm<-data.frame((Pressureatm)-(pH2Oatm),row.names = "pAir- pH2o (atm)")
names(Differenceatm)<-names(pCO2)
pCO2<-rbind(pCO2,Differenceatm)

Differenceuatm<-data.frame((Pressureuatm)-(pH2ouatm), row.names = "pAir- pH2o (uatm)")
names(Differenceuatm)<-names(pCO2)
pCO2<-rbind(pCO2,Differenceuatm)

write.csv(pCO2,"C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/PAir-pH2OUpdate.csv",row.names = TRUE,col.names = TRUE)

##Calculating pCO2
PPMCO2<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Effective K/PPM CO2 Synoptic Days.csv")

Jul18PPM<-data.frame(PPMCO2$Synoptic1_071819)
Jul18PPM$pCO2<-Jul18PPM*.6067346
Jul18PPM$pCO2atm<-Jul18PPM$pCO2*.000001
Jul18PPM$PPMAir<-PPMCO2$PPM.Air
Jul18PPM$pAir<-Jul18PPM$PPMAir*.6067346
Jul18PPM$pAiratm<-Jul18PPM$pAir*.000001
Jul18PPM$Difference<-((Jul18PPM$pCO2)-(Jul18PPM$pAir))
Jul18PPM$Differenceatm<-Jul18PPM$Difference*.000001

Jul25PPM<-data.frame(PPMCO2$Synoptic2_072519)
Jul25PPM$pCO2<-Jul25PPM*.6071190
Jul25PPM$pCO2atm<-Jul25PPM$pCO2*.000001
Jul25PPM$PPMAir<-PPMCO2$PPM.Air
Jul25PPM$pAir<-Jul25PPM$PPMAir*.6071190
Jul25PPM$pAiratm<-Jul25PPM$pAir*.000001
Jul25PPM$Difference<-((Jul25PPM$pCO2)-(Jul25PPM$pAir))
Jul25PPM$Differenceatm<-Jul25PPM$Difference*.000001

Jul31PPM<-data.frame(PPMCO2$Synoptic4_073119)
Jul31PPM$pCO2<-Jul31PPM*.6073121
Jul31PPM$pCO2atm<-Jul31PPM$pCO2*.000001
Jul31PPM$PPMAir<-PPMCO2$PPM.Air
Jul31PPM$pAir<-Jul31PPM$PPMAir*.6073121
Jul31PPM$pAiratm<-Jul31PPM$pAir*.000001
Jul31PPM$Difference<-((Jul31PPM$pCO2)-(Jul31PPM$pAir))
Jul31PPM$Differenceatm<-Jul31PPM$Difference*.000001

Aug6PPM<-data.frame(PPMCO2$Synoptic5_080619)
Aug6PPM$pCO2<-Aug6PPM*.6093153
Aug6PPM$pCO2atm<-Aug6PPM$pCO2*.00001
Aug6PPM$PPMAir<-PPMCO2$PPM.Air
Aug6PPM$pAir<-Aug6PPM$PPMAir*.6093153
Aug6PPM$pAiratm<-Aug6PPM$pAir*.000001
Aug6PPM$Difference<-((Aug6PPM$pCO2)-(Aug6PPM$pAir))
Aug6PPM$Differenceatm<-Aug6PPM$Difference*.000001

Aug12PPM<-data.frame(PPMCO2$Synoptic6_081219)
Aug12PPM$pCO2<-Aug12PPM*.6075996
Aug12PPM$pCO2atm<-Aug12PPM$pCO2*.000001
Aug12PPM$PPMAir<-PPMCO2$PPM.Air
Aug12PPM$pAir<-Aug12PPM$PPMAir*.6075996
Aug12PPM$pAiratm<-Aug12PPM$pAir*.000001
Aug12PPM$Difference<-((Aug12PPM$pCO2)-(Aug12PPM$pAir))
Aug12PPM$Differenceatm<-Aug12PPM$Difference*.000001

Aug12PPM<-Aug12PPM[-c(3)]
names(Jul18PPM)<-c("CO2 PPM","pCO2(uatm,aq)","pCO2(atm,aq)","Air PPM","pCO2(uatm, air)","pCO2(atm,air)","pCO2(aq)-pCO2(air)(uatm)","pCO2(aq)-pCO2(air)(atm)")
names(Jul25PPM)<-c("CO2 PPM","pCO2(uatm,aq)","pCO2(atm,aq)","Air PPM","pCO2(uatm, air)","pCO2(atm,air)","pCO2(aq)-pCO2(air)(uatm)","pCO2(aq)-pCO2(air)(atm)")
names(Jul31PPM)<-c("CO2 PPM","pCO2(uatm,aq)","pCO2(atm,aq)","Air PPM","pCO2(uatm, air)","pCO2(atm,air)","pCO2(aq)-pCO2(air)(uatm)","pCO2(aq)-pCO2(air)(atm)")
names(Aug6PPM)<-c("CO2 PPM","pCO2(uatm,aq)","pCO2(atm,aq)","Air PPM","pCO2(uatm, air)","pCO2(atm,air)","pCO2(aq)-pCO2(air)(uatm)","pCO2(aq)-pCO2(air)(atm)")
names(Aug12PPM)<-c("CO2 PPM","pCO2(uatm,aq)","pCO2(atm,aq)","Air PPM","pCO2(uatm, air)","pCO2(atm,air)","pCO2(aq)-pCO2(air)(uatm)","pCO2(aq)-pCO2(air)(atm)")

write.csv(Jul25PPM,"C:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Effective K/Jul18 pCO2 aq and Air.csv",row.names = TRUE)
          
pCO2<-pCO2[-c(6:8),]
