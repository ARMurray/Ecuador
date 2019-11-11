library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
allaug13 <- read.csv(here("Picarro/EOSTransects/081319/comprehensiveaug13.csv"))

# Combine Date and time into one column
allaug13$DateTime <- paste0(allaug13$DATE," ",substr(allaug13$TIME,1,8))

# Convert to PosixCT
allaug13$PosixCT <- as.POSIXct(allaug13$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#make posic.ct, posixct again
allaug13$PosixCT <- as.POSIXct(allaug13$PosixCT)

#only take what you need
allaug13 <- allaug13 %>%
  select(DATE, PosixCT, X12CO2, Delta_Raw_iCO2, Delta_30s_iCO2,HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)

#savethis
#write new name for this here

#subset the data
subsaug13 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 18:30:00"
                 & allaug13$PosixCT < "2019-08-13 20:30:00"), ]
#savethis
write.csv(subsaug13, here("Picarro/synoptics/081219/subsaug12.csv"))

#Do an initial plot of Delta_i 
plot <- ggplot(subsaug13)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2), color="blue")+
  geom_point(aes(x= PosixCT, y= Delta_30s_iCO2), color="red")+
  labs(x = "Time", y = "Delta")+
  ggtitle("August 12 Synoptics Delta Co2 Raw and 30 seconds") 

plot
ggplotly(plot)

#Now let's get the exact sample times that we need for 30 seconds 

ecu1 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 18:51:47"
                        & allaug13$PosixCT < "2019-08-13 18:52:15"), ]
ecu1$Sample <- as.character("ecu1")

syn1 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 19:11:51"
                        & allaug13$PosixCT < "2019-08-13 19:13:09"), ]
syn1$Sample <- as.character("syn1")

syn5 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 19:20:08"
                        & allaug13$PosixCT < "2019-08-13 19:21:56"), ]
syn5$Sample <- as.character("syn5")

syn8 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 19:25:56"
                         & allaug13$PosixCT < "2019-08-13 19:28:02"), ]
syn8$Sample <- as.character("syn8")

syn11 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 19:33:11"
                         & allaug13$PosixCT < "2019-08-13 19:35:03"), ]
syn11$Sample <- as.character("syn11")

syn14 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 19:41:14"
                         & allaug13$PosixCT < "2019-08-13 19:42:31"), ]
syn14$Sample <- as.character("syn14")

ecu2 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 19:48:26"
                        & allaug13$PosixCT < "2019-08-13 19:49:45"), ]
ecu2$Sample <- as.character("ecu2")

synBW <- allaug13[ which(allaug13$PosixCT > "2019-08-13 19:54:40"
                         & allaug13$PosixCT < "2019-08-13 19:56:44"), ]
synBW$Sample <- as.character("synBW")

syn20 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 20:01:35"
                         & allaug13$PosixCT < "2019-08-13 20:02:45"), ]
syn20$Sample <- as.character("syn20")

syn23 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 20:08:40"
                         & allaug13$PosixCT < "2019-08-13 20:09:46"), ]
syn23$Sample <- as.character("syn23")

syn29 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 20:16:30"
                         & allaug13$PosixCT < "2019-08-13 20:18:15"), ]
syn29$Sample <- as.character("syn29")

syn35 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 20:23:52"
                         & allaug13$PosixCT < "2019-08-13 20:25:20"), ]
syn35$Sample <- as.character("syn35")

samplesaug13 <- rbind(syn1, syn5, syn8, syn11, syn14, synBW, syn20, syn23, syn29, syn35, ecu1, ecu2)

write.csv(samplesaug13, here("Picarro/synoptics/081219/", "samplesalldataaug13.csv"))



#let's get the average and std. deviation of all ecu samples 

ecu1avg <- data.frame("Sample" = "ecu1", "Avg_iCO2" = mean(ecu1$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu1$Delta_30s_iCO2))
ecu2avg <- data.frame("Sample" = "ecu2", "Avg_iCO2" = mean(ecu2$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu2$Delta_30s_iCO2))

