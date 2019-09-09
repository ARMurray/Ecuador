library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)

date <- 'Aug13'
#Ok first let's bring in the data and clean her up a bit 
Aug13.1 <- read.table(here("2019 picarro/08/13/CFIDS2089-20190813-164950Z-DataLog_User.dat"), header=TRUE)


Aug13.1 <- Aug13.1 %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)
Aug13.1 <- Aug13.1[c(90:2060), ]

write.csv(Aug13.1,here("Picarro/EOSTransects/081319/", "Aug13.1.csv"))

#next file
Aug13.2 <- read.table(here("2019 picarro/08/13/CFIDS2089-20190813-171959Z-DataLog_User.dat"), header=TRUE)

Aug13.2 <- Aug13.2 %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)

Aug13.2 <- Aug13.2[c(1:1427), ]

write.csv(Aug13.2,here("Picarro/EOSTransects/081319/", "Aug13.2.csv"))

#last one 
Aug13.3 <- read.table(here("2019 picarro/08/13/CFIDS2089-20190730-122432Z-DataLog_User.dat"), header=TRUE)

Aug13.3 <- Aug13.3 %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)

Aug13.3 <- Aug13.3[c(1:455), ]


write.csv(Aug13.3,here("Picarro/EOSTransects/081319/", "Aug13.3.csv"))

#Merge all them files together 

### Get a list of all the files
Aug13_Files <- list.files(here::here("Picarro/EOSTransects/081319"),pattern = 'Aug13')
list(Aug13_Files)

#create an empty data.frame
allAug13Data <- read.csv(here::here("Picarro/EOSTransects/081319",Aug13_Files[1]))


for(i in 2:length(Aug13_Files)){
  file <- Aug13_Files[i]
  data <- read.csv(here::here("Picarro/EOSTransects/081319",file))
  allAug13Data <- rbind(allAug13Data,data)}
  
#Now save the dang thang 

write.csv(allAug13Data,here("Picarro/EOSTransects/081319/allAug13data.csv"))


