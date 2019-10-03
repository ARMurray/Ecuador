library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

date <- 'aug09'

### Get a list of all the files
aug09_Files <- list.files(here::here("2019 picarro/08/09"),pattern = '.dat')

#create an empty data.frame
allaug09Data <- read.table(here::here("2019 picarro/08/09",aug09_Files[1]), header= TRUE)


# Combine all aug09 data
for(i in 2:length(aug09_Files)){
  file <- aug09_Files[i]
  data <- read.table(here::here("2019 picarro/08/09",file), header = TRUE)
  allaug09Data <- rbind(allaug09Data,data)
}
#select all the data columns we would ever need 
allaug09Data <- allaug09Data %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2, Delta_30s_iCO2, HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)

#Save this in case you'd ever need it 
write.csv(allaug09Data,here("Picarro/EOSTransects/080819/", "comprehensiveaug09.csv"))

#Now let's just write one for CH4 data 
allaug09Data <- allaug09Data %>%
  select(DATE, TIME, HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)



# Combine Date and time into one column
allaug09Data$DateTime <- paste0(allaug09Data$DATE," ",substr(allaug09Data$TIME,1,8))

# Convert to PosixCT
allaug09Data$PosixCT <- as.POSIXct(allaug09Data$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#make posic.ct, posixct again
allaug09Data$PosixCT <- as.POSIXct(allaug09Data$PosixCT)

#Select again the columns we need 
allaug09Data <- allaug09Data %>%
  select(PosixCT,HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)


#save all data in one file 
write.csv(allaug09Data,here("Picarro/EOSTransects/080819/", "methaneaug09Data.csv"))


