#install.packages("tmaptools")
#install.packages("ggplot2")
#install.packages("here")
#install.packages("dplyr")
#install.packages("plotly")
#install.packages("wesanderson")

library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

dis35 <- 0 

dis29 <- 37.4 

dis23 <- 75.9 

dis20 <- 94.1 

waterfalldis <- 126 

dis14 <- 143.7 

dis11 <- 169.9 

dis8 <- 194.9 

dis5 <- 217.6 

dis1<- 245.2 

dis <- data.frame(Distance = c(dis35, dis29, dis23, dis20, waterfalldis, dis14, dis11, dis8, dis5, dis1)) 

rownames(dis) <- c("syn35", "syn29", "syn23", "syn20", "synBW", "syn14", "syn11", "syn8", "syn 5", "syn1") 

c <- cbind(a,dis) 

#read in data for every day 

july18 <- read.csv(here("Picarro/synoptics/071819/sumjuly19_30sec_corrected.csv"))
july31 <- read.csv(here("Picarro/synoptics/073119/sumaug02_30sec_corrected.csv"))
aug06 <- read.csv(here("Picarro/synoptics/080619/sumaug09_30sec_corrected.csv"))
aug12 <- read.csv(here("Picarro/synoptics/081219/sumaug13_30sec_corrected.csv"))

#add day column 
july18$Day <- as.character("July18")
july31$Day <- as.character("July31")
aug06$Day <- as.character("Aug06")
aug12$Day <- as.character("Aug12")

#put it all together 

sumsynoptics <- rbind(july18, july31, aug06, aug12)

#save this 

write.csv(sumsynoptics, here("Picarro/synoptics/", "sumsynoptics_corrected.csv"))

#select just what we need,  find the syn avg and std deviation, and the coefficient of variation and relative standard deviation 
#save this 

july18 <- july18 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
july18total <- data.frame("Sample"= "Total", "Day" = "total", "CorrectedAverage" = mean(july18$CorrectedAverage), "StdDev_iCO2" = sd(july18$CorrectedAverage))
july18all <- rbind(july18, july18total)
july18all$CV <- july18all$StdDev_iCO2/july18all$CorrectedAverage
july18all$RelativeStdDev <- 100*(july18all$StdDev_iCO2/abs(july18all$CorrectedAverage))

write.csv(july18all, here("Picarro/synoptics/071819", "july18CV_statistics.csv"))

july31 <- july31 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
july31total <- data.frame("Sample"= "Total", "Day" = "total", "CorrectedAverage" = mean(july31$CorrectedAverage), "StdDev_iCO2" = sd(july31$CorrectedAverage))
july31all <- rbind(july31, july31total)
july31all$CV <- july31all$StdDev_iCO2/july31all$CorrectedAverage
july31all$RelativeStdDev <- 100*(july31all$StdDev_iCO2/abs(july31all$CorrectedAverage))

write.csv(july31all, here("Picarro/synoptics/073119", "july31CV_statistics.csv"))


aug06 <- aug06 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
aug06total <- data.frame("Sample"= "Total", "Day" = "total", "CorrectedAverage" = mean(aug06$CorrectedAverage), "StdDev_iCO2" = sd(aug06$CorrectedAverage))
aug06all <- rbind(aug06, aug06total)
aug06all$CV <- aug06all$StdDev_iCO2/aug06all$CorrectedAverage
aug06all$RelativeStdDev <- 100*(aug06all$StdDev_iCO2/abs(aug06all$CorrectedAverage))

write.csv(aug06all, here("Picarro/synoptics/080619", "aug06CV_statistics.csv"))

aug12 <- aug12 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
aug12total <- data.frame("Sample"= "Total", "Day" = "total", "CorrectedAverage" = mean(aug12$CorrectedAverage), "StdDev_iCO2" = sd(aug12$CorrectedAverage))
aug12all <- rbind(aug12, aug12total)
aug12all$CV <- aug12all$StdDev_iCO2/aug12all$CorrectedAverage
aug12all$RelativeStdDev <- 100*(aug12all$StdDev_iCO2/abs(aug12all$CorrectedAverage))

write.csv(aug12all, here("Picarro/synoptics/071819", "aug12CV_statistics.csv"))

#alright now let's combine these all together 

allsynCV <- rbind(july18all, july31all, aug06all, aug12all)

#save this 

write.csv(allsynCV, here("Picarro/synoptics", "allsynCV_statscorrected.csv"))

#ok now let's do plots per day with the error bars using the corrected distance 




