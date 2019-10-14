library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)


allecuavg <- read.csv(here("Picarro/EOSTransects/allecuavg.csv"))
comboecuavg <- read.csv(here("Picarro/EOSTransects/comboecuavg.csv"))

#ok first we need to add a sample size column to the table  

rawdata <- read.csv(here("Picarro/EOSTransects/allecusamples_raw.csv"))

Samplenumber <-- data.frame()

