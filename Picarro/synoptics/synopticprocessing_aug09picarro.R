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

### Get a list of all the files
aug09_Files <- list.files(here::here("2019 picarro/08/09"),pattern = '.dat')

#create an empty data.frame
allaug09Data <- read.table(here::here("2019 picarro/08/09",aug09_Files[1]), header= TRUE)


# Combine all aug09 data
for(i in 2:length(aug09_Files)){
  file <- aug09_Files[i]
  data <- read.table(here::here("2019 picarro/08/09",file), header = TRUE)
  allaug09Data <- rbind(allaug09Data,data)
}

# Combine Date and time into one column
allaug09Data$DateTime <- paste0(allaug09Data$DATE," ",substr(allaug09Data$TIME,1,8))

# Convert to PosixCT
allaug09Data$PosixCT <- as.POSIXct(allaug09Data$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#make posic.ct, posixct again
allaug09Data$PosixCT <- as.POSIXct(allaug09Data$PosixCT)

#only take what you need
allaug09 <- allaug09Data %>%
  select(DATE, PosixCT, X12CO2, Delta_Raw_iCO2, Delta_30s_iCO2,HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)

#savethis
write.csv(allaug09, here("Picarro/synoptics/080619/allrawaug09data.csv"))

#subset the data
subsaug09 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 14:15:00"
                 & allaug09$PosixCT < "2019-08-09 15:30:00"), ]
#savethis
write.csv(subsaug09, here("Picarro/synoptics/080619/subsaug12.csv"))

#Do an initial plot of Delta_i 
plot <- ggplot(subsaug09)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2), color="blue")+
  geom_point(aes(x= PosixCT, y= Delta_30s_iCO2), color="red")+
  labs(x = "Time", y = "Delta")+
  ggtitle("August 6 Synoptics Delta Co2 Raw and 30 seconds") 

plot
ggplotly(plot)

#Now let's get the exact sample times that we need for 30 seconds 


syn1 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 14:20:41"
                        & allaug09$PosixCT < "2019-08-09 14:23:41"), ]
syn1$Sample <- as.character("syn1")

syn5 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 14:26:23"
                        & allaug09$PosixCT < "2019-08-09 14:28:57"), ]
syn5$Sample <- as.character("syn5")

syn8 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 14:37:02"
                         & allaug09$PosixCT < "2019-08-09 14:39:32"), ]
syn8$Sample <- as.character("syn8")

ecu3 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 14:41:06"
                        & allaug09$PosixCT < "2019-08-09 14:43:34"), ]
ecu3$Sample <- as.character("ecu3")

syn11 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 14:46:12"
                         & allaug09$PosixCT < "2019-08-09 14:47:20"), ]
syn11$Sample <- as.character("syn11")

syn14 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 14:49:49"
                         & allaug09$PosixCT < "2019-08-09 14:51:06"), ]
syn14$Sample <- as.character("syn14")

synBW <- allaug09[ which(allaug09$PosixCT > "2019-08-09 14:53:54"
                         & allaug09$PosixCT < "2019-08-09 14:55:29"), ]
synBW$Sample <- as.character("synBW")

syn20 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 14:57:05"
                         & allaug09$PosixCT < "2019-08-09 14:58:04"), ]
syn20$Sample <- as.character("syn20")

syn23 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 15:06:51"
                         & allaug09$PosixCT < "2019-08-09 15:10:14"), ]
syn23$Sample <- as.character("syn23")

syn29 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 15:13:14"
                         & allaug09$PosixCT < "2019-08-09 15:14:34"), ]
syn29$Sample <- as.character("syn29")

samplesaug09 <- rbind(syn1, syn5, syn8, syn11, syn14, synBW, syn20, syn23, syn29, ecu3)

write.csv(samplesaug09, here("Picarro/synoptics/080619/", "samplesalldataaug09.csv"))



#let's get the average and std. deviation of all ecu samples 

ecu3avg <- data.frame("Sample" = "ecu3", "Avg_iCO2" = mean(ecu3$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu3$Delta_30s_iCO2))

#save this 

write.csv(ecu3, here("Picarro/synoptics/080619/", "rawecuaug09.csv"))



write.csv(ecu3avg, here("Picarro/synoptics/080619/", "sumecuaug09.csv"))



write.csv(ecu3avg, here("Picarro/synoptics/080619/", "aug09alldayecuavg.csv"))

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


sumaug09_30 <- rbind(syn1avg, syn5avg, syn8avg, syn11avg, syn14avg, synBWavg, syn20avg, syn23avg, syn29avg)

write.csv(sumaug09_30, here("Picarro/synoptics/080619/", "sumaug09_30sec_uncorrected.csv"))

#let's do a quick plot 
plot2 <- ggplot(sumaug09_30)+
  geom_point(aes(x=Sample, y=Avg_iCO2), color="purple", size=4)+
  labs(x="synoptic point", y="Delta_30s_Avg")+
  ggtitle("august 12 Synoptic Pull Averages")
plot2
ggplotly(plot2)



#ok now let's do the correction 

sumaug09_30$Correction <- as.numeric("0.734068306")
sumaug09_30$CorrectedAverage <- as.numeric(c(sumaug09_30$Avg_iCO2 + sumaug09_30$Correction))

write.csv(sumaug09_30, here("Picarro/synoptics/080619/", "sumaug09_30sec_corrected.csv"))



