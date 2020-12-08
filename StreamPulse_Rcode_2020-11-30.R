#StreamPulse code  
#append DO, conductivity, and WL data
#2020-11-30

#Level logger notes:
# stn 1:	72020436
# stn 3:	72020421

#DO notes
#stn 1: 20645539
#stn 2: 20645540
#stn 4: 20645538

#EC notes
#stn 1: 20636125
#stn 2: 20636127
#stn 3: 20636126 

library(readr)
library(here)
library(dplyr)
library(lubridate)
library(tidyverse)

#read in those files!!!

####ALL_Data
Other_Data <-read.csv("data_4_analysis/All_Stream_Data_2020-05-14.csv",
                      header = TRUE)
Other_Data <- Other_Data[which(Other_Data$Inj.x == "No" ),]
Other_Data <- subset(Other_Data, select=c(DateTime, V1_adjusted, V2_adjusted, V3_adjusted, V4_adjusted, Turbidity_NTU, Chlorophylla_ug.L,
                            CDOM_ppb, EC1_uS, EC2_uS, EC4_uS, stn1_Q))
colnames(Other_Data) <- c("Date_Time", "CO2_ppm_1","CO2_ppm_2","CO2_ppm_3","CO2_ppm_4",
         "Turbidity_NTU", "Chlorophylla_ug.L","CDOM_ppb","EC_uS_1", "EC2_uS_2", "EC4_uS_3", "Q_m3L")
Other_Data$Date_Time <- as.POSIXct(Other_Data$Date_Time, format="%Y-%m-%d %H:%M:%S", tz="Etc/GMT-5")
attr(Other_Data$Date_Time,"tzone") <- "UTC"

#####weather station#####
LaVirgin_p <- read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/Esteban/M5025_Precipitacion_2019-01-06_2020-02-01.csv",
                     header = TRUE)
colnames(LaVirgin_p)=c("Date_Time","Precipt_cm")
LaVirgin_p$Date_Time <- as.POSIXct(LaVirgin_p$Date_Time, format="%m/%d/%Y %H:%M", tz="Etc/GMT-5")
LaVirgin_p$Date <- as.Date(LaVirgin_p$Date_Time)
#attr(LaVirgin_p$Date_Time,"tzone") <- "UTC"

#Sum precipitation by date
LaVirgin_sum <- LaVirgin_p %>% 
  drop_na(Precipt_cm) %>%
  group_by(Date) %>% 
  summarize(
    #    mean = mean(stn1_Q),
    Sum_precipt = sum(Precipt_cm))
LaVirgin_sum <- LaVirgin_sum[which(LaVirgin_sum$Date > "2019-07-16" &
                                      LaVirgin_sum$Date < "2020-01-18"), ]


#air temperature data from LaVIrgin weather station 
LaVirgin_t <- read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/Esteban/M5025_Temperatura_del_aire_2019-01-06_2020-02-01.csv",
                     header = TRUE)
LaVirgin_t$maximo <- NULL
LaVirgin_t$minimo <- NULL
colnames(LaVirgin_t)=c("Date_Time","Air_Temp_LaVirgin")
LaVirgin_t$Date_Time <- as.POSIXct(LaVirgin_t$Date_Time, format="%m/%d/%Y %H:%M", tz="Etc/GMT-5")
attr(LaVirgin_t$Date_Time,"tzone") <- "UTC"

LaVirgin <- LaVirgin_t
  #merge(LaVirgin_p,LaVirgin_t, by = "Date_Time")
#rm(LaVirgin_p,LaVirgin_t)

## Air temp
Baro <- read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/LevelLogger/Last_Collection/brllgr_2019-08-14.csv",
                 skip=12, header = FALSE, sep = ",",
                 quote = "\"",dec = ".", fill = TRUE, comment.char = ""
)
colnames(Baro)=c("Date","Time","offset","airpress_kpa","Air_Temp_c")
Baro <- Baro[,c(1:2,4:5)]
Baro$Date_Time <- paste(Baro$Date, Baro$Time)
Baro$Date_Time <- as.POSIXct(Baro$Date_Time, format="%m/%d/%Y %H:%M:%S", tz="Etc/GMT-5")
attr(Baro$Date_Time,"tzone") <- "UTC"
Baro$Date <- NULL
Baro$Time <- NULL

