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

write.csv(allecu30sec, here("Picarro/EOSTransects/ecuaveragesamples_30seconds.csv"))


samplenumber <- read.csv(here("Picarro/EOSTransects/samplenumbers_30seconds.csv"))

totalecu <- cbind(allecu30sec, samplenumber)
write.csv(totalecu, here("Picarro/EOSTransects/ecuavg30secwithsamplenumbers.csv"))
totalecu <- read.csv(here("Picarro/EOSTransects/ecuavg30secwithsamplenumbers.csv"))

#ok now let's calculate standard error 
stderror <- data.frame(totalecu$StdDev_iCO2/sqrt(totalecu$SampleNumber))
stderror$stderror <-- as.numeric(stderror$totalecu.StdDev_iCO2.sqrt.totalecu.SampleNumber.)
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
  select(Day, Sample, datesample, SampleNumber, Avg_iCO2, StdDev_iCO2, stderror, lowbound, highbound)

#save this 

write.csv(totalecu, here("Picarro/EOSTransects/statsecusamples_30seconds.csv"))
totalecu <- read.csv(here("Picarro/EOSTransects/statsecusamples_30seconds.csv"))
#let's graph this
# Use geom_pointrange
stderrorplot <- ggplot(totalecu, aes(x=datesample, y=Avg_iCO2, color=Day)) + 
  geom_pointrange(aes(ymin=lowbound, ymax=highbound)) +
  ggtitle("Avg_iCO2_30second with 95% Confidence Intervals") 
stderrorplot


## ok now let's try to figure out this percent error situation 


# first let's make a column that represents 1% of the average value 

onepercent <- data.frame(totalecu$datesample, c(totalecu$Avg_iCO2/100), totalecu$stderror)

onepercent$BelowCutoff <- as.character("yes")
#onepercent$BelowCutoff[5] <- "no"
#onepercent$BelowCutoff[13] <- "no"

onepercent$DateSample <- as.character(onepercent$totalecu.datesample)
onepercent$Avg_ico2 <- as.character(onepercent$c.totalecu.Avg_iCO2.100.)
onepercent$stderror <- as.character(onepercent$totalecu.stderror)

onepercent <- onepercent %>%
  select(DateSample, Avg_ico2, stderror,BelowCutoff)

write.csv(onepercent, here("Picarro/EOSTransects/oneperecenttest_samples30seconds.csv"))
