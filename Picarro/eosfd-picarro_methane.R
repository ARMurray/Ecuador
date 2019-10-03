library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

date <- 'aug13'

### Get a list of all the files
aug13_Files <- list.files(here::here("2019 picarro/08/13"),pattern = '.dat')

#create an empty data.frame
allaug13Data <- read.table(here::here("2019 picarro/08/13",aug13_Files[1]), header= TRUE)


# Combine all aug13 data
for(i in 2:length(aug13_Files)){
  file <- aug13_Files[i]
  data <- read.table(here::here("2019 picarro/08/13",file), header = TRUE)
  allaug13Data <- rbind(allaug13Data,data)
}
#select all the data columns we would ever need 
allaug13Data <- allaug13Data %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2, Delta_30s_iCO2, HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)

#Save this in case you'd ever need it 
write.csv(allaug13Data,here("Picarro/EOSTransects/081319/", "comprehensiveaug13.csv"))

#Now let's just write one for CH4 data 
allaug13Data <- allaug13Data %>%
  select(DATE, TIME, HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)



# Combine Date and time into one column
allaug13Data$DateTime <- paste0(allaug13Data$DATE," ",substr(allaug13Data$TIME,1,8))

# Convert to PosixCT
allaug13Data$PosixCT <- as.POSIXct(allaug13Data$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#make posic.ct, posixct again
allaug13Data$PosixCT <- as.POSIXct(allaug13Data$PosixCT)

#Select again the columns we need 
allaug13Data <- allaug13Data %>%
  select(PosixCT,HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)


#save all data in one file 
write.csv(allaug13Data,here("Picarro/EOSTransects/081319/", "methaneaug13Data.csv"))


