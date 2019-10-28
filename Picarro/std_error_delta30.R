library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#read in all the ecu average files and add a day column to each 

july17 <- read.csv(here("Picarro/EOSTransects/071619/sumecujuly17.csv"))
july17$Day <- as.character("july17")
july17 <- july17 %>%
  select(Day, Sample, Avg_iCO2, StdDev_iCO2)

july23 <- read.csv(here("Picarro/EOSTransects/072219/sumecujuly23.csv"))
july23$Day <- as.character("july23")
july23 <- july23 %>%
  select(Day, Sample, Avg_iCO2, StdDev_iCO2)


july30 <- read.csv(here("Picarro/EOSTransects/072919/sumecujuly30.csv"))
july30$Day <- as.character("july30")
july30 <- july30 %>%
  select(Day, Sample, Avg_iCO2, StdDev_iCO2)


aug02 <- read.csv(here("Picarro/EOSTransects/080119/sumecuaug02.csv"))
aug02$Day <- as.character("aug02")
aug02 <- aug02 %>%
  select(Day, Sample, Avg_iCO2, StdDev_iCO2)


aug09 <- read.csv(here("Picarro/EOSTransects/080819/sumecuaug09.csv"))
aug09$Day <- as.character("aug09")
aug09 <- aug09 %>%
  select(Day, Sample, Avg_iCO2, StdDev_iCO2)


aug13 <- read.csv(here("Picarro/EOSTransects/081319/sumecuaug13.csv"))
aug13$Day <- as.character("aug13")
aug13 <- aug13 %>%
  select(Day, Sample, Avg_iCO2, StdDev_iCO2)


#combine them all
allecu30sec <- rbind(july17, july23, july30, aug02, aug09, aug13)