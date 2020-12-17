#StreamPulse code  
#append DO, conductivity, and WL data
#2020-11-30

#Level logger notes:
# stn 1:	72020436
# stn 3:	72020421

#DO notesis
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
library(readr)

#read in those files!!!
#######Discharge Rating Curve#########
#discharge rating curve is based on WL from station 3 becuase station 1 level logger was out of the water
#for a good long bit. 
#first we merge all stn2 data
WL_stn2_2019 <- 
  read.csv(here::here("FieldData/LevelLogger/Last_Collection/lvlgr_2020421_2019-08-14Compensated.csv"),
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = ""
  )
colnames(WL_stn2_2019)=c("Date","Time","offset","WL_m","WL_Temp")
WL_stn2_2019 <- WL_stn2_2019[,c(1:2,4:5)]
WL_stn2_2019$Date_Time <- paste(WL_stn2_2019$Date, WL_stn2_2019$Time)
WL_stn2_2019$Date_Time <- as.POSIXct(WL_stn2_2019$Date_Time, format="%m/%d/%Y %H:%M:%S", tz="Etc/GMT-5")
WL_stn2_2019$Date <- NULL
WL_stn2_2019$Time <- NULL

#### 
WL_stn2_2020 <- 
  read.csv(here::here("FieldData/Esteban/WaterLevel_BaroCompensated_csv/2020421_enero2020_compensated.csv"),
           skip=12, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = ""
  )
colnames(WL_stn2_2020)=c("Date","Time","offset","WL_m","WL_Temp")
WL_stn2_2020 <- WL_stn2_2020[,c(1:2,4:5)]
WL_stn2_2020$Date_Time <- paste(WL_stn2_2020$Date, WL_stn2_2020$Time)
#1kpa = 0.102m,
#and after installation, dwl increased by 1cm
WL_stn2_2020$WL_m <- WL_stn2_2020$WL_m*0.102 - .01 
WL_stn2_2020$Date_Time <- as.POSIXct(WL_stn2_2020$Date_Time, format="%m/%d/%Y %I:%M:%S %p", tz="Etc/GMT-5")
WL_stn2_2020$Date <- NULL
WL_stn2_2020$Time <- NULL

Discharge_Data <- rbind(WL_stn2_2019,WL_stn2_2020)
#Discharge Rating Curve for station 2 : y = 0.8313x2 - 0.184x + 0.0107
Discharge_Data$Q_m3s <- 0.8313*(Discharge_Data$WL_m)^2 - 0.184*(Discharge_Data$WL_m) + 0.0107
Discharge_Data$WL_m <- NULL
Discharge_Data$WL_Temp <- NULL


####ALL_Data#########
Other_Data <-read.csv(here::here("data_4_analysis/All_Stream_Data_2020-05-14.csv"),
                      header = TRUE)
Other_Data <- Other_Data[which(Other_Data$Inj.x == "No" ),]
Other_Data <- subset(Other_Data, select=c(DateTime, V1_adjusted, V2_adjusted, V3_adjusted, V4_adjusted, 
                                          lvl_421_m, Turbidity_NTU, Chlorophylla_ug.L,
                            CDOM_ppb, EC1_uS, EC2_uS, EC4_uS))
colnames(Other_Data) <- c("Date_Time", "CO2_ppm_1","CO2_ppm_2","CO2_ppm_3","CO2_ppm_4","lvl_stn3",
         "Turbidity_NTU", "Chlorophylla_ug.L","CDOM_ppb","EC_uS_1", "EC2_uS_2", "EC4_uS_3")
Other_Data$Date_Time <- as.POSIXct(Other_Data$Date_Time, format="%Y-%m-%d %H:%M:%S", tz="Etc/GMT-5")

#####weather station#####
LaVirgin_p <- read.csv(here::here("FieldData/Esteban/M5025_Precipitacion_2019-01-06_2020-02-01.csv"),
                     header = TRUE)
colnames(LaVirgin_p)=c("Date_Time","Precipt_cm")
LaVirgin_p$Date_Time <- as.POSIXct(LaVirgin_p$Date_Time, format="%m/%d/%Y %H:%M", tz="Etc/GMT-5")
LaVirgin_p$Date <- as.Date(LaVirgin_p$Date_Time)

#Sum precipitation by date
LaVirgin_sum <- LaVirgin_p %>% 
  drop_na(Precipt_cm) %>%
  group_by(Date) %>% 
  summarize(
    #    mean = mean(stn1_Q),
    Sum_precipt = sum(Precipt_cm))