sumaug13ecu <- rbind(ecu1avg, ecu2avg)

write.csv(sumaug13ecu, here("Picarro/synoptics/081219/", "sumecuaug13.csv"))


#now let's get the ecuador averages for this day combinded

#First let's make a table with just the ecu samples

ecutogether <- rbind(ecu1, ecu2)

#save this 

write.csv(ecutogether, here("Picarro/synoptics/081219/", "rawecuaug13.csv"))


Aug13avg <- data.frame("Day" = "Aug13", "Avg_iCO2" = mean(ecutogether$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecutogether$Delta_30s_iCO2))

write.csv(Aug13avg, here("Picarro/synoptics/081219/", "Aug13alldayecuavg.csv"))

#ok we need to get a summary table just for the collars for each day 

#ok now let's find the average and std. deviation for each bag pull and put that into a new data frame



syn1avg <- data.frame("Sample" = "syn1", "Avg_iCO2" = mean(syn1$Delta_30s_iCO2), "StdDev_iCO2" = sd(syn1$Delta_30s_iCO2))
syn5avg <- data.frame("Sample" = "syn5", "Avg_iCO2" = mean(syn5$Delta_30s_iCO2), "StdDev_iCO2" = sd(syn5$Delta_30s_iCO2))
syn8avg <- data.frame("Sample" = "syn8", "Avg_iCO2" = mean(syn8$Delta_30s_iCO2), "StdDev_iCO2" = sd(syn8$Delta_30s_iCO2))
syn11avg <- data.frame("Sample" = "syn11", "Avg_iCO2" = mean(syn11$Delta_30s_iCO2), "StdDev_iCO2" = sd(syn11$Delta_30s_iCO2))
syn14avg <- data.frame("Sample" = "syn14", "Avg_iCO2" = mean(syn14$Delta_30s_iCO2), "StdDev_iCO2" = sd(syn14$Delta_30s_iCO2))
synBWavg <- data.frame("Sample" = "synBW", "Avg_iCO2" = mean(synBW$Delta_30s_iCO2), "StdDev_iCO2" = sd(synBW$Delta_30s_iCO2))
syn20avg <- data.frame("Sample" = "syn20", "Avg_iCO2" = mean(syn20$Delta_30s_iCO2), "StdDev_iCO2" = sd(syn20$Delta_30s_iCO2))
syn23avg <- data.frame("Sample" = "syn23", "Avg_iCO2" = mean(syn23$Delta_30s_iCO2), "StdDev_iCO2" = sd(syn23$Delta_30s_iCO2))
syn29avg <- data.frame("Sample" = "syn29", "Avg_iCO2" = mean(syn29$Delta_30s_iCO2), "StdDev_iCO2" = sd(syn29$Delta_30s_iCO2))
syn35avg <- data.frame("Sample" = "syn35", "Avg_iCO2" = mean(syn35$Delta_30s_iCO2), "StdDev_iCO2" = sd(syn35$Delta_30s_iCO2))

sumaug13_30 <- rbind(syn1avg, syn5avg, syn8avg, syn11avg, syn14avg, synBWavg, syn20avg, syn23avg, syn29avg, syn35avg)

write.csv(sumaug13_30, here("Picarro/synoptics/081219/", "sumaug13_30sec_uncorrected.csv"))

#let's do a quick plot 
plot2 <- ggplot(sumaug13_30)+
  geom_point(aes(x=Sample, y=Avg_iCO2), color="purple", size=4)+
  labs(x="synoptic point", y="Delta_30s_Avg")+
  ggtitle("august 12 Synoptic Pull Averages")
plot2
ggplotly(plot2)



#ok now let's do the correction 

sumaug13_30$Correction <- as.numeric("0.734068306")
sumaug13_30$CorrectedAverage <- as.numeric(c(sumaug13_30$Avg_iCO2 + sumaug13_30$Correction))

write.csv(sumaug13_30, here("Picarro/synoptics/081219/", "sumaug13_30sec_corrected.csv"))



