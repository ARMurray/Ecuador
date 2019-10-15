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

comboecuclean <- comboecu %>%
  select(Day, Avg_iCO2, stderror, lowbound, highbound)

write.csv(comboecuclean, here("Picarro/EOSTransects/statsecusamples_day_clean.csv"))


#let's graph this
# Use geom_pointrange
stderrorplot2 <- ggplot(comboecu, aes(x=Day, y=Avg_iCO2, color=Day)) + 
  geom_pointrange(aes(ymin=lowbound, ymax=highbound), size=10) +
  ggtitle("Avg_iCO2 per Day 95% Confidence Intervals") 
stderrorplot2


## ok now let's try to figure out this percent error situation 


# first let's make a column that represents 1% of the average value 

onepercent <- data.frame(totalecu$datesample, c(totalecu$Avg_iCO2/100), totalecu$stderror)

onepercent$BelowCutoff <- as.character("yes")
onepercent$BelowCutoff[5] <- "no"
onepercent$BelowCutoff[13] <- "no"

onepercent$DateSample <- as.character(onepercent$totalecu.datesample)
onepercent$Avg_ico2 <- as.character(onepercent$c.totalecu.Avg_iCO2.100.)
onepercent$stderror <- as.character(onepercent$totalecu.stderror)

onepercent <- onepercent %>%
  select(DateSample, Avg_ico2, stderror,BelowCutoff)

write.csv(onepercent, here("Picarro/EOSTransects/oneperecenttest_samples.csv"))


## ok now let's do the same thing but per day 

day <- data.frame(comboecu$Day, c(comboecu$Avg_iCO2/100), comboecu$stderror)
day$BelowCutoff <- as.character("yes")
day$Day <- as.character(day$comboecu.Day)
day$Avg_ico2 <- as.character(day$c.comboecu.Avg_iCO2.100.)
day$stderror <- as.character(day$comboecu.stderror)

day <- day %>%
  select(Day, Avg_ico2, stderror,BelowCutoff)

write.csv(day, here("Picarro/EOSTransects/oneperecenttest_days.csv"))
