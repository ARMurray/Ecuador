#Adjust Viasala readings for pressure and temperature
library(here)

#viasala readings need to be corrected for pressure and temperature:
# Temperature dependence: -0.3% of reading / celcius (reference 25c/77F)
# Pressure dependence: +0.15% of reading / hPa (reference 1013hPa)

#for temperature, we use the water level
#for pressure we use barometric pressure and water level

All_Stream_Data <- read.csv(here::here("/data_4_analysis/All_Stream_Data.csv"))

viasala <- All_Stream_Data[,c("DateTime","Inj","V1","V2","V3","V4")]
viasala$DateTime <- as.POSIXct(viasala$DateTime, format="%Y-%m-%d %H:%M:%S", tz='Etc/GMT+5')

#Baro
Baro <- read.csv(here::here("/FieldData/LevelLogger/Last_Collection/brllgr_2019-08-14.csv"),skip=10, header = TRUE, sep = ",",
                            quote = "\"",dec = ".", fill = TRUE, comment.char = "")
Baro$DateTime=paste(Baro$Date, Baro$Time)
Baro$DateTime=mdy_hms(Baro$DateTime, tz='Etc/GMT+5')
Baro$DateTime <- as.POSIXct(Baro$DateTime, format="%Y-%m-%d %H:%M:%S", tz='Etc/GMT+5')

#1 kPa = 10 hPa
#1 kPa = 0.101972 m

Baro$Air_Pressure_hPa <- Baro$LEVEL * 10

#Water level
Lvl_stn1 <- read.csv(here::here("/FieldData/LevelLogger/Last_Collection/lvlgr_stn1_2019-08-14.csv"),skip=11, header = TRUE, sep = ",",
                 quote = "\"",dec = ".", fill = TRUE, comment.char = "")
Lvl_stn1$DateTime=paste(Lvl_stn1$Date, Lvl_stn1$Time)
Lvl_stn1$DateTime=mdy_hms(Lvl_stn1$DateTime, tz='Etc/GMT+5')
Lvl_stn1$DateTime <- as.POSIXct(Lvl_stn1$DateTime, format="%Y-%m-%d %H:%M:%S", tz='Etc/GMT+5')
#origional data recorded in m
Lvl_stn1$Stn1_Pressure_hPa <- Lvl_stn1$LEVEL / 0.101972 * 10
Lvl_stn1$Temp_c_lvl1 = Lvl_stn1$TEMPERATURE

Lvl_stn3 <- read.csv(here::here("/FieldData/LevelLogger/Last_Collection/lvlgr_stn3_2019-08-14.csv"),skip=11, header = TRUE, sep = ",",
                     quote = "\"",dec = ".", fill = TRUE, comment.char = "")
Lvl_stn3$DateTime=paste(Lvl_stn3$Date, Lvl_stn3$Time)
Lvl_stn3$DateTime=mdy_hms(Lvl_stn3$DateTime, tz='Etc/GMT+5')
Lvl_stn3$DateTime <- as.POSIXct(Lvl_stn3$DateTime, format="%Y-%m-%d %H:%M:%S", tz='Etc/GMT+5')
#origional data recorded in kPa
Lvl_stn3$Stn2_Pressure_hPa <- Lvl_stn3$LEVEL * 10
Lvl_stn3$Temp_c_lvl3 = Lvl_stn3$TEMPERATURE

