library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
alljuly30 <- read.csv(here("Picarro/EOSTransects/072919/comprehensivejuly30.csv"))

# Combine Date and time into one column
alljuly30$DateTime <- paste0(alljuly30$DATE," ",substr(alljuly30$TIME,1,8))

# Convert to PosixCT
alljuly30$PosixCT <- as.POSIXct(alljuly30$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#make posic.ct, posixct again
alljuly30$PosixCT <- as.POSIXct(alljuly30$PosixCT)

#only take what you need
alljuly30 <- alljuly30 %>%
  select(DATE, PosixCT, X12CO2, Delta_Raw_iCO2, Delta_30s_iCO2,HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)

#savethis
write.csv(alljuly30, here("Picarro/EOSTransects/072919/alldeltajuly30.csv"))

#subset the data
subsjuly30 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 15:00:00"
                 & alljuly30$PosixCT < "2019-07-30 16:45:00"), ]
#savethis
write.csv(subsjuly30, here("Picarro/EOSTransects/072919/subsjuly30.csv"))

#Do an initial plot of Delta_i 
plot <- ggplot(subsjuly30)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2), color="blue")+
  geom_point(aes(x= PosixCT, y= Delta_30s_iCO2), color="red")+
  labs(x = "Time", y = "Delta")+
  ggtitle("July 30 Delta Co2 Raw and 30 seconds") 

plot
ggplotly(plot)

#Now let's get the exact sample times that we need for 30 seconds 

ecu1 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 15:24:47"
                         & alljuly30$PosixCT < "2019-07-30 15:28:20"), ]
ecu1$Sample <- as.character("ecu1")

col1 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 15:32:05"
                        & alljuly30$PosixCT < "2019-07-30 15:34:38"), ]
col1$Sample <- as.character("col1")

col2 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 15:38:30"
                         & alljuly30$PosixCT < "2019-07-30 15:41:30"), ]
col2$Sample <- as.character("col2")

col3 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 15:45:30"
                         & alljuly30$PosixCT < "2019-07-30 15:48:30"), ]
col3$Sample <- as.character("col3")

col4 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 15:52:30"
                         & alljuly30$PosixCT < "2019-07-30 15:55:30"), ]
col4$Sample <- as.character("col4")

col5 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 16:00:13"
                         & alljuly30$PosixCT < "2019-07-30 16:02:30"), ]
col5$Sample <- as.character("col5")

ecu2 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 16:06:28"
                         & alljuly30$PosixCT < "2019-07-30 16:08:40"), ]
ecu2$Sample <- as.character("ecu2")

col6 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 16:10:30"
                         & alljuly30$PosixCT < "2019-07-30 16:12:30"), ]
col6$Sample <- as.character("col6")

col7 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 16:15:30"
                         & alljuly30$PosixCT < "2019-07-30 16:18:30"), ]
col7$Sample <- as.character("col7")

col8 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 16:21:30"
                         & alljuly30$PosixCT < "2019-07-30 16:23:30"), ]
col8$Sample <- as.character("col8")

col5test <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 16:26:30"
                         & alljuly30$PosixCT < "2019-07-30 16:28:30"), ]
col5test$Sample <- as.character("col5test")


samplesjuly30 <- rbind(col1, col2, col3, col4, col5, col6, col7, ecu1, ecu2, col5test)

write.csv(samplesjuly30, here("Picarro/EOSTransects/072919/", "samplesalldatajuly30.csv"))



#let's get the average and std. deviation of all ecu samples 

ecu2avg <- data.frame("Sample" = "ecu2", "Avg_iCO2" = mean(ecu2$Delta_Raw_iCO2), "StdDev_iCO2" = sd(ecu2$Delta_Raw_iCO2))
ecu1avg <- data.frame("Sample" = "ecu1", "Avg_iCO2" = mean(ecu3$Delta_Raw_iCO2), "StdDev_iCO2" = sd(ecu3$Delta_Raw_iCO2))

sumjuly30ecu <- rbind(ecu2avg, ecu3avg)

write.csv(sumjuly30ecu, here("Picarro/EOSTransects/081319/", "sumecujuly30.csv"))

