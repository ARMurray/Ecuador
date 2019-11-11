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
aug02_Files <- list.files(here::here("2019 picarro/08/02"),pattern = '.dat')

#create an empty data.frame
allaug02Data <- read.table(here::here("2019 picarro/08/02",aug02_Files[1]), header= TRUE)


# Combine all aug02 data
for(i in 2:length(aug02_Files)){
  file <- aug02_Files[i]
  data <- read.table(here::here("2019 picarro/08/02",file), header = TRUE)
  allaug02Data <- rbind(allaug02Data,data)
}

# Combine Date and time into one column
allaug02Data$DateTime <- paste0(allaug02Data$DATE," ",substr(allaug02Data$TIME,1,8))

# Convert to PosixCT
allaug02Data$PosixCT <- as.POSIXct(allaug02Data$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#make posic.ct, posixct again
allaug02Data$PosixCT <- as.POSIXct(allaug02Data$PosixCT)

#only take what you need
allaug02 <- allaug02Data %>%
  select(DATE, PosixCT, X12CO2, Delta_Raw_iCO2, Delta_30s_iCO2,HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)

#savethis
write.csv(allaug02, here("Picarro/synoptics/073119/allrawAug02data.csv"))

#subset the data
subsaug02 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 17:00:00"
                 & allaug02$PosixCT < "2019-08-02 18:30:00"), ]
#savethis
write.csv(subsaug02, here("Picarro/synoptics/073119/subsaug12.csv"))

#Do an initial plot of Delta_i 
plot <- ggplot(subsaug02)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2), color="blue")+
  geom_point(aes(x= PosixCT, y= Delta_30s_iCO2), color="red")+
  labs(x = "Time", y = "Delta")+
  ggtitle("July 31 Synoptics Delta Co2 Raw and 30 seconds") 

plot
ggplotly(plot)

#Now let's get the exact sample times that we need for 30 seconds 

ecu1 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 17:19:13"
                        & allaug02$PosixCT < "2019-08-02 17:21:47"), ]
ecu1$Sample <- as.character("ecu1")

syn1 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 17:24:56"
                        & allaug02$PosixCT < "2019-08-02 17:27:26"), ]
syn1$Sample <- as.character("syn1")

syn5 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 17:31:15"
                        & allaug02$PosixCT < "2019-08-02 17:34:06"), ]
syn5$Sample <- as.character("syn5")

syn8 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 17:37:49"
                         & allaug02$PosixCT < "2019-08-02 17:40:06"), ]
syn8$Sample <- as.character("syn8")

syn11 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 17:42:30"
                         & allaug02$PosixCT < "2019-08-02 17:44:00"), ]
syn11$Sample <- as.character("syn11")

syn14 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 17:46:31"
                         & allaug02$PosixCT < "2019-08-02 17:48:44"), ]
syn14$Sample <- as.character("syn14")

ecu2 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 17:52:35"
                        & allaug02$PosixCT < "2019-08-02 17:54:16"), ]
ecu2$Sample <- as.character("ecu2")

synBW <- allaug02[ which(allaug02$PosixCT > "2019-08-02 17:56:22"
                         & allaug02$PosixCT < "2019-08-02 17:57:01"), ]
synBW$Sample <- as.character("synBW")

syn20 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 18:01:31"
                         & allaug02$PosixCT < "2019-08-02 18:04:30"), ]
syn20$Sample <- as.character("syn20")

syn23 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 18:07:13"
                         & allaug02$PosixCT < "2019-08-02 18:09:19"), ]
syn23$Sample <- as.character("syn23")

syn29 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 18:13:52"
                         & allaug02$PosixCT < "2019-08-02 18:16:13"), ]
syn29$Sample <- as.character("syn29")

syn35 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 18:19:02"
                         & allaug02$PosixCT < "2019-08-02 18:20:25"), ]
syn35$Sample <- as.character("syn35")

samplesaug02 <- rbind(syn1, syn5, syn8, syn11, syn14, synBW, syn20, syn23, syn29, syn35, ecu1, ecu2)

write.csv(samplesaug02, here("Picarro/synoptics/073119/", "samplesalldataaug02.csv"))



#let's get the average and std. deviation of all ecu samples 

ecu1avg <- data.frame("Sample" = "ecu1", "Avg_iCO2" = mean(ecu1$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu1$Delta_30s_iCO2))
ecu2avg <- data.frame("Sample" = "ecu2", "Avg_iCO2" = mean(ecu2$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu2$Delta_30s_iCO2))

sumaug02ecu <- rbind(ecu1avg, ecu2avg)

write.csv(sumaug02ecu, here("Picarro/synoptics/073119/", "sumecuaug02.csv"))


#now let's get the ecuador averages for this day combinded

#First let's make a table with just the ecu samples

ecutogether <- rbind(ecu1, ecu2)

#save this 

write.csv(ecutogether, here("Picarro/synoptics/073119/", "rawecuaug02.csv"))


aug02avg <- data.frame("Day" = "aug02", "Avg_iCO2" = mean(ecutogether$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecutogether$Delta_30s_iCO2))

write.csv(aug02avg, here("Picarro/synoptics/073119/", "aug02alldayecuavg.csv"))

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

sumaug02_30 <- rbind(syn1avg, syn5avg, syn8avg, syn11avg, syn14avg, synBWavg, syn20avg, syn23avg, syn29avg, syn35avg)

write.csv(sumaug02_30, here("Picarro/synoptics/073119/", "sumaug02_30sec_uncorrected.csv"))

#let's do a quick plot 
plot2 <- ggplot(sumaug02_30)+
  geom_point(aes(x=Sample, y=Avg_iCO2), color="purple", size=4)+
  labs(x="synoptic point", y="Delta_30s_Avg")+
  ggtitle("august 12 Synoptic Pull Averages")
plot2
ggplotly(plot2)



#ok now let's do the correction 

sumaug02_30$Correction <- as.numeric("-0.007594961")
sumaug02_30$CorrectedAverage <- as.numeric(c(sumaug02_30$Avg_iCO2 + sumaug02_30$Correction))

write.csv(sumaug02_30, here("Picarro/synoptics/073119/", "sumaug02_30sec_corrected.csv"))



