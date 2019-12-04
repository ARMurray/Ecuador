library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#let's call all of the day summaries and combine them into one and call it comboecuavg

july19 <- read.csv(here("Picarro/synoptics/071819/", "july19alldayecuavg.csv"))
aug02 <- read.csv(here("Picarro/synoptics/073119/", "aug02alldayecuavg.csv"))
aug09 <- read.csv(here("Picarro/synoptics/080619/", "aug09alldayecuavg.csv"))
aug09$Day <- as.character("aug09")
aug09 <- aug09 %>%
  select(X, Day, Avg_iCO2, StdDev_iCO2)
aug13 <- read.csv(here("Picarro/synoptics/081219/", "Aug13alldayecuavg.csv"))


comboecuavg <- rbind(july19, aug02, aug09, aug13)

write.csv(comboecuavg, here("Picarro/synoptics/", "ecuaverageperdaysynoptic_30sec.csv"))

number_day <- read.csv(here("Picarro/synoptics/ecunumbers.csv"))

comboecu <- cbind(comboecuavg, number_day)
comboecu$Avg_iCO2 <- as.numeric(comboecu$Avg_iCO2)
comboecu$StdDev_iCO2 <- as.numeric(comboecu$StdDev_iCO2)
comboecu$number <- as.numeric(comboecu$number)



#ok now let's calculate standard error 
erorday <- data.frame(comboecu$StdDev_iCO2/sqrt(comboecu$number))
erorday$stderror <-- as.numeric(erorday$comboecu.StdDev_iCO2.sqrt.comboecu.number.)
erorday <- erorday %>%
  select(stderror)

#let's add that to the full table

comboecu <- cbind(comboecu, erorday)

#95% confidence intervals of the mean
c(comboecu$Avg_iCO2-(2*comboecu$stderror), comboecu$Avg_iCO2+(2*comboecu$stderror))

comboecu$lowbound <- c(comboecu$Avg_iCO2-(2*comboecu$stderror))
comboecu$highbound <- c(comboecu$Avg_iCO2+(2*comboecu$stderror))

write.csv(comboecu, here("Picarro/synoptics/statsecusamples_day30sec.csv"))

comboecuclean <- comboecu %>%
  select(Day, number, Avg_iCO2, stderror, lowbound, highbound)

write.csv(comboecuclean, here("Picarro/synoptics/statsecusamples_day30sec_clean.csv"))


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

write.csv(day, here("Picarro/synoptics/oneperecenttest_days30sec_1aug09.csv"))
