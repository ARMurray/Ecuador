library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)

#first let's load the comboecu file 

#for per day
comboecu30 <- read.csv(here("Picarro/EOSTransects/statsecusamples_day30sec.csv"))
comboecuclean30 <- read.csv(here("Picarro/EOSTransects/statsecusamples_day30sec_clean.csv"))

#ok all we want in this table is avg, low bound, high bound, eculinearity, correction, ecuavg first day, ecu avg 2nd day 

combocorrect <- comboecuclean30 %>%
  select(Day, Avg_iCO2, lowbound, highbound)

#let's look at the ecu linearity tables 

july15test <- read.csv(here("Picarro/Linearity/july15linearity.csv"), header = TRUE)
july15test$CHCorrection <- as.numeric("1.57")

aug09test <- read.csv(here("Picarro/Linearity/aug09linearity.csv"), header = TRUE)
aug09test$Correction <- as.numeric("1.22")

#ok now let's put that into the combocorrect table 

combocorrect$EcuLinearityAvg <- as.numeric("-24.74")
combocorrect$EcuLinearityAvg[5] <- as.numeric("-23.62")
combocorrect$EcuLinearityAvg[6] <- as.numeric("-23.62")

#save this 

write.csv(combocorrect, here("Picarro/", "fullday30seccorrection.csv"))

#ok now let's find the daily correction 

combocorrect$DailyCorrection <- as.numeric(combocorrect$)