LaVirgin_sum <- LaVirgin_sum[which(LaVirgin_sum$Date > "2019-06-01" &
                                      LaVirgin_sum$Date < "2020-01-18"), ]


#air temperature data from LaVIrgin weather station 
LaVirgin_t <- read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/Esteban/M5025_Temperatura_del_aire_2019-01-06_2020-02-01.csv",
                     header = TRUE)
LaVirgin_t$maximo <- NULL
LaVirgin_t$minimo <- NULL
colnames(LaVirgin_t)=c("Date_Time","Air_Temp_LaVirgin")
LaVirgin_t$Date_Time <- as.POSIXct(LaVirgin_t$Date_Time, format="%m/%d/%Y %H:%M", tz="Etc/GMT-5")

LaVirgin <- LaVirgin_t
  #merge(LaVirgin_p,LaVirgin_t, by = "Date_Time")
#rm(LaVirgin_p,LaVirgin_t)

## Air temp
Baro <- read.csv(here::here("FieldData/LevelLogger/Last_Collection/brllgr_2019-08-14.csv"),
                 skip=12, header = FALSE, sep = ",",
                 quote = "\"",dec = ".", fill = TRUE, comment.char = ""
)
colnames(Baro)=c("Date","Time","offset","airpress_kpa","Air_Temp_c")
Baro <- Baro[,c(1:2,4:5)]
Baro$Date_Time <- paste(Baro$Date, Baro$Time)
Baro$Date_Time <- as.POSIXct(Baro$Date_Time, format="%m/%d/%Y %H:%M:%S", tz="Etc/GMT-5")
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
Baro_jan$Date <- NULL
Baro_jan$Time <- NULL

Baro <- rbind(Baro, Baro_jan)

####### STATION 1`#######

#Water Level
WL_stn1 <- 
  read.csv(here::here("FieldData/LevelLogger/Last_Collection/lvlgr_2020436_2019-08-14Compensated.csv"),
                               skip=2, header = FALSE, sep = ",",
                               quote = "\"",dec = ".", fill = TRUE, comment.char = ""
                      )
colnames(WL_stn1)=c("Date","Time","offset","WL_m","WL_Temp")
WL_stn1 <- WL_stn1[,c(1:2,4:5)]
WL_stn1$Date_Time <- paste(WL_stn1$Date, WL_stn1$Time)

WL_stn1$Date_Time <- as.POSIXct(WL_stn1$Date_Time, format="%m/%d/%Y %H:%M:%S", tz="Etc/GMT-5")
WL_stn1$Date <- NULL
WL_stn1$Time <- NULL

