library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library('knitr')

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

ecuaug13 <- read.csv(here("Picarro/EOSTransects/081319/aug13ecuwithco2.csv"))
ecujuly17 <- read.csv(here("Picarro/EOSTransects/071619/july17ecuwithco2.csv"))
ecujuly23 <- read.csv(here("Picarro/EOSTransects/072219/july23ecuwithco2.csv"))
ecujuly30 <- read.csv(here("Picarro/EOSTransects/072919/july30ecuwithco2.csv"))
ecuaug02 <- read.csv(here("Picarro/EOSTransects/080119/aug02ecuwithco2.csv"))
ecuaug09 <- read.csv(here("Picarro/EOSTransects/080819/aug09ecuwithco2.csv"))

ecujuly30 <- ecujuly30[ which(ecujuly30$Sample == "ecu2"
                            | ecujuly30$Sample == "ecu1"), ]

ecujuly30$Day <- as.character("July30")

write.csv(ecuaug09, here("Picarro/EOSTransects/080819/aug09ecuwithco2.csv"))

ecuaug13 <- ecuaug13 %>%
  select(PosixCT, Day, Sample, X12CO2, Delta_Raw_iCO2)

#make posic.ct, posixct again
onlyecuall$PosixCT <- as.POSIXct(onlyecuall$PosixCT)

onlyecuall <- rbind(ecuaug02, ecuaug09, ecuaug13, ecujuly17, ecujuly23, ecujuly30)



write.csv(onlyecuall, here("Picarro/EOSTransects", "allecusamples_rawc02.csv"))


#ok now let's find the mean of each ecu sample 
#what we want at the end is a table with the mean, day, sample, std dev, and variance 


col1avg <- data.frame("Sample" = "col1", "Avg_iCH4" = mean(col1$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col1$Delta_iCH4_Raw))



july17ecu3 <- data.frame("Day" = "july17", "Sample" = "ecu3", "Avg_iCO2" = mean(ecujuly17$Delta_Raw_iCO2[ which(ecujuly17$Sample == "ecu3")]),
                       "StdDev_iCO2" = sd(ecujuly17$Delta_Raw_iCO2[ which(ecujuly17$Sample == "ecu3")]))         
july17ecu2 <- data.frame("Day" = "july17", "Sample" = "ecu2", "Avg_iCO2" = mean(ecujuly17$Delta_Raw_iCO2[ which(ecujuly17$Sample == "ecu2")]),
                        "StdDev_iCO2" = sd(ecujuly17$Delta_Raw_iCO2[ which(ecujuly17$Sample == "ecu2")]))
#july17ecu1 <- data.frame("Day" = "july17", "Sample" = "ecu1", "Avg_iCO2" = mean(ecujuly17$Delta_Raw_iCO2[ which(ecujuly17$Sample == "ecu1")]),
                        # "StdDev_iCO2" = sd(ecujuly17$Delta_Raw_iCO2[ which(ecujuly17$Sample == "ecu1")]))
avgjuly17 <- rbind(july17ecu2, july17ecu3)

allecuavg <- rbind(avgjuly17, avgjuly23, avgjuly30, avgaug02, avgaug09, avgaug13)

write.csv(allecuavg, here("Picarro/EOSTransects/allecuavg.csv"))

comboaug13 <- data.frame("Day" = "aug13", "Bags" = "2", "Avg_iCO2" = mean(avgaug13$Avg_iCO2),
                          "StdDev_iCO2" = sd(avgaug13$Avg_iCO2)) 

allday <- rbind(combojuly17, combojuly23, combojuly30, comboaug02, comboaug09, comboaug13)

allday$EcuLinearityAvg <- "-24.74"

allday$Correction <- (allday$Avg_iCO2test - allday$EcuLinearityAvg)

allday$Avg_iCO2test <- as.numeric(as.character(allday$Avg_iCO2))
allday$EcuLinearityAvg <- as.numeric(as.character(allday$EcuLinearityAvg))

allday <- allday %>%
  select(Day, Bags, Avg_iCO2, StdDev_iCO2, EcuLinearityAvg, Correction)
allday$Avg_iCO2 <- allday$Avg_iCO2test

ecuaug13 <- ecuaug13 %>%
  select(PosixCT, Day, Sample, X12CO2, Delta_Raw_iCO2)

write.csv(allday, here("Picarro/EOSTransects/comboecuavg.csv"))

July15test <- data.frame("CHKnown Value" = "-11.09", "CHPicarro" = "-12.66", "CI" = "+/- .314", "CHCorrected Avg" = "-11.09",
                         "Correction" = "-1.57", "ECUPicarro" = "-26.31", "CI" = "+/-.196", "ECUCorrected Avg" = "-24.74")

write.csv(July15test, here("Picarro/EOSTransects/july15test.csv"))

