#Merging long term data from 2019

library(here)
library(dplyr)

#4 stations
#station 1 

WL_01 <- read.csv(here::here("FieldData/LevelLogger/Last_Collection/lvlgr_2020436_2019-08-14Compensated.csv"))
WL_01$DateTime <- paste(WL_01$Date, WL_01$Time)
WL_01$DateTime <- as.POSIXct(WL_01$DateTime, format="%m/%d/%Y %H:%M:%S", tz="UTC")
WL_01 <- WL_01[,c("DateTime","LEVEL_m","TEMP_c")]
colnames(WL_01)  <- c("DateTime","Stn01_WL_m","Stn01_WLTemp_C")

DO_01 <- read.csv(here::here("FieldData/DO/Last_Collection/DO_1_2019-08-14.csv"), skip = 1)[,c(2:4)]
colnames(DO_01)  <- c("DateTime","Stn01_DO_mg.L","Stn01_DOTemp_C")
DO_01$Stn01_DOTemp_C <- (DO_01$Stn01_DOTemp_C -32) *5/9
DO_01$DateTime <- as.POSIXct(DO_01$DateTime, format="%m/%d/%y %I:%M:%S %p", tz="UTC")

EC_01 <- read.csv(here::here("FieldData/EC/Last_Collection/EC1_2019-08-14.csv"), skip = 1)[,c(2:4)]
colnames(EC_01)  <- c("DateTime","Stn01_EC_uS","Stn01_ECTemp_C")
EC_01$Stn01_ECTemp_C <- (EC_01$Stn01_ECTemp_C -32) *5/9
EC_01$DateTime <- as.POSIXct(EC_01$DateTime, format="%m/%d/%y %I:%M:%S %p", tz="UTC")

#staion 2
DO_02 <- read.csv(here::here("FieldData/DO/Last_Collection/DO_2_2019-08-14.csv"),skip=1)[,c(2:4)]
colnames(DO_02)  <- c("DateTime","Stn02_DO_mg.L","Stn02_DOTemp_C")
DO_02$Stn02_DOTemp_C <- (DO_02$Stn02_DOTemp_C -32) *5/9
DO_02$DateTime <- as.POSIXct(DO_02$DateTime, format="%m/%d/%y %I:%M:%S %p", tz="UTC")

#station 3  
WL_03 <- read.csv(here::here("FieldData/LevelLogger/Last_Collection/lvlgr_2020421_2019-08-14Compensated.csv"))
WL_03$DateTime <- paste(WL_03$Date, WL_03$Time)
WL_03$DateTime <- as.POSIXct(WL_03$DateTime, format="%m/%d/%Y %H:%M:%S", tz="UTC")
WL_03 <- WL_03[,c("DateTime","LEVEL_m","TEMP_c")]
colnames(WL_03)  <- c("DateTime","Stn03_WL_m","Stn03_WLTemp_C")

#Station 4
DO_04 <- read.csv(here::here("FieldData/DO/Last_Collection/DO_3_2019-08-14.csv"),skip=1)[,c(2:4)]
colnames(DO_04)  <- c("DateTime","Stn04_DO_mg.L","Stn04_DOTemp_C")
DO_04$Stn04_DOTemp_C <- (DO_04$Stn04_DOTemp_C -32) *5/9
DO_04$DateTime <- as.POSIXct(DO_04$DateTime, format="%m/%d/%y %I:%M:%S %p", tz="UTC")

#Baro  - water level has already been componsated
Baro <- read.csv(here::here("FieldData/LevelLogger/Last_Collection/brllgr_2019-08-14.csv"),skip=10)
Baro$DateTime <- paste(Baro$Date, Baro$Time)
Baro$DateTime <- as.POSIXct(Baro$DateTime, format="%m/%d/%Y %H:%M:%S", tz="UTC")
Baro <- Baro[,c("DateTime","LEVEL","TEMPERATURE")]
colnames(Baro)  <- c("DateTime","AirPress_kpa","AirTemp_C")

#all data

All_data2020 <- read.csv(here::here("data_4_analysis/All_Stream_Data.csv"))
All_data2020 <- All_data2020[,c("DateTime","V1_adjusted","V2_adjusted","V3_adjusted","V4_adjusted")]
All_data2020$DateTime <- as.POSIXct(All_data2020$DateTime, format="%Y-%m-%d %H:%M:%S", tz="UTC")
colnames(All_data2020) <- c("DateTime","Stn01_CO2_ppm","Stn02_CO2_ppm","Stn03_CO2_ppm","Stn04_CO2_ppm")

###merge all

MergedData <- full_join(Baro,WL_01,by="DateTime")
MergedData <- full_join(MergedData,EC_01,by="DateTime")
MergedData <- full_join(MergedData,DO_01,by="DateTime")
MergedData <- full_join(MergedData,DO_02,by="DateTime")
MergedData <- full_join(MergedData,WL_03,by="DateTime")
MergedData <- full_join(MergedData,DO_04,by="DateTime")
MergedData <- left_join(MergedData,All_data2020,by="DateTime")

#write out

write.csv(MergedData, here::here("StreamPulse/MergedData_2019.csv"), row.names = FALSE)

