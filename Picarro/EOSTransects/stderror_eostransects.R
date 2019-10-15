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

#make column combining day and sample 
totalecu$datesample <- paste(totalecu$Day, totalecu$Sample)

#reorg table 
totalecu<- totalecu %>%
  select(Day, Sample, datesample, sampleNumber, Avg_iCO2, StdDev_iCO2, stderror, lowbound, highbound)

#save this 

write.csv(totalecu, here("Picarro/EOSTransects/statsecusamples.csv"))

#let's graph this
# Use geom_pointrange
stderrorplot <- ggplot(totalecu, aes(x=datesample, y=Avg_iCO2, color=Day)) + 
  geom_pointrange(aes(ymin=lowbound, ymax=highbound)) +
  ggtitle("Avg_iCO2 with 95% Confidence Intervals") 
stderrorplot

#ok now let's do all of these same things but for each day instead 
 
samplenumber_day <- read.csv(here("Picarro/EOSTransects/samplenumbers_day.csv"))

comboecu <- cbind(comboecuavg, samplenumber_day)

#ok now let's calculate standard error 
erorday <- data.frame(comboecu$StdDev_iCO2/sqrt(comboecu$Sample.number.day))
erorday$stderror <-- as.numeric(erorday$comboecu.StdDev_iCO2.sqrt.comboecu.Sample.number.day.)
erorday <- erorday %>%
  select(stderror)

#let's add that to the full table

comboecu <- cbind(comboecu, erorday)

#95% confidence intervals of the mean
c(comboecu$Avg_iCO2-(2*comboecu$stderror), comboecu$Avg_iCO2+(2*comboecu$stderror))

comboecu$lowbound <- c(comboecu$Avg_iCO2-(2*comboecu$stderror))
comboecu$highbound <- c(comboecu$Avg_iCO2+(2*comboecu$stderror))

write.csv(comboecu, here("Picarro/EOSTransects/statsecusamples_day.csv"))

#let's graph this
# Use geom_pointrange
stderrorplot2 <- ggplot(comboecu, aes(x=Day, y=Avg_iCO2, color=Day)) + 
  geom_pointrange(aes(ymin=lowbound, ymax=highbound)) +
  ggtitle("Avg_iCO2 per Day 95% Confidence Intervals") 
stderrorplot2