### JANUARY DATA
## Air temp
Baro_jan <- read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/Esteban/Datos Logger de Gavilan Cayambe Coca_January 2020/solinst/2107266-enero-2020.csv",
                 skip=12, header = FALSE, sep = ",",
                 quote = "\"",dec = ".", fill = TRUE, comment.char = ""
)
colnames(Baro_jan)=c("Date","Time","offset","airpress_kpa","Air_Temp_c")
Baro_jan <- Baro_jan[,c(1:2,4:5)]
Baro_jan$Date_Time <- paste(Baro_jan$Date, Baro_jan$Time)
Baro_jan$Date_Time <- as.POSIXct(Baro_jan$Date_Time, format="%m/%d/%Y %I:%M:%S %p", tz="Etc/GMT-5")
attr(Baro_jan$Date_Time,"tzone") <- "UTC"
Baro_jan$Date <- NULL
Baro_jan$Time <- NULL

Baro <- rbind(Baro, Baro_jan)

####### STATION 1`#######

#Water Level
WL_stn1 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/LevelLogger/Last_Collection/lvlgr_2020436_2019-08-14Compensated.csv",
                               skip=2, header = FALSE, sep = ",",
                               quote = "\"",dec = ".", fill = TRUE, comment.char = ""
                      )
colnames(WL_stn1)=c("Date","Time","offset","WL_m","WL_Temp")
WL_stn1 <- WL_stn1[,c(1:2,4:5)]
WL_stn1$Date_Time <- paste(WL_stn1$Date, WL_stn1$Time)

WL_stn1$Date_Time <- as.POSIXct(WL_stn1$Date_Time, format="%m/%d/%Y %H:%M:%S", tz="Etc/GMT-5")
attr(WL_stn1$Date_Time,"tzone") <- "UTC"
WL_stn1$Date <- NULL
WL_stn1$Time <- NULL

