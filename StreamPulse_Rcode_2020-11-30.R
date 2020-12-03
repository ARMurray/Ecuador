#StreamPulse code  
#append DO, conductivity, and WL data
#2020-11-30

#Level logger notes:
# stn 1:	72020436
# stn 3:	72020421

#DO notes
#stn 1: 20645539
#stn 2: 20645540
#stn 3: 20645538

#EC notes
#stn 1: 20636125
#stn 2: 20636127
#stn 3: 20636126
library(readr)
library(here)
library(dplyr)

#read in those files!!!

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

##FIRST STATION 1`

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

#join all

Stn1_Data_2019_08_14 <- merge(DO_stn1,WL_stn1,by="Date_Time")
Stn1_Data_2019_08_14 <- merge(Stn1_Data_2019_08_14, EC_stn1, by="Date_Time")
Stn1_Data_2019_08_14 <- merge(Stn1_Data_2019_08_14, Baro, by="Date_Time")

#Stn1_Data_2019_08_14$DO_Temp <- NULL
#Stn1_Data_2019_08_14$WL_Temp <- NULL
#Stn1_Data_2019_08_14$EC_Temp <- NULL

write_csv(Stn1_Data_2019_08_14, "C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/StreamPulse/EC_IRU1_2020-08-14_XX.csv")


### JANUARY DATA
## Air temp
Baro <- read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/Esteban/Datos Logger de Gavilan Cayambe Coca_January 2020/solinst/2107266-enero-2020.csv",
                 skip=12, header = FALSE, sep = ",",
                 quote = "\"",dec = ".", fill = TRUE, comment.char = ""
)
colnames(Baro)=c("Date","Time","offset","airpress_kpa","Air_Temp_c")
Baro <- Baro[,c(1:2,4:5)]
Baro$Date_Time <- paste(Baro$Date, Baro$Time)
Baro$Date_Time <- as.POSIXct(Baro$Date_Time, format="%m/%d/%Y %I:%M:%S %p", tz="Etc/GMT-5")
attr(Baro$Date_Time,"tzone") <- "UTC"
Baro$Date <- NULL
Baro$Time <- NULL

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

#join all

Stn1_Data_2020_01_19 <- merge(DO_stn1,WL_stn1,by="Date_Time")
Stn1_Data_2020_01_19 <- merge(Stn1_Data_2020_01_19, Baro, by="Date_Time")
Stn1_Data_2020_01_19 <- full_join(Stn1_Data_2020_01_19, EC_stn1, by="Date_Time")


#Read out

#write_csv(Stn1_Data_2020_01_19, "C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/StreamPulse/EC_IRU1_2020-01-19_XX.csv")

All_Data <- rbind(Stn1_Data_2019_08_14,Stn1_Data_2020_01_19)