#Dissolved Oxygen
DO_stn1 <- 
  read.csv(here::here("FieldData/DO/Last_Collection/DO_1_2019-08-14.csv"),
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn1 <- DO_stn1[,1:4]
colnames(DO_stn1)=c("row","Date_Time","DO_mgl","DO_Temp")
DO_stn1$Date_Time <- as.POSIXct(DO_stn1$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
DO_stn1$DO_Temp <- (DO_stn1$DO_Temp - 32) * 5/9

DO_stn1$row <- NULL

#Specific Conductivity
EC_stn1 <- 
  read.csv(here::here("FieldData/EC/Last_Collection/EC1_2019-08-14.csv"),
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn1 <- EC_stn1[,1:4]
colnames(EC_stn1)=c("row","Date_Time","EC_us","EC_Temp")
EC_stn1$Date_Time <- as.POSIXct(EC_stn1$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
EC_stn1$EC_Temp <- (EC_stn1$EC_Temp - 32) * 5/9
EC_stn1$row <- NULL

#Add other data for station 1
Other_Data_stn1 <- Other_Data[c("Date_Time", "CO2_ppm_1", "Turbidity_NTU",
                                 "Chlorophylla_ug.L","CDOM_ppb")]

 
#join all

Stn1_Data_2019_08_14 <- full_join(DO_stn1,WL_stn1,by="Date_Time")
Stn1_Data_2019_08_14 <- full_join(Stn1_Data_2019_08_14, EC_stn1, by="Date_Time")
Stn1_Data_2019_08_14 <- left_join(Stn1_Data_2019_08_14, Baro, by="Date_Time")
Stn1_Data_2019_08_14 <- left_join(Stn1_Data_2019_08_14, Other_Data_stn1, by="Date_Time")
Stn1_Data_2019_08_14 <- left_join(Stn1_Data_2019_08_14,LaVirgin_p,  by="Date_Time")
Stn1_Data_2019_08_14$Date <- NULL
Stn1_Data_2019_08_14 <- left_join(Stn1_Data_2019_08_14, Discharge_Data, by = "Date_Time")

# Write table
#Don't forget to change to UTC!

#attr(Stn1_Data_2019_08_14$Date_Time,"tzone") <- "UTC"
#write.table(Stn1_Data_2019_08_14, "C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/StreamPulse/EC_IRU1_2019-08-14_XX.csv", sep = ",", col.names = TRUE, row.names = FALSE)

### JANUARY DATA

##Station 1
WL_stn1 <- 
  read.csv(here::here("FieldData/Esteban/WaterLevel_BaroCompensated_csv/2020436_enero2020_compensated.csv"),
           skip=12, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = ""
  )
colnames(WL_stn1)=c("Date","Time","offset","WL_m","WL_Temp")
WL_stn1 <- WL_stn1[,c(1:2,4:5)]

#1kpa = 0.102m
WL_stn1$WL_m <- WL_stn1$WL_m*0.102 - .02

WL_stn1$Date_Time <- paste(WL_stn1$Date, WL_stn1$Time)
WL_stn1$Date_Time <- as.POSIXct(WL_stn1$Date_Time, format="%m/%d/%Y %I:%M:%S %p", tz="Etc/GMT-5")
WL_stn1$Date <- NULL
WL_stn1$Time <- NULL


#Dissolved Oxygen
DO_stn1 <- 
  read.csv(here::here("FieldData/Esteban/HOBO_CSVs/DO/20645539_January_2020.csv"),
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn1 <- DO_stn1[,1:4]
colnames(DO_stn1)=c("row","Date_Time","DO_mgl","DO_Temp")
DO_stn1$Date_Time <- as.POSIXct(DO_stn1$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
DO_stn1$DO_Temp <- (DO_stn1$DO_Temp - 32) * 5/9
DO_stn1$row <- NULL

DO_stn1 <- DO_stn1[ which(DO_stn1$DO_mgl > -100), ]

#Specific Conductivity
EC_stn1 <- 
  read.csv(here::here("FieldData/Esteban/HOBO_CSVs/EC/20636125_January_2020.csv"),
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn1 <- EC_stn1[,1:4]
colnames(EC_stn1)=c("row","Date_Time","EC_us","EC_Temp")
EC_stn1$Date_Time <- as.POSIXct(EC_stn1$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")

EC_stn1$row <- NULL

#Other Data for station 1


#join all

Stn1_Data_2020_01_19 <- full_join(DO_stn1,WL_stn1,by="Date_Time")
Stn1_Data_2020_01_19 <- full_join(Stn1_Data_2020_01_19, EC_stn1, by="Date_Time")
Stn1_Data_2020_01_19 <- full_join(Stn1_Data_2020_01_19, Baro, by="Date_Time")
#Stn1_Data_2020_01_19 <- left_join(Stn1_Data_2020_01_19,LaVirgin, by="Date_Time")
Stn1_Data_2020_01_19 <- left_join(Stn1_Data_2020_01_19, Discharge_Data, by="Date_Time")

#Read out - don't forget to convert time zone for stream pulse

#attr(Stn1_Data_2020_01_19$Date_Time,"tzone") <- "UTC"
#write.table(Stn1_Data_2020_01_19, here::here("StreamPulse/EC_IRU1_2020-01-19_XX.csv"), sep = ",", col.names = TRUE, row.names = FALSE)

stn1_All <- rbind(Stn1_Data_2019_08_14,Stn1_Data_2020_01_19)


############# STATION 2 ########
# Station 2 or 3

WL_stn2 <- 
  read.csv(here::here("FieldData/LevelLogger/Last_Collection/lvlgr_2020421_2019-08-14Compensated.csv"),
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = ""
  )
colnames(WL_stn2)=c("Date","Time","offset","WL_m","WL_Temp")
WL_stn2 <- WL_stn2[,c(1:2,4:5)]
WL_stn2$Date_Time <- paste(WL_stn2$Date, WL_stn2$Time)

WL_stn2$Date_Time <- as.POSIXct(WL_stn2$Date_Time, format="%m/%d/%Y %H:%M:%S", tz="Etc/GMT-5")
WL_stn2$Date <- NULL
WL_stn2$Time <- NULL

#Dissolved Oxygen
DO_stn2 <- 
  read.csv(here::here("FieldData/DO/Last_Collection/DO_2_2019-08-14.csv"),
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn2 <- DO_stn2[,1:4]
colnames(DO_stn2)=c("row","Date_Time","DO_mgl","DO_Temp")
DO_stn2$Date_Time <- as.POSIXct(DO_stn2$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
DO_stn2$DO_Temp <- (DO_stn2$DO_Temp - 32) * 5/9
DO_stn2$row <- NULL

DO_stn2 <- DO_stn2[ which(DO_stn2$DO_mgl > -100), ]

#Specific Conductivity
EC_stn2 <- 
  read.csv(here::here("FieldData/EC/Last_Collection/EC2_2019-08-14.csv"),
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn2 <- EC_stn2[,1:4]
colnames(EC_stn2)=c("row","Date_Time","EC_us","EC_Temp")
EC_stn2$Date_Time <- as.POSIXct(EC_stn2$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")

EC_stn2$row <- NULL

#Add other data for station 2
Other_Data_stn2 <- Other_Data[c("Date_Time", "CO2_ppm_2")]

#join stn2 or 3
  
Stn2_Data_2019_08_14 <- full_join(DO_stn2,WL_stn2,by="Date_Time")
Stn2_Data_2019_08_14 <- full_join(Stn2_Data_2019_08_14, EC_stn2, by="Date_Time")
Stn2_Data_2019_08_14 <- left_join(Stn2_Data_2019_08_14, Other_Data_stn2, by="Date_Time")
Stn2_Data_2019_08_14 <- left_join(Stn2_Data_2019_08_14, Baro, by="Date_Time")
Stn2_Data_2019_08_14 <- left_join(Stn2_Data_2019_08_14,Discharge_Data, by="Date_Time")

#read out

#attr(Stn2_Data_2019_08_14$Date_Time,"tzone") <- "UTC"

#write.csv(Stn2_Data_2019_08_14, "C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/StreamPulse/EC_IRU2_2019-08-14_XX.csv", row.names=FALSE)




#### 
WL_stn2 <- 
  read.csv(here::here("FieldData/Esteban/WaterLevel_BaroCompensated_csv/2020421_enero2020_compensated.csv"),
           skip=12, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = ""
  )
colnames(WL_stn2)=c("Date","Time","offset","WL_m","WL_Temp")
WL_stn2 <- WL_stn2[,c(1:2,4:5)]
WL_stn2$Date_Time <- paste(WL_stn2$Date, WL_stn2$Time)

#1kpa = 0.102m
WL_stn2$WL_m <- WL_stn2$WL_m*0.102 - .01

WL_stn2$Date_Time <- as.POSIXct(WL_stn2$Date_Time, format="%m/%d/%Y %I:%M:%S %p", tz="Etc/GMT-5")
WL_stn2$Date <- NULL
WL_stn2$Time <- NULL

#Dissolved Oxygen
DO_stn2 <- 
  read.csv(here::here("FieldData/Esteban/HOBO_CSVs/DO/20645540_January_2020.csv"),
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn2 <- DO_stn2[,1:4]
colnames(DO_stn2)=c("row","Date_Time","DO_mgl","DO_Temp")
DO_stn2$Date_Time <- as.POSIXct(DO_stn2$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
DO_stn2$DO_Temp <- (DO_stn2$DO_Temp - 32) * 5/9
DO_stn2$row <- NULL

DO_stn2 <- DO_stn2[ which(DO_stn2$DO_mgl > -100), ]

#Specific Conductivity
EC_stn2 <- 
  read.csv(here::here("FieldData/Esteban/HOBO_CSVs/EC/20636127_January_2020.csv"),
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn2 <- EC_stn2[,1:4]
colnames(EC_stn2)=c("row","Date_Time","EC_us","EC_Temp")
EC_stn2$Date_Time <- as.POSIXct(EC_stn2$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")

EC_stn2$row <- NULL

#join stn2 or 3

Stn2_Data_2020_01_19 <- full_join(DO_stn2,WL_stn2,by="Date_Time")
Stn2_Data_2020_01_19 <- full_join(Stn2_Data_2020_01_19, EC_stn2, by="Date_Time")
Stn2_Data_2020_01_19 <- left_join(Stn2_Data_2020_01_19, Baro, by="Date_Time")
Stn2_Data_2020_01_19 <- left_join(Stn2_Data_2020_01_19,Discharge_Data, by="Date_Time")

#write out

#attr(Stn2_Data_2020_01_19$Date_Time,"tzone") <- "UTC"
#write.csv(Stn2_Data_2020_01_19, "C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/StreamPulse/EC_IRU2_2020-01-19_XX.csv", row.names=FALSE)

stn2_All <- rbind(Stn2_Data_2019_08_14,Stn2_Data_2020_01_19)




####### Station 3 or 4...aug!####
# Station 3 or 4
#no level logger data for this station

#stn 3: 20636126
#Dissolved Oxygen : 20645538
DO_stn3 <- 
  read.csv(here::here("FieldData/DO/Last_Collection/DO_3_2019-08-14.csv"),
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn3 <- DO_stn3[,1:4]
colnames(DO_stn3)=c("row","Date_Time","DO_mgl","DO_Temp")
DO_stn3$Date_Time <- as.POSIXct(DO_stn3$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
DO_stn3$DO_Temp <- (DO_stn3$DO_Temp - 32) * 5/9
DO_stn3$row <- NULL

DO_stn3 <- DO_stn3[ which(DO_stn3$DO_mgl > -100), ]

#Specific Conductivity: 20636126
EC_stn3 <- 
  read.csv(here::here("FieldData/EC/Last_Collection/EC3_2019-08-14.csv"),
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn3 <- EC_stn3[,1:4]
colnames(EC_stn3)=c("row","Date_Time","EC_us","EC_Temp")
EC_stn3$Date_Time <- as.POSIXct(EC_stn3$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
EC_stn3$EC_Temp <- (EC_stn3$EC_Temp - 32) * 5/9

EC_stn3$row <- NULL

#join stn2 or 3

Stn3_Data_2019_08_14 <- full_join(EC_stn3,DO_stn3,by="Date_Time")
Stn3_Data_2019_08_14 <- left_join(Stn3_Data_2019_08_14, Baro, by="Date_Time")
Stn3_Data_2019_08_14 <- left_join(Stn3_Data_2019_08_14,LaVirgin, by="Date_Time")

#write out
#attr(Stn3_Data_2019_08_14$Date_Time,"tzone") <- "UTC"

#write_csv(Stn3_Data_2019_08_14, "C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/StreamPulse/EC_IRU2_2019_08_14_XX.csv")


#### no wl

#Dissolved Oxygen: 20645538
DO_stn3 <- 
  read.csv(here::here("FieldData/Esteban/HOBO_CSVs/DO/20645538_January_2020.csv"),
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn3 <- DO_stn3[,1:4]
colnames(DO_stn3)=c("row","Date_Time","DO_mgl","DO_Temp")
DO_stn3$Date_Time <- as.POSIXct(DO_stn3$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")
DO_stn3$DO_Temp <- (DO_stn3$DO_Temp - 32) * 5/9
DO_stn3$row <- NULL

DO_stn3 <- DO_stn3[ which(DO_stn3$DO_mgl > -100), ]

#Specific Conductivity
EC_stn3 <- 
  read.csv(here::here("FieldData/Esteban/HOBO_CSVs/EC/20636126_January_2020.csv"),
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn3 <- EC_stn3[,1:4]
colnames(EC_stn3)=c("row","Date_Time","EC_us","EC_Temp")
EC_stn3$Date_Time <- as.POSIXct(EC_stn3$Date_Time, format="%m/%d/%y %I:%M:%S %p", tz="Etc/GMT-5")

EC_stn3$row <- NULL

#join stn3 or 4

Stn3_Data_2020_01_19 <- full_join(DO_stn3,EC_stn3,by="Date_Time")
Stn3_Data_2020_01_19 <- left_join(Stn3_Data_2020_01_19, Baro, by="Date_Time")
Stn3_Data_2020_01_19 <- left_join(Stn3_Data_2020_01_19,LaVirgin, by="Date_Time")

#write out
#attr(Stn3_Data_2020_01_19$Date_Time,"tzone") <- "UTC"
#write_csv(Stn3_Data_2020_01_19, "C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/StreamPulse/EC_IRU2_2020_01_19_XX.csv")

stn3_All <- rbind(Stn3_Data_2019_08_14,Stn3_Data_2020_01_19)


