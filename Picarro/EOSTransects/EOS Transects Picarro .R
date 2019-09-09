library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)

date <- 'Aug9'
#Ok first let's bring in the data and clean her up a bit 
Aug9.1 <- read.table(here("2019 picarro/08/09/CFIDS2089-20190809-112009Z-DataLog_User.dat"), header=TRUE)


Aug9.1 <- Aug9.1 %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)
Aug9.1 <- Aug9.1[c(413:2069), ]

write.csv(Aug9.1,here("Picarro/EOSTransects/080819/", "Aug9.1.csv"))

#next file
Aug9.2 <- read.table(here("2019 picarro/08/09/CFIDS2089-20190809-115017Z-DataLog_User.dat"), header=TRUE)

Aug9.2 <- Aug9.2 %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)

Aug9.2 <- Aug9.2[c(1:1427), ]

write.csv(Aug9.2,here("Picarro/EOSTransects/080819/", "Aug9.2.csv"))

#last one 
Aug9.3 <- read.table(here("2019 picarro/08/09/CFIDS2089-20190730-122432Z-DataLog_User.dat"), header=TRUE)

Aug9.3 <- Aug9.3 %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)

Aug9.3 <- Aug9.3[c(1:455), ]


write.csv(Aug9.3,here("Picarro/EOSTransects/080819/", "Aug9.3.csv"))

#Merge all them files together 

### Get a list of all the files
Aug9_Files <- list.files(here::here("Picarro/EOSTransects/080819"),pattern = 'Aug9')
list(Aug9_Files)

#create an empty data.frame
allAug9Data <- read.csv(here::here("Picarro/EOSTransects/080819",Aug9_Files[1]))


for(i in 2:length(Aug9_Files)){
  file <- Aug9_Files[i]
  data <- read.csv(here::here("Picarro/EOSTransects/080819",file))
  allAug9Data <- rbind(allAug9Data,data)}
  
#Now save the dang thang 

write.csv(allAug9Data,here("Picarro/EOSTransects/080819/allAug9data.csv"))


