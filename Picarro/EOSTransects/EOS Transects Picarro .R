library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)

date <- 'Aug9'

### Get a list of all the files
Aug9_Files <- list.files(here::here("2019 picarro/08/09"),pattern = '.dat')

#create an empty data.frame
allAug9Data <- read.table(here::here("2019 picarro/08/09",Aug9_Files[1]), header= TRUE)


### Combine all Aug9 data
for(i in 2:length(Aug9_Files)){
  file <- Aug9_Files[i]
  data <- read.table(here::here("2019 picarro/08/09",file), header = TRUE)
  allAug9Data <- rbind(allAug9Data,data)
}

allAug9Data <- allAug9Data %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)
#allAug9Data$Time_fix <- as.POSIXct(as.character(allAug9Data$TIME), format = "%H:%M:%OS")


# Combine Date and time into one column
allAug9Data$DateTime <- paste0(allAug9Data$DATE," ",substr(allAug9Data$TIME,1,8))

# Convert to PosixCT
allAug9Data$PosixCT <- as.POSIXct(allAug9Data$DateTime, format = '%Y-%m-%d %H:%M:%OS')

allAug9Data <- allAug9Data %>%
  select(PosixCT, X12CO2, Delta_Raw_iCO2)

allAug9Data <- allAug9Data[c(58000:92000), ]
plot <- ggplot(allAug9Data)+
  geom_point(aes(x= PosixCT, y= X12CO2)) +
  labs(x = "Time", y = "CO2")
plot


allAug9Data <- allAug9Data[c(52670:82600), ]

allAug9Data <- allAug9Data[c(3705:15765), ]
plot <- ggplot(allAug9Data)+
  geom_line(aes(x= Time_fix, y= X12CO2)) +
  labs(x = "Time", y = "CO2")
plot

#Ok first let's bring in the data and clean her up a bit 
Aug9.1 <- read.table(here("2019 picarro/08/09/Picarro0809_1351_1422.dat"), header=TRUE)

####separate(Aug9.1, Aug9.1$DATE, into = ("Year","Month","Day"), sep = "[^[:-:]]+")
#Aug9.1$dateTime <- as.POSIXct(as.character(paste0(Aug9.1$DATE," ",Aug9.1$TIME)), format = "%m/%d/%Y %H:%M:%OS")
Aug9.1 <- Aug9.1 %>%
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


