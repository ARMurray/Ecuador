library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)

july17 <- read.csv(here("Picarro/EOSTransects/071619/allsamplesjuly17.csv"))

#make posic.ct, posixct again
july17$PosixCT <- as.POSIXct(july17$PosixCT)

july17$Sample <- as.character(july17$Sample)

Ecujuly17 <- july17[ which(july17$Sample == "ecu2"
                           | july17$Sample == "ecu3"
                           | july17$Sample == "ecu4"), ]
                          
Ecujuly17$Day <- as.character("July17")

write.csv(Ecujuly17, here("Picarro/EOSTransects/071619/", "ecusamplesjuly17.csv"))