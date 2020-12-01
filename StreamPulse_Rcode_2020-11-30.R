#StreamPulse code  
#append DO, conductivity, and WL data
#2020-11-30

#Level logger notes:
# stn 1:	72020436
# stn 3:	72020421

library(here)

#read in those files!!!
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
DO_stn1$Date_Time <- as.POSIXct(DO_stn1$Date_Time, format="%m/%d/%y %H:%M:%S", tz="Etc/GMT-5")
attr(DO_stn1$Date_Time,"tzone") <- "UTC"
DO_stn1$row <- NULL

#Specific Conductivity
EC_stn1 <- 
  read.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/EC/Last_Collection/EC1_2019-08-14.csv",
           skip=2, header = FALSE, sep = ",",
           quote = "\"",dec = ".", fill = TRUE, comment.char = "")
EC_stn1 <- EC_stn1[,1:4]
colnames(EC_stn1)=c("row","Date_Time","EC_us","EC_Temp")
EC_stn1$Date_Time <- as.POSIXct(EC_stn1$Date_Time, format="%m/%d/%y %H:%M:%S", tz="Etc/GMT-5")
attr(EC_stn1$Date_Time,"tzone") <- "UTC"

EC_stn1$row <- NULL

#join all

merge1 <- merge(DO_stn1,WL_stn1,by="Date_Time")
Stn1_Data <- merge(merge1, EC_stn1, by="Date_Time")
rm(merge1)

write.csv("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/Ecuador/FieldData/DO/Last_Collection/EC_IRU1_XX2020-11-30")
