library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
alljuly17 <- read.csv(here("Picarro/EOSTransects/071619/comprehensivejuly17.csv"))

# Combine Date and time into one column
alljuly17$DateTime <- paste0(alljuly17$DATE," ",substr(alljuly17$TIME,1,8))

# Convert to PosixCT
alljuly17$PosixCT <- as.POSIXct(alljuly17$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#make posic.ct, posixct again
alljuly17$PosixCT <- as.POSIXct(alljuly17$PosixCT)

#only take what you need
alljuly17 <- alljuly17 %>%
  select(DATE, PosixCT, X12CO2, Delta_Raw_iCO2, Delta_30s_iCO2,HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)

#savethis
write.csv(alljuly17, here("Picarro/EOSTransects/071619/alldeltajuly17.csv"))

#subset the data
subsjuly17 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:00:00"
                 & alljuly17$PosixCT < "2019-07-17 19:30:00"), ]
#savethis
write.csv(subsjuly17, here("Picarro/EOSTransects/071619/subsjuly17.csv"))

#Do an initial plot of Delta_i 
plot <- ggplot(subsjuly17)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2), color="blue")+
  geom_point(aes(x= PosixCT, y= Delta_30s_iCO2), color="red")+
  labs(x = "Time", y = "Delta")+
  ggtitle("July 17 Delta Co2 Raw and 30 seconds") 

plot
ggplotly(plot)

#Now let's get the exact sample times that we need for 30 seconds 

col1 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:11:39"
                        & alljuly17$PosixCT < "2019-07-17 18:13:45"), ]
col1$Sample <- as.character("col1")

col2 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:25:18"
                         & alljuly17$PosixCT < "2019-07-17 18:26:30"), ]
col2$Sample <- as.character("col2")

col3 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:31:30"
                         & alljuly17$PosixCT < "2019-07-17 18:33:48"), ]
col3$Sample <- as.character("col3")

ecu2 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:37:46"
                         & alljuly17$PosixCT < "2019-07-17 18:39:32"), ]
ecu2$Sample <- as.character("ecu2")

col4 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:44:37"
                         & alljuly17$PosixCT < "2019-07-17 18:46:39"), ]
col4$Sample <- as.character("col4")

col5 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:50:30"
                         & alljuly17$PosixCT < "2019-07-17 18:53:31"), ]
col5$Sample <- as.character("col5")

ecu3 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:58:17"
                        & alljuly17$PosixCT < "2019-07-17 18:59:27"), ]
ecu3$Sample <- as.character("ecu3")

col6 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 19:03:33"
                         & alljuly17$PosixCT < "2019-07-17 19:04:32"), ]
col6$Sample <- as.character("col6")

col7 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 19:08:30"
                         & alljuly17$PosixCT < "2019-07-17 19:10:30"), ]
col7$Sample <- as.character("col7")

#col8 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 21:47:00"
                         & alljuly17$PosixCT < "2019-07-17 21:49:00"), ]
#col8$Sample <- as.character("col8")



samplesjuly17 <- rbind(col1, col2, col3, col4, col5, col6, col7, ecu3, ecu2)

write.csv(samplesjuly17, here("Picarro/EOSTransects/071619/", "samplesalldatajuly17.csv"))

#now let's plot only the samples 

#Do an initial plot of Delta_i 
plot2 <- ggplot(samplesjuly17)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2), color=Sample)+
  geom_point(aes(x= PosixCT, y= Delta_30s_iCO2), color=Sample)+
  labs(x = "Time", y = "Delta")+
  ggtitle("July 17 Sample Comparison Delta Raw and 30s") 
plot2
ggplotly(plot)

#let's get the average and std. deviation of all ecu samples 

ecu2avg <- data.frame("Sample" = "ecu2", "Avg_iCO2" = mean(ecu2$Delta_Raw_iCO2), "StdDev_iCO2" = sd(ecu2$Delta_Raw_iCO2))
ecu3avg <- data.frame("Sample" = "ecu3", "Avg_iCO2" = mean(ecu3$Delta_Raw_iCO2), "StdDev_iCO2" = sd(ecu3$Delta_Raw_iCO2))

sumjuly17ecu <- rbind(ecu2avg, ecu3avg)

write.csv(sumjuly17ecu, here("Picarro/EOSTransects/081319/", "sumecujuly17.csv"))

