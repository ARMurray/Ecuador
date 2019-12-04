library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)

aug13 <- read.csv(here("Picarro/EOSTransects/081319/allsamplesaug13.csv"))

#make posic.ct, posixct again
aug13$PosixCT <- as.POSIXct(aug13$PosixCT)

aug13$Sample <- as.character(aug13$Sample)

Ecuaug13 <- aug13[ which(aug13$Sample == "ecu3"
                           | aug13$Sample == "ecu4"), ]
                           #| aug13$Sample == "ecu1"), ]
                          
Ecuaug13$Day <- as.character("aug13")

#write.csv(Ecuaug13, here("Picarro/EOSTransects/081319/", "ecusamplesaug13.csv"))
