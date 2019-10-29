library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)
library('knitr')

#first let's load the comboecu file 

#for per day
comboecu30 <- read.csv(here("Picarro/EOSTransects/statsecusamples_day30sec.csv"))
comboecuclean30 <- read.csv(here("Picarro/EOSTransects/statsecusamples_day30sec_clean.csv"))

#ok all we want in this table is avg, low bound, high bound, eculinearity, correction, ecuavg first day, ecu avg 2nd day 

combocorrect <- comboecuclean30 %>%
  select(Day, Avg_iCO2, lowbound, highbound)

#add in the ecu linearity 



