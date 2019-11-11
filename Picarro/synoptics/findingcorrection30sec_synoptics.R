library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)

#first let's load the comboecu file 

#for per day
comboecuclean30 <- read.csv(here("Picarro/synoptics/statsecusamples_day30sec_clean.csv"))

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
combocorrect$EcuLinearityAvg[3] <- as.numeric("-23.62")
combocorrect$EcuLinearityAvg[4] <- as.numeric("-23.62")

#save this 

write.csv(combocorrect, here("Picarro/synoptics", "fullday30seccorrection_synoptics.csv"))

#ok now let's find the daily correction 

combocorrect$EcuLinearityAvg <- as.numeric(combocorrect$EcuLinearityAvg)
combocorrect$Avg_iCO2 <- as.numeric(combocorrect$Avg_iCO2)




combocorrect$DailyCorrection <- as.numeric(c(combocorrect$EcuLinearityAvg - combocorrect$Avg_iCO2))

#save this 

write.csv(combocorrect, here("Picarro/synoptics/", "30secdailycorrections_synoptics.csv"))


pbetter2 <- ggplot(sumalltransects, aes(x= Sample, y= CorrectedAverage, color=day))+
  geom_point(size=8)+
  geom_line()+
  xlab('Collar') +
  ylab('Delta30_Avg') +
  ggtitle("EOS Delta30 i_CO2 Corrected Summary") +
  scale_color_manual(values=wes_palette("Zissou1", n=6, type = c("continuous")))+
  theme(legend.position = "right")
pbetter2
