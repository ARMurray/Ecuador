library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#let's call all of the day summaries and combine them into one and call it comboecuavg

july17 <- read.csv(here("Picarro/EOSTransects/071619/", "July17alldayecuavg.csv"))
july23 <- read.csv(here("Picarro/EOSTransects/072219/", "July23alldayecuavg.csv"))
july23$Day <- as.character("July23")
july30 <- read.csv(here("Picarro/EOSTransects/072919/", "July30alldayecuavg.csv"))
aug02 <- read.csv(here("Picarro/EOSTransects/080119/", "Aug02alldayecuavg.csv"))
aug09 <- read.csv(here("Picarro/EOSTransects/080819/", "Aug09alldayecuavg.csv"))
aug13 <- read.csv(here("Picarro/EOSTransects/081319/", "Aug13alldayecuavg.csv"))


comboecuavg <- rbind(july17, july23, july30, aug02, aug09, aug13)

write.csv(comboecuavg, here("Picarro/EOSTransects/", "averageecuperday_30sec.csv"))

samplenumber_day <- read.csv(here("Picarro/EOSTransects/samplenumbers_30secdays.csv"))

comboecu <- cbind(comboecuavg, samplenumber_day)

#ok now let's calculate standard error 
erorday <- data.frame(comboecu$StdDev_iCO2/sqrt(comboecu$SampleNumber))
erorday$stderror <-- as.numeric(erorday$comboecu.StdDev_iCO2.sqrt.comboecu.SampleNumber.)
erorday <- erorday %>%
  select(stderror)

#let's add that to the full table

comboecu <- cbind(comboecu, erorday)

#95% confidence intervals of the mean
c(comboecu$Avg_iCO2-(2*comboecu$stderror), comboecu$Avg_iCO2+(2*comboecu$stderror))

comboecu$lowbound <- c(comboecu$Avg_iCO2-(2*comboecu$stderror))
comboecu$highbound <- c(comboecu$Avg_iCO2+(2*comboecu$stderror))

write.csv(comboecu, here("Picarro/EOSTransects/statsecusamples_day30sec.csv"))

comboecuclean <- comboecu %>%
  select(Day, SampleNumber, Avg_iCO2, stderror, lowbound, highbound)

write.csv(comboecuclean, here("Picarro/EOSTransects/statsecusamples_day30sec_clean.csv"))


#let's graph this
# Use geom_pointrange
stderrorplot2 <- ggplot(comboecu, aes(x=Day, y=Avg_iCO2, color=Day)) + 
  geom_pointrange(aes(ymin=lowbound, ymax=highbound), size=1) +
  ggtitle("Avg_iCO2 per Day 95% Confidence Intervals") 
stderrorplot2


#1% situation 

## ok now let's do the same thing but per day 

day <- data.frame(comboecuclean$Day, c(comboecuclean$Avg_iCO2/100), comboecuclean$stderror)
day$BelowCutoff <- as.character("yes")
day$Day <- as.character(day$comboecuclean.Day)
day$Avg_ico2 <- as.character(day$c.comboecuclean.Avg_iCO2.100.)
day$stderror <- as.character(day$comboecuclean.stderror)

day <- day %>%
  select(Day, Avg_ico2, stderror,BelowCutoff)

write.csv(day, here("Picarro/EOSTransects/oneperecenttest_days30sec.csv"))