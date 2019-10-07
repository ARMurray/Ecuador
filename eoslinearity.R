library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)

aug13 <- read.csv(here("Picarro/EOSTransects/081319/allsamplesaug13.csv"))


ecu1 <- onlyecuaug09[ which(onlyecuaug09$PosixCT > "2019-08-09 14:41:10"
                        & onlyecuaug09$PosixCT < "2019-08-09 14:42:52"), ]
ecu1$Sample <- as.character("ecu1")

ecu2 <- onlyecuaug09[ which(onlyecuaug09$PosixCT > "2019-08-09 16:11:26"
                        & onlyecuaug09$PosixCT < "2019-08-09 16:12:19"), ]
ecu2$Sample <- as.character("ecu2")


ecuaug09 <- rbind(ecu1, ecu2)

#add day column 
ecuaug09$day <- as.character("Aug09")

write.csv(ecuaug09, here("Picarro/EOSTransects/080819/", "ecusamplesaug09.csv"))

ecuaug13 <- read.csv(here("Picarro/EOSTransects/081319/samplesaug13.csv"))
ecujuly17 <- read.csv(here("Picarro/EOSTransects/071619/samplesjuly17.csv"))
ecujuly23 <- read.csv(here("Picarro/EOSTransects/072219/samplesjuly23.csv"))
ecujuly30 <- read.csv(here("Picarro/EOSTransects/072919/samplesjuly30.csv"))
ecuaug02 <- read.csv(here("Picarro/EOSTransects/080119/samplesaug02.csv"))
#ecuaug09 <- read.csv(here("Picarro/EOSTransects/080819/samplesaug09.csv"))

ecujuly30 <- ecujuly30[ which(ecujuly30$Sample == "ecu2"
                            | ecujuly30$Sample == "ecu1"), ]

ecujuly30$Day <- as.character("July30")

write.csv(ecuaug13, here("Picarro/EOSTransects/081319/aug13ecuwithco2.csv"))

onlyecuall <- rbind(ecuaug02, ecuaug09, ecuaug13, ecujuly17, ecujuly23, ecujuly30)



write.csv(onlyecuall, here("Picarro/EOSTransects", "allecusamples_raw.csv"))


#ok now let's find the mean of each ecu sample 
#what we want at the end is a table with the mean, day, sample, std dev, and variance 


justsamples23 <- allaug09Data[ which(allaug09Data$PosixCT > "2019-07-23 15:00:00"
                                     & allaug09Data$PosixCT < "2019-07-23 17:00:00"), ]

col1avg <- data.frame("Sample" = "col1", "Avg_iCH4" = mean(col1$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col1$Delta_iCH4_Raw))



aug13ecu3 <- data.frame("Day" = "Aug13", "Sample" = "ecu3", "Avg_iCH4")            which(ecuaug13$Sample == "ecu3")






