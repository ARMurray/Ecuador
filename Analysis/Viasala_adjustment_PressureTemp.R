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

#1 hPa = .1 kPa
Baro$Air_Pressure_hPa <- Baro$LEVEL * .1

#Water level
Lvl_stn1 <- read.csv(here::here("/FieldData/LevelLogger/Last_Collection/lvlgr_2020436_2019-08-14.csv"),skip=10, header = TRUE, sep = ",",
                 quote = "\"",dec = ".", fill = TRUE, comment.char = "")
Baro$DateTime=paste(Baro$Date, Baro$Time)
Baro$DateTime=mdy_hms(Baro$DateTime, tz='Etc/GMT+5')
Baro$DateTime <- as.POSIXct(Baro$DateTime, format="%Y-%m-%d %H:%M:%S", tz='Etc/GMT+5')