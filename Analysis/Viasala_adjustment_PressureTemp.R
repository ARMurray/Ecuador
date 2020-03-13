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
Lvl_stn3$Stn3_Pressure_hPa <- Lvl_stn3$LEVEL * 10
Lvl_stn3$Temp_c_lvl3 = Lvl_stn3$TEMPERATURE

#temp data from EC at stations 1, 2, and 4 
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

#temp data from DO at stations 1, 2, and 4 
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

#Create Station Dataframes

#Station 1: viasala, temp, and pressure
a1 <- viasala[,c("DateTime","V1")]
b1 <- Lvl_stn1[,c("DateTime","Temp_c_lvl1", "Stn1_Pressure_hPa")]

c1 <- Lvl_stn1[,c("DateTime","Temp_c_lvl1")]
d1 <- EC_stn1[,c("DateTime","Temp_c_EC1")]
e1 <- DO_stn1[,c("DateTime","Temp_c_DO1")]
temp.df.stn1 <- merge(x=c1,y=d1,by="DateTime",all=TRUE)
temp.df.stn1 <- merge(x=temp.df.stn1,y=e1,by="DateTime",all=TRUE)
temp.df.stn1$Temp_c_Stn1Mean <- NA
#temp.df.stn1$temp_c_Stn1Mean <- rowMeans(temp.df.stn1[c("Temp_c_lvl1","Temp_c_EC1","Temp_c_DO1")], na.rm=TRUE) 

temp.df.stn1[is.na(temp.df.stn1)] <- 0
for( i in 1:nrow(temp.df.stn1)){
  if(temp.df.stn1[i,"Temp_c_EC1"] == 0 & temp.df.stn1[i,"Temp_c_DO1"] == 0 & temp.df.stn1[i,"Temp_c_lvl1"] ==0 ){  #if percent difference between lvl temp and the other 2 sensors is high
    temp.df.stn1[i,"Temp_c_Stn1Mean"]  <- NA 
  }}
temp.df.stn1 <- na.omit(temp.df.stn1) 
for( i in 1:nrow(temp.df.stn1)){
  if(temp.df.stn1[i,"Temp_c_EC1"] == 0 & temp.df.stn1[i,"Temp_c_DO1"] == 0 & temp.df.stn1[i,"Temp_c_lvl1"]>0 ){  #if percent difference between lvl temp and the other 2 sensors is high
    temp.df.stn1[i,"Temp_c_Stn1Mean"]  <- temp.df.stn1[i,"Temp_c_lvl1"] 
  }}
for( i in 1:nrow(temp.df.stn1)){
  if(temp.df.stn1[i,"Temp_c_lvl1"] == 0 & temp.df.stn1[i,"Temp_c_DO1"] == 0 & temp.df.stn1[i,"Temp_c_EC1"]>0 ){  #if percent difference between lvl temp and the other 2 sensors is high
    temp.df.stn1[i,"Temp_c_Stn1Mean"]  <- temp.df.stn1[i,"Temp_c_EC1"] 
  }}
for( i in 1:nrow(temp.df.stn1)){
  if(temp.df.stn1[i,"Temp_c_EC1"] == 0 & temp.df.stn1[i,"Temp_c_lvl1"] == 0 & temp.df.stn1[i,"Temp_c_DO1"]>0 ){  #if percent difference between lvl temp and the other 2 sensors is high
    temp.df.stn1[i,"Temp_c_Stn1Mean"]  <- temp.df.stn1[i,"Temp_c_DO1"] 
  }}

temp.df.stn1$P_ERROR_Lvl1Ec1 <- abs( temp.df.stn1$Temp_c_lvl1 - temp.df.stn1$Temp_c_EC1)/ temp.df.stn1$Temp_c_lvl1
temp.df.stn1$P_ERROR_Lvl1Do1 <- abs( temp.df.stn1$Temp_c_lvl1 - temp.df.stn1$Temp_c_DO1)/ temp.df.stn1$Temp_c_lvl1
temp.df.stn1$P_ERROR_Do1Ec1 <- abs( temp.df.stn1$Temp_c_DO1 - temp.df.stn1$Temp_c_EC1)/ temp.df.stn1$Temp_c_DO1
temp.df.stn1[is.na(temp.df.stn1)] <- 1

temp.df.stn1$Temp_c_LvlEcDo  <- rowMeans(temp.df.stn1[c("Temp_c_lvl1","Temp_c_EC1","Temp_c_DO1")], na.rm=TRUE)

for( i in 1:nrow(temp.df.stn1)){
  if(temp.df.stn1[i,"P_ERROR_Lvl1Ec1"] < 0.1 & temp.df.stn1[i,"P_ERROR_Lvl1Do1"] < 0.1 & temp.df.stn1[i,"P_ERROR_Do1Ec1"] < 0.1 ){  #if percent difference between lvl temp and the other 2 sensors is high
    temp.df.stn1[i,"Temp_c_Stn1Mean"]  <-   temp.df.stn1[i,"Temp_c_LvlEcDo"]
  }} 

