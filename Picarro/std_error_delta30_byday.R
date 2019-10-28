library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

totalecu <- read.csv(here("Picarro/EOSTransects/ecuavg30secwithsamplenumbers.csv"))

ecu2avg <- data.frame("Sample" = "ecu2", "Avg_iCO2" = mean(ecu2$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu2$Delta_30s_iCO2))
ecu3avg <- data.frame("Sample" = "ecu3", "Avg_iCO2" = mean(ecu3$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu3$Delta_30s_iCO2))