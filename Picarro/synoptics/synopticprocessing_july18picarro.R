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
july19_Files <- list.files(here::here("2019 picarro/07/19"),pattern = '.dat')

#create an empty data.frame
alljuly19Data <- read.table(here::here("2019 picarro/07/19",july19_Files[1]), header= TRUE)


# Combine all july19 data
for(i in 2:length(july19_Files)){
  file <- july19_Files[i]
  data <- read.table(here::here("2019 picarro/07/19",file), header = TRUE)
  alljuly19Data <- rbind(alljuly19Data,data)
}

# Combine Date and time into one column
alljuly19Data$DateTime <- paste0(alljuly19Data$DATE," ",substr(alljuly19Data$TIME,1,8))

# Convert to PosixCT
alljuly19Data$PosixCT <- as.POSIXct(alljuly19Data$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#make posic.ct, posixct again
alljuly19Data$PosixCT <- as.POSIXct(alljuly19Data$PosixCT)

#only take what you need
alljuly19 <- alljuly19Data %>%
  select(DATE, PosixCT, X12CO2, Delta_Raw_iCO2, Delta_30s_iCO2,HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)

#savethis
write.csv(alljuly19, here("Picarro/synoptics/071819/allrawjuly19data.csv"))

#subset the data
subsjuly19 <- alljuly19[ which(alljuly19$PosixCT > "2019-07-19 14:40:00"
                 & alljuly19$PosixCT < "2019-07-19 16:20:00"), ]
#savethis
write.csv(subsjuly19, here("Picarro/synoptics/071819/subsaug12.csv"))

#Do an initial plot of Delta_i 
plot <- ggplot(subsjuly19)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2), color="blue")+
  geom_point(aes(x= PosixCT, y= Delta_30s_iCO2), color="red")+
  labs(x = "Time", y = "Delta")+
  ggtitle("July 18 Synoptics Delta Co2 Raw and 30 seconds") 

plot
ggplotly(plot)

#Now let's get the exact sample times that we need for 30 seconds 

ecu1 <- alljuly19[ which(alljuly19$PosixCT > "2019-07-19 14:46:39"
                        & alljuly19$PosixCT < "2019-07-19 14:49:37"), ]
ecu1$Sample <- as.character("ecu1")

syn1 <- alljuly19[ which(alljuly19$PosixCT > "2019-07-19 14:53:15"
                        & alljuly19$PosixCT < "2019-07-19 14:56:13"), ]
syn1$Sample <- as.character("syn1")

syn5 <- alljuly19[ which(alljuly19$PosixCT > "2019-07-19 15:01:29"
                        & alljuly19$PosixCT < "2019-07-19 15:03:41"), ]
syn5$Sample <- as.character("syn5")

syn8 <- alljuly19[ which(alljuly19$PosixCT > "2019-07-19 15:07:41"
                         & alljuly19$PosixCT < "2019-07-19 15:10:18"), ]
syn8$Sample <- as.character("syn8")

syn11 <- alljuly19[ which(alljuly19$PosixCT > "2019-07-19 15:15:40"
                         & alljuly19$PosixCT < "2019-07-19 15:18:09"), ]
syn11$Sample <- as.character("syn11")

syn14 <- alljuly19[ which(alljuly19$PosixCT > "2019-07-19 15:21:56"
                         & alljuly19$PosixCT < "2019-07-19 15:24:22"), ]
syn14$Sample <- as.character("syn14")

ecu2 <- alljuly19[ which(alljuly19$PosixCT > "2019-07-19 15:29:55"
                        & alljuly19$PosixCT < "2019-07-19 15:32:40"), ]
ecu2$Sample <- as.character("ecu2")

synBW <- alljuly19[ which(alljuly19$PosixCT > "2019-07-19 15:37:14"
                         & alljuly19$PosixCT < "2019-07-19 15:38:34"), ]
synBW$Sample <- as.character("synBW")

syn20 <- alljuly19[ which(alljuly19$PosixCT > "2019-07-19 15:50:57"
                         & alljuly19$PosixCT < "2019-07-19 15:53:53"), ]
syn20$Sample <- as.character("syn20")

syn23 <- alljuly19[ which(alljuly19$PosixCT > "2019-07-19 15:57:12"
                         & alljuly19$PosixCT < "2019-07-19 16:00:22"), ]
syn23$Sample <- as.character("syn23")

syn29 <- alljuly19[ which(alljuly19$PosixCT > "2019-07-19 16:04:27"
                         & alljuly19$PosixCT < "2019-07-19 16:07:03"), ]
syn29$Sample <- as.character("syn29")

syn34 <- alljuly19[ which(alljuly19$PosixCT > "2019-07-19 16:14:10"
                         & alljuly19$PosixCT < "2019-07-19 16:17:33"), ]
syn34$Sample <- as.character("syn34")

samplesjuly19 <- rbind(syn1, syn5, syn8, syn11, syn14, synBW, syn20, syn23, syn29, syn34, ecu1, ecu2)

write.csv(samplesjuly19, here("Picarro/synoptics/071819/", "samplesalldatajuly19.csv"))



#let's get the average and std. deviation of all ecu samples 

ecu1avg <- data.frame("Sample" = "ecu1", "Avg_iCO2" = mean(ecu1$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu1$Delta_30s_iCO2))
ecu2avg <- data.frame("Sample" = "ecu2", "Avg_iCO2" = mean(ecu2$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu2$Delta_30s_iCO2))

sumjuly19ecu <- rbind(ecu1avg, ecu2avg)

write.csv(sumjuly19ecu, here("Picarro/synoptics/071819/", "sumecujuly19.csv"))


#now let's get the ecuador averages for this day combinded

#First let's make a table with just the ecu samples

ecutogether <- rbind(ecu1, ecu2)

#save this 

write.csv(ecutogether, here("Picarro/synoptics/071819/", "rawecujuly19.csv"))

july19avg <- data.frame("Day" = "july19", "Avg_iCO2" = mean(ecutogether$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecutogether$Delta_30s_iCO2))

write.csv(july19avg, here("Picarro/synoptics/071819/", "july19alldayecuavg.csv"))

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
syn34avg <- data.frame("Sample" = "syn34", "Avg_iCO2" = mean(syn34$Delta_30s_iCO2), "StdDev_iCO2" = sd(syn34$Delta_30s_iCO2))

sumjuly19_30 <- rbind(syn1avg, syn5avg, syn8avg, syn11avg, syn14avg, synBWavg, syn20avg, syn23avg, syn29avg, syn34avg)

write.csv(sumjuly19_30, here("Picarro/synoptics/071819/", "sumjuly19_30sec_uncorrected.csv"))

#let's do a quick plot 
plot2 <- ggplot(sumjuly19_30)+
  geom_point(aes(x=Sample, y=Avg_iCO2), color="purple", size=4)+
  labs(x="synoptic point", y="Delta_30s_Avg")+
  ggtitle("august 12 Synoptic Pull Averages")
plot2
ggplotly(plot2)



#ok now let's do the correction 

sumjuly19_30$Correction <- as.numeric("0.734068306")
sumjuly19_30$CorrectedAverage <- as.numeric(c(sumjuly19_30$Avg_iCO2 + sumjuly19_30$Correction))

write.csv(sumjuly19_30, here("Picarro/synoptics/071819/", "sumjuly19_30sec_corrected.csv"))