temp.df.stn1$Temp_c_EcDo  <- rowMeans(temp.df.stn1[c("Temp_c_EC1","Temp_c_DO1")], na.rm=TRUE)

for( i in 1:nrow(temp.df.stn1)){
  if(temp.df.stn1[i,"P_ERROR_Lvl1Ec1"] > 0.1 & temp.df.stn1[i,"P_ERROR_Lvl1Do1"] > 0.1 & temp.df.stn1[i,"P_ERROR_Do1Ec1"] < 0.1 ){  #if percent difference between lvl temp and the other 2 sensors is high
    temp.df.stn1[i,"Temp_c_Stn1Mean"]  <-   temp.df.stn1[i,"Temp_c_EcDo"]
  }} 

temp.df.stn1$Temp_c_LvlDo  <- rowMeans(temp.df.stn1[c("Temp_c_lvl1","Temp_c_DO1")], na.rm=TRUE)

for( i in 1:nrow(temp.df.stn1)){
  if(temp.df.stn1[i,"P_ERROR_Lvl1Ec1"] > 0.1 & temp.df.stn1[i,"P_ERROR_Lvl1Do1"] < 0.1 & temp.df.stn1[i,"P_ERROR_Do1Ec1"] > 0.1 ){  #if percent difference between lvl temp and the other 2 sensors is high
    temp.df.stn1[i,"Temp_c_Stn1Mean"]  <-   temp.df.stn1[i,"Temp_c_LvlDo"]
  }} 

temp.df.stn1$Temp_c_LvlEc  <- rowMeans(temp.df.stn1[c("Temp_c_lvl1","Temp_c_EC1")], na.rm=TRUE)

for( i in 1:nrow(temp.df.stn1)){
  if(temp.df.stn1[i,"P_ERROR_Lvl1Ec1"] < 0.1 & temp.df.stn1[i,"P_ERROR_Lvl1Do1"] > 0.1 & temp.df.stn1[i,"P_ERROR_Do1Ec1"] > 0.1 ){  #if percent difference between lvl temp and the other 2 sensors is high
    temp.df.stn1[i,"Temp_c_Stn1Mean"]  <-   temp.df.stn1[i,"Temp_c_LvlEc"]
  }} 


stn1 <- merge(x=a1,y=b1,by="DateTime",all=TRUE)
stn1 <- merge(x=stn1,y=c1,by="DateTime",all=TRUE)
stn1 <- merge(x=stn1,y=d1,by="DateTime",all=TRUE)



#Station 2: viasala, temp, and pressure

b2 <- EC_stn2[,c("DateTime","Temp_c_EC2")]
c2 <- DO_stn2[,c("DateTime","Temp_c_DO2")]
d2 <- viasala[,c("DateTime","V2")]
stn2 <- merge(x=b2,y=c2,by="DateTime",all=TRUE)
stn2 <- merge(x=stn2,y=d2,by="DateTime",all=TRUE)

#Station 3: viasala, temp, and pressure
a3 <- Lvl_stn3[,c("DateTime","Temp_c_lvl3", "Stn3_Pressure_hPa")]
d3 <- viasala[,c("DateTime","V3")]
stn3 <- merge(x=a3,y=d3,by="DateTime",all=TRUE)

#Station 4: viasala, temp, and pressure
b4 <- EC_stn4[,c("DateTime","Temp_c_EC4")]
c4 <- DO_stn4[,c("DateTime","Temp_c_DO4")]
d4 <- viasala[,c("DateTime","V4")]
stn4 <- merge(x=b4,y=c4,by="DateTime",all=TRUE)
stn4 <- merge(x=stn4,y=d4,by="DateTime",all=TRUE)


#Fill in NAs
stn1_check <- stn1
stn1_check$P_ERROR_Lvl1Ec1 <- abs( stn1_check$Temp_c_lvl1 - stn1_check$Temp_c_EC1)/ stn1_check$Temp_c_lvl1
stn1_check$P_ERROR_Lvl1Do1 <- abs( stn1_check$Temp_c_lvl1 - stn1_check$Temp_c_DO1)/ stn1_check$Temp_c_lvl1
stn1_check$P_ERROR_Do1Ec1 <- abs( stn1_check$Temp_c_DO1 - stn1_check$Temp_c_EC1)/ stn1_check$Temp_c_DO1
P_ERROR_Lvl1Ec1 <- stn1_check[!is.na(stn1_check$P_ERROR_Lvl1Ec1),]
stn1_check <- subset(stn1_check,
                     P_ERROR_Lvl1Do1 > .15 )


a <- data.frame(High= c(NA, 3, 2), low= c(3, NA, 0))
#a$mean <- rowMeans(a, na.rm=TRUE)    
a$mean <- rowMeans(a[c("High","low")], na.rm=TRUE)  