#Dissolved Oxygen
DO_stn1 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/DO/Last_Collection/DO_1_2019-08-14.csv",
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn1 <- DO_stn1[,1:4]
colnames(DO_stn1)=c("row","Date_Time","DO_mgl","DO_Temp")
DO_stn1$Date_Time <- as.POSIXct(DO_stn1$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
attr(DO_stn1$Date_Time,"tzone") <- "UTC"
DO_stn1$DO_Temp <- (DO_stn1$DO_Temp - 32) * 5/9

DO_stn1$row <- NULL

#Specific Conductivity
EC_stn1 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/EC/Last_Collection/EC1_2019-08-14.csv",
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn1 <- EC_stn1[,1:4]
colnames(EC_stn1)=c("row","Date_Time","EC_us","EC_Temp")
EC_stn1$Date_Time <- as.POSIXct(EC_stn1$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
attr(EC_stn1$Date_Time,"tzone") <- "UTC"
EC_stn1$EC_Temp <- (EC_stn1$EC_Temp - 32) * 5/9
EC_stn1$row <- NULL

#Add other data for station 1
Other_Data_stn1 <- Other_Data[c("Date_Time", "CO2_ppm_1", "Turbidity_NTU",
                                 "Chlorophylla_ug.L","CDOM_ppb", "Q_m3L")]

#join all

Stn1_Data_2019_08_14 <- full_join(DO_stn1,WL_stn1,by="Date_Time")
Stn1_Data_2019_08_14 <- full_join(Stn1_Data_2019_08_14, EC_stn1, by="Date_Time")
Stn1_Data_2019_08_14 <- left_join(Stn1_Data_2019_08_14, Baro, by="Date_Time")
Stn1_Data_2019_08_14 <- left_join(Stn1_Data_2019_08_14, Other_Data_stn1, by="Date_Time")
Stn1_Data_2019_08_14 <- left_join(Stn1_Data_2019_08_14,LaVirgin,  by="Date_Time")

Stn1_Data_2019_08_14$Date_Time <- format(Stn1_Data_2019_08_14$Date_Time, usetz=TRUE)

write.csv(Stn1_Data_2019_08_14, "C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/StreamPulse/EC_IRU1_2019-08-14_XX.csv", row.names=FALSE)


### JANUARY DATA

##Station 1
WL_stn1 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/Esteban/WaterLevel_BaroCompensated_csv/2020436_enero2020_compensated.csv",
           skip=12, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = ""
  )
colnames(WL_stn1)=c("Date","Time","offset","WL_m","WL_Temp")
WL_stn1 <- WL_stn1[,c(1:2,4:5)]

WL_stn1$Date_Time <- paste(WL_stn1$Date, WL_stn1$Time)
WL_stn1$Date_Time <- as.POSIXct(WL_stn1$Date_Time, format="%m/%d/%Y %I:%M:%S %p", tz="Etc/GMT-5")
attr(WL_stn1$Date_Time,"tzone") <- "UTC"
WL_stn1$Date <- NULL
WL_stn1$Time <- NULL


#Dissolved Oxygen
DO_stn1 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/Esteban/HOBO_CSVs/DO/20645539_January_2020.csv",
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn1 <- DO_stn1[,1:4]
colnames(DO_stn1)=c("row","Date_Time","DO_mgl","DO_Temp")
DO_stn1$Date_Time <- as.POSIXct(DO_stn1$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
attr(DO_stn1$Date_Time,"tzone") <- "UTC"
DO_stn1$DO_Temp <- (DO_stn1$DO_Temp - 32) * 5/9
DO_stn1$row <- NULL

DO_stn1 <- DO_stn1[ which(DO_stn1$DO_mgl > -100), ]

#Specific Conductivity
EC_stn1 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/Esteban/HOBO_CSVs/EC/20636125_January_2020.csv",
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn1 <- EC_stn1[,1:4]
colnames(EC_stn1)=c("row","Date_Time","EC_us","EC_Temp")
EC_stn1$Date_Time <- as.POSIXct(EC_stn1$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
attr(EC_stn1$Date_Time,"tzone") <- "UTC"

EC_stn1$row <- NULL

#Other Data for station 1


#join all

Stn1_Data_2020_01_19 <- full_join(DO_stn1,WL_stn1,by="Date_Time")
Stn1_Data_2020_01_19 <- full_join(Stn1_Data_2020_01_19, EC_stn1, by="Date_Time")
Stn1_Data_2020_01_19 <- full_join(Stn1_Data_2020_01_19, Baro, by="Date_Time")
Stn1_Data_2020_01_19 <- left_join(Stn1_Data_2020_01_19,LaVirgin, by="Date_Time")

#Read out

Stn1_Data_2020_01_19$Date_Time <- format(Stn1_Data_2020_01_19$Date_Time, usetz=TRUE)

write.csv(Stn1_Data_2020_01_19, "C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/StreamPulse/EC_IRU1_2020-01-19_XX.csv", row.names=FALSE)

stn1_All <- rbind(Stn1_Data_2019_08_14,Stn1_Data_2020_01_19)


############# STATION 2 ########
# Station 2 or 3

WL_stn2 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/LevelLogger/Last_Collection/lvlgr_2020421_2019-08-14Compensated.csv",
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = ""
  )
colnames(WL_stn2)=c("Date","Time","offset","WL_m","WL_Temp")
WL_stn2 <- WL_stn2[,c(1:2,4:5)]
WL_stn2$Date_Time <- paste(WL_stn2$Date, WL_stn2$Time)

WL_stn2$Date_Time <- as.POSIXct(WL_stn2$Date_Time, format="%m/%d/%Y %H:%M:%S", tz="Etc/GMT-5")
attr(WL_stn2$Date_Time,"tzone") <- "UTC"
WL_stn2$Date <- NULL
WL_stn2$Time <- NULL

#Dissolved Oxygen
DO_stn2 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/DO/Last_Collection/DO_2_2019-08-14.csv",
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn2 <- DO_stn2[,1:4]
colnames(DO_stn2)=c("row","Date_Time","DO_mgl","DO_Temp")
DO_stn2$Date_Time <- as.POSIXct(DO_stn2$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
attr(DO_stn2$Date_Time,"tzone") <- "UTC"
DO_stn2$DO_Temp <- (DO_stn2$DO_Temp - 32) * 5/9
DO_stn2$row <- NULL

DO_stn2 <- DO_stn2[ which(DO_stn2$DO_mgl > -100), ]

#Specific Conductivity
EC_stn2 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/EC/Last_Collection/EC2_2019-08-14.csv",
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn2 <- EC_stn2[,1:4]
colnames(EC_stn2)=c("row","Date_Time","EC_us","EC_Temp")
EC_stn2$Date_Time <- as.POSIXct(EC_stn2$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
attr(EC_stn2$Date_Time,"tzone") <- "UTC"

EC_stn2$row <- NULL

#join stn2 or 3

Stn2_Data_2019_08_14 <- full_join(DO_stn2,WL_stn2,by="Date_Time")
Stn2_Data_2019_08_14 <- full_join(Stn2_Data_2019_08_14, EC_stn2, by="Date_Time")
Stn2_Data_2019_08_14 <- left_join(Stn2_Data_2019_08_14, Baro, by="Date_Time")
Stn2_Data_2019_08_14 <- left_join(Stn2_Data_2019_08_14,LaVirgin, by="Date_Time")

#read out
Stn2_Data_2019_08_14$Date_Time <- format(Stn2_Data_2019_08_14$Date_Time, usetz=TRUE)

write.csv(Stn2_Data_2019_08_14, "C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/StreamPulse/EC_IRU2_2019_08_14_XX.csv", row.names=FALSE)




#### 
WL_stn2 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/Esteban/WaterLevel_BaroCompensated_csv/2020421_enero2020_compensated.csv",
           skip=12, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = ""
  )
colnames(WL_stn2)=c("Date","Time","offset","WL_m","WL_Temp")
WL_stn2 <- WL_stn2[,c(1:2,4:5)]
WL_stn2$Date_Time <- paste(WL_stn2$Date, WL_stn2$Time)

WL_stn2$Date_Time <- as.POSIXct(WL_stn2$Date_Time, format="%m/%d/%Y %I:%M:%S %p", tz="Etc/GMT-5")
attr(WL_stn2$Date_Time,"tzone") <- "UTC"
WL_stn2$Date <- NULL
WL_stn2$Time <- NULL

#Dissolved Oxygen
DO_stn2 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/Esteban/HOBO_CSVs/DO/20645540_January_2020.csv",
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn2 <- DO_stn2[,1:4]
colnames(DO_stn2)=c("row","Date_Time","DO_mgl","DO_Temp")
DO_stn2$Date_Time <- as.POSIXct(DO_stn2$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
attr(DO_stn2$Date_Time,"tzone") <- "UTC"
DO_stn2$DO_Temp <- (DO_stn2$DO_Temp - 32) * 5/9
DO_stn2$row <- NULL

DO_stn2 <- DO_stn2[ which(DO_stn2$DO_mgl > -100), ]

#Specific Conductivity
EC_stn2 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/Esteban/HOBO_CSVs/EC/20636127_January_2020.csv",
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn2 <- EC_stn2[,1:4]
colnames(EC_stn2)=c("row","Date_Time","EC_us","EC_Temp")
EC_stn2$Date_Time <- as.POSIXct(EC_stn2$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
attr(EC_stn2$Date_Time,"tzone") <- "UTC"

EC_stn2$row <- NULL

#join stn2 or 3

Stn2_Data_2020_01_19 <- full_join(DO_stn2,WL_stn2,by="Date_Time")
Stn2_Data_2020_01_19 <- full_join(Stn2_Data_2020_01_19, EC_stn2, by="Date_Time")
Stn2_Data_2020_01_19 <- left_join(Stn2_Data_2020_01_19, Baro, by="Date_Time")
Stn2_Data_2020_01_19 <- left_join(Stn2_Data_2020_01_19,LaVirgin, by="Date_Time")


Stn2_Data_2020_01_19$Date_Time <- format(Stn2_Data_2020_01_19$Date_Time, usetz=TRUE)
write.csv(Stn2_Data_2020_01_19, "C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/StreamPulse/EC_IRU2_2020_01_19_XX.csv", row.names=FALSE)

stn2_All <- rbind(Stn2_Data_2019_08_14,Stn2_Data_2020_01_19)




####### Station 3 or 4...aug!####
# Station 3 or 4
#no level logger data for this station

#stn 3: 20636126
#Dissolved Oxygen : 20645538
DO_stn3 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/DO/Last_Collection/DO_3_2019-08-14.csv",
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn3 <- DO_stn3[,1:4]
colnames(DO_stn3)=c("row","Date_Time","DO_mgl","DO_Temp")
DO_stn3$Date_Time <- as.POSIXct(DO_stn3$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
attr(DO_stn3$Date_Time,"tzone") <- "UTC"
DO_stn3$DO_Temp <- (DO_stn3$DO_Temp - 32) * 5/9
DO_stn3$row <- NULL

DO_stn3 <- DO_stn3[ which(DO_stn3$DO_mgl > -100), ]

#Specific Conductivity: 20636126
EC_stn3 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/EC/Last_Collection/EC3_2019-08-14.csv",
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn3 <- EC_stn3[,1:4]
colnames(EC_stn3)=c("row","Date_Time","EC_us","EC_Temp")
EC_stn3$Date_Time <- as.POSIXct(EC_stn3$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
attr(EC_stn3$Date_Time,"tzone") <- "UTC"
EC_stn3$EC_Temp <- (EC_stn3$EC_Temp - 32) * 5/9

EC_stn3$row <- NULL

#join stn2 or 3

Stn3_Data_2019_08_14 <- full_join(EC_stn3,DO_stn3,by="Date_Time")
Stn3_Data_2019_08_14 <- left_join(Stn3_Data_2019_08_14, Baro, by="Date_Time")
Stn3_Data_2019_08_14 <- left_join(Stn3_Data_2019_08_14,LaVirgin, by="Date_Time")


Stn3_Data_2019_08_14$Date_Time <- format(Stn3_Data_2019_08_14$Date_Time, usetz=TRUE)

write.csv(Stn3_Data_2019_08_14, "C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/StreamPulse/EC_IRU2_2019_08_14_XX.csv", row.names=FALSE)


#### no wl

#Dissolved Oxygen: 20645538
DO_stn3 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/Esteban/HOBO_CSVs/DO/20645538_January_2020.csv",
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn3 <- DO_stn3[,1:4]
colnames(DO_stn3)=c("row","Date_Time","DO_mgl","DO_Temp")
DO_stn3$Date_Time <- as.POSIXct(DO_stn3$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
attr(DO_stn3$Date_Time,"tzone") <- "UTC"
DO_stn3$DO_Temp <- (DO_stn3$DO_Temp - 32) * 5/9
DO_stn3$row <- NULL

DO_stn3 <- DO_stn3[ which(DO_stn3$DO_mgl > -100), ]

#Specific Conductivity
EC_stn3 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/Esteban/HOBO_CSVs/EC/20636126_January_2020.csv",
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn3 <- EC_stn3[,1:4]
colnames(EC_stn3)=c("row","Date_Time","EC_us","EC_Temp")
EC_stn3$Date_Time <- as.POSIXct(EC_stn3$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
attr(EC_stn3$Date_Time,"tzone") <- "UTC"

EC_stn3$row <- NULL

#join stn3 or 4

Stn3_Data_2020_01_19 <- full_join(DO_stn3,EC_stn3,by="Date_Time")
Stn3_Data_2020_01_19 <- left_join(Stn3_Data_2020_01_19, Baro, by="Date_Time")
Stn3_Data_2020_01_19 <- left_join(Stn3_Data_2020_01_19,LaVirgin, by="Date_Time")


write_csv(Stn3_Data_2020_01_19, "C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/StreamPulse/EC_IRU2_2020_01_19_XX.csv")

stn3_All <- rbind(Stn3_Data_2019_08_14,Stn3_Data_2020_01_19)


