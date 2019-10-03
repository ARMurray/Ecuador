library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

date <- 'july30'

### Get a list of all the files
july30_Files <- list.files(here::here("2019 picarro/07/30"),pattern = '.dat')

#create an empty data.frame
alljuly30Data <- read.table(here::here("2019 picarro/07/30",july30_Files[1]), header= TRUE)


# Combine all july30 data
for(i in 2:length(july30_Files)){
  file <- july30_Files[i]
  data <- read.table(here::here("2019 picarro/07/30",file), header = TRUE)
  alljuly30Data <- rbind(alljuly30Data,data)
}
#select all the data columns we would ever need 
alljuly30Data <- alljuly30Data %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2, Delta_30s_iCO2, HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)

#Save this in case you'd ever need it 
write.csv(alljuly30Data,here("Picarro/EOSTransects/072919/", "comprehensivejuly30.csv"))

#Now let's just write one for CH4 data 
alljuly30Data <- alljuly30Data %>%
  select(DATE, TIME, HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)



# Combine Date and time into one column
alljuly30Data$DateTime <- paste0(alljuly30Data$DATE," ",substr(alljuly30Data$TIME,1,8))

# Convert to PosixCT
alljuly30Data$PosixCT <- as.POSIXct(alljuly30Data$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#make posic.ct, posixct again
alljuly30Data$PosixCT <- as.POSIXct(alljuly30Data$PosixCT)

#Select again the columns we need 
alljuly30Data <- alljuly30Data %>%
  select(PosixCT,HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)


#save all data in one file 
write.csv(alljuly30Data,here("Picarro/EOSTransects/072919/", "methanejuly30Data.csv"))


