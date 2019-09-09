library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)

date <- 'July17'
#Ok first let's bring in the data and clean her up a bit 
July17.1 <- read.table(here("2019 picarro/07/17/CFIDS2089-20190717-134835Z-DataLog_User.dat"), header=TRUE)


July17.1 <- July17.1 %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)
July17.1 <- July17.1[c(1476:2065), ]

write.csv(July17.1,here("Picarro/EOSTransects/071619/", paste0(date,".1", ".csv")))

#next file
July17.2 <- read.table(here("2019 picarro/07/17/CFIDS2089-20190717-141844Z-DataLog_User.dat"), header=TRUE)

July17.2 <- July17.2 %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)


write.csv(July17.2,here("Picarro/EOSTransects/071619/", "July17.2.csv"))

#last one 
July17.3 <- read.table(here("2019 picarro/07/17/CFIDS2089-20190717-144854Z-DataLog_User.dat"), header=TRUE)

July17.3 <- July17.3 %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)
July17.3 <- July17.3[c(1:1527), ]


write.csv(July17.3,here("Picarro/EOSTransects/071619/", "July17.3.csv"))

#Merge all them files together 

### Get a list of all the files
July17_Files <- list.files(here::here("Picarro/EOSTransects/071619"),pattern = 'July17')
list(July17_Files)

#create an empty data.frame
allJuly17Data <- read.csv(here::here("Picarro/EOSTransects/071619",July17_Files[1]))


for(i in 2:length(July17_Files)){
  file <- July17_Files[i]
  data <- read.csv(here::here("Picarro/EOSTransects/071619",file))
  allJuly17Data <- rbind(allJuly17Data,data)}
  
#Now save the dang thang 

write.csv(allJuly17Data,here("Picarro/EOSTransects/071619/allJuly17data.csv"))