#more temp data
EC_stn1 <- read.csv(here::here("/FieldData/EC/Last_Collection/EC1_2019-08-14.csv"),skip=1, header = TRUE, sep = ",",
                     quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn1 <- EC_stn1[,2:4]
colnames(EC_stn1)=c("DateTime", "EC_stn1", "Temp_c_EC1")
EC_stn1$Temp_c_EC1 <- (EC_stn1$Temp_c_EC1 - 32) / 1.8 
EC_stn1$DateTime <- as.POSIXct(EC_stn1$DateTime, format="%m/%d/%y %I:%M:%S %p", tz='Etc/GMT+5')

EC_stn2 <- read.csv(here::here("/FieldData/EC/Last_Collection/EC2_2019-08-14.csv"),skip=1, header = TRUE, sep = ",",
                    quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn2 <- EC_stn2[,2:4]
colnames(EC_stn2)=c("DateTime", "EC_stn2", "Temp_c_EC2")
EC_stn2$Temp_c_EC2 <- (EC_stn2$Temp_c_EC2 - 32) / 1.8
EC_stn2$DateTime <- as.POSIXct(EC_stn2$DateTime, format="%m/%d/%y %I:%M:%S %p", tz='Etc/GMT+5')

EC_stn4 <- read.csv(here::here("/FieldData/EC/Last_Collection/EC3_2019-08-14.csv"),skip=1, header = TRUE, sep = ",",
                    quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn4 <- EC_stn4[,2:4]
colnames(EC_stn4)=c("DateTime", "EC_stn4", "Temp_c_EC4")
EC_stn4$Temp_c_EC4 <- (EC_stn4$Temp_c_EC4 - 32) / 1.8
EC_stn4$DateTime <- as.POSIXct(EC_stn4$DateTime, format="%m/%d/%y %I:%M:%S %p", tz='Etc/GMT+5')

#more temp data DO
DO_stn1 <- read.csv(here::here("/FieldData/DO/Last_Collection/DO_1_2019-08-14.csv"),skip=1, header = TRUE, sep = ",",
                    quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn1 <- DO_stn1[,2:4]
colnames(DO_stn1)=c("DateTime", "DO_stn1", "Temp_c_DO1")
DO_stn1$Temp_c_DO1 <- (DO_stn1$Temp_c_DO1 - 32) / 1.8 
DO_stn1$DateTime <- as.POSIXct(DO_stn1$DateTime, format="%m/%d/%y %I:%M:%S %p", tz='Etc/GMT+5')

DO_stn2 <- read.csv(here::here("/FieldData/DO/Last_Collection/DO_2_2019-08-14.csv"),skip=1, header = TRUE, sep = ",",
                    quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn2 <- DO_stn2[,2:4]
colnames(DO_stn2)=c("DateTime", "DO_stn2", "Temp_c_DO2")
DO_stn2$Temp_c_DO2 <- (DO_stn2$Temp_c_DO2 - 32) / 1.8 
DO_stn2$DateTime <- as.POSIXct(DO_stn2$DateTime, format="%m/%d/%y %I:%M:%S %p", tz='Etc/GMT+5')

DO_stn4 <- read.csv(here::here("/FieldData/DO/Last_Collection/DO_3_2019-08-14.csv"),skip=1, header = TRUE, sep = ",",
                    quote = "\"",dec = ".", fill = TRUE, comment.char = "")
DO_stn4 <- DO_stn4[,2:4]
colnames(DO_stn4)=c("DateTime", "DO_stn4", "Temp_c_DO4")
DO_stn4$Temp_c_DO3 <- (DO_stn4$Temp_c_DO4 - 32) / 1.8
DO_stn4$DateTime <- as.POSIXct(DO_stn4$DateTime, format="%m/%d/%y %I:%M:%S %p", tz='Etc/GMT+5')

#Get all temperature data together for each station
a1 <- Lvl_stn1[,c("DateTime","Temp_c_lvl1")]
b1 <- EC_stn1[,c("DateTime","Temp_c_EC1")]
c1 <- DO_stn1[,c("DateTime","Temp_c_DO1")]
stn1_temperature <- merge(x=a1,y=b1,by="DateTime",all=TRUE)
stn1_temperature <- merge(x=stn1_temperature,y=c1,by="DateTime",all=TRUE)

#Get all temperature data together for each station
b2 <- EC_stn2[,c("DateTime","Temp_c_EC2")]
c2 <- DO_stn2[,c("DateTime","Temp_c_DO2")]
stn2_temperature <- merge(x=b2,y=c2,by="DateTime",all=TRUE)

#Get all temperature data together for each station
a3 <- Lvl_stn3[,c("DateTime","Temp_c_lvl3")]
c3 <- DO_stn3[,c("DateTime","Temp_c_DO3")]
stn3_temperature <- merge(x=a3,y=c3,by="DateTime",all=TRUE)


#Get all temperature data together for each station
b4 <- EC_stn4[,c("DateTime","Temp_c_EC4")]
c4 <- DO_stn4[,c("DateTime","Temp_c_DO4")]
stn3_temperature <- merge(x=b4,y=c4,by="DateTime",all=TRUE)