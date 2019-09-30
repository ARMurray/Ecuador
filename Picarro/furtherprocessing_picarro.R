library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
alljuly17 <- read.csv(here("Ecuador/Picarro/EOSTransects/071619/alljuly17Data.csv"))

#make posic.ct, posixct again
alljuly17$PosixCT <- as.POSIXct(alljuly17$PosixCT)

#Do an initial plot of C02 
plot <- ggplot(alljuly17)+
geom_point(aes(x= PosixCT, y= X12CO2)) +
labs(x = "Time", y = "CO2") +
ggtitle("july17 EOS Transect Pulls") 
plot

#Do an initial plot of Delta_i 
plot <- ggplot(Subsjuly17)+
geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2)) +
labs(x = "Time", y = "Delta_Raw") +
ggtitle("July17 EOS Transect Pulls") 

plot
ggplotly(plot)


Subsjuly17 <- alljuly17[c(70400:83600), ]

col1 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:11:00"
                                     & alljuly17$PosixCT < "2019-07-17 18:14:15"), ]

