library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)

date <- 'July23'
#Ok first let's bring in the data and clean her up a bit 
July23.1 <- read.table(here("2019 picarro/07/23/CFIDS2089-20190723-105943Z-DataLog_User.dat"), header=TRUE)


July23.1 <- July23.1 %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)
July23.1 <- July23.1[c(1401:2067), ]

write.csv(July23.1,here("Picarro/EOSTransects/072219/", paste0(date,".1", ".csv")))

#next file
July23.2 <- read.table(here("2019 picarro/07/23/CFIDS2089-20190723-112952Z-DataLog_User.dat"), header=TRUE)

July23.2 <- July23.2 %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)


write.csv(July23.2,here("Picarro/EOSTransects/072219/", "July23.2.csv"))

#last one 
July23.3 <- read.table(here("2019 picarro/07/23/CFIDS2089-20190723-120001Z-DataLog_User.dat"), header=TRUE)

July23.3 <- July23.3 %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)

July17.3 <- July17.3[c(1:1527), ]


write.csv(July23.3,here("Picarro/EOSTransects/072219/", "July23.3.csv"))

#Merge all them files together 

### Get a list of all the files
July23_Files <- list.files(here::here("Picarro/EOSTransects/072219"),pattern = 'July23')
list(July23_Files)

#create an empty data.frame
allJuly23Data <- read.csv(here::here("Picarro/EOSTransects/072219",July23_Files[1]))


for(i in 2:length(July23_Files)){
  file <- July23_Files[i]
  data <- read.csv(here::here("Picarro/EOSTransects/072219",file))
  allJuly23Data <- rbind(allJuly23Data,data)}
  
#Now save the dang thang 

write.csv(allJuly23Data,here("Picarro/EOSTransects/072219/allJuly23data.csv"))


