library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)


allecuavg <- read.csv(here("Picarro/EOSTransects/allecuavg.csv"))
comboecuavg <- read.csv(here("Picarro/EOSTransects/comboecuavg.csv"))

#ok first we need to add a sample size column to the table  

rawdata <- read.csv(here("Picarro/EOSTransects/allecusamples_raw.csv"))

samplenumber <- read.csv(here("Picarro/EOSTransects/samplenumbers.csv"))
                         
totalecu <- cbind(allecuavg, samplenumber)

#ok now let's calculate standard error 
stderror <- data.frame(totalecu$StdDev_iCO2/sqrt(totalecu$sampleNumber))
stderror$stderror <-- as.numeric(stderror$totalecu.StdDev_iCO2.sqrt.totalecu.sampleNumber.)
stderror <- stderror %>%
  select(stderror)

#let's add that to the full table

totalecu <- cbind(totalecu, stderror)

#95% confidence intervals of the mean
c(totalecu$Avg_iCO2-(2*stderror$stderror), totalecu$Avg_iCO2+(2*stderror$stderror))

totalecu$lowbound <- c(totalecu$Avg_iCO2-(2*stderror$stderror))
totalecu$highbound <- c(totalecu$Avg_iCO2+(2*stderror$stderror))

#reorg table 
totalecu<- totalecu %>%
  select(Day, Sample, sampleNumber, Avg_iCO2, StdDev_iCO2, stderror, lowbound, highbound)

#save this 

write.csv(totalecu, here("Picarro/EOSTransects/statsecusamples.csv"))


