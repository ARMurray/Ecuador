library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
alljuly17 <- read.csv(here("Picarro/EOSTransects/071619/alljuly17Data.csv"))

#make posic.ct, posixct again
alljuly17$PosixCT <- as.POSIXct(alljuly17$PosixCT)

#Do an initial plot of C02 
plot <- ggplot(alljuly17)+
geom_point(aes(x= PosixCT, y= X12CO2)) +
labs(x = "Time", y = "CO2") +
ggtitle("july17 EOS Transect Pulls") 
plot

#Do an initial plot of Delta_i 
plot <- ggplot(Subsjuly17)+
geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2)) +
labs(x = "Time", y = "Delta_Raw") +
ggtitle("July17 EOS Transect Pulls") 

plot
ggplotly(plot)


Subsjuly17 <- alljuly17[c(70400:83600), ]

col1 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:11:00"
                                     & alljuly17$PosixCT < "2019-07-17 18:14:15"), ]
col1$Sample <- as.character("col1")

col2 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:24:28"
                         & alljuly17$PosixCT < "2019-07-17 18:27:00"), ]
col2$Sample <- as.character("col2")

col3 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:31:00"
                         & alljuly17$PosixCT < "2019-07-17 18:34:18"), ]
col3$Sample <- as.character("col3")

ecu2 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:37:16"
                         & alljuly17$PosixCT < "2019-07-17 18:40:02"), ]
ecu2$Sample <- as.character("ecu2")

col4 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:44:07"
                         & alljuly17$PosixCT < "2019-07-17 18:47:09"), ]
col4$Sample <- as.character("col4")

col5 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:50:00"
                         & alljuly17$PosixCT < "2019-07-17 18:54:01"), ]
col5$Sample <- as.character("col5")

ecu3 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:57:47"
                         & alljuly17$PosixCT < "2019-07-17 18:59:57"), ]
ecu3$Sample <- as.character("ecu3")

col6 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 19:03:03"
                         & alljuly17$PosixCT < "2019-07-17 19:05:02"), ]
col6$Sample <- as.character("col6")

col7 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 19:08:00"
                         & alljuly17$PosixCT < "2019-07-17 19:11:00"), ]
col7$Sample <- as.character("col7")

ecu4 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 19:14:41"
                         & alljuly17$PosixCT < "2019-07-17 19:16:30"), ]
ecu4$Sample <- as.character("ecu4")

samplesjuly17 <- rbind(col1, col2, col3, ecu2, col4, col5, ecu3, col6, col7, ecu4)

write.csv(samplesjuly17, here("Picarro/EOSTransects/071619/", "samplesjuly17.csv"))

#now let's plot only the samples 

#Do an initial plot of Delta_i 
plot <- ggplot(samplesjuly17)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2)) +
  labs(x = "Time", y = "Delta_Raw") +
  ggtitle("July17 EOS Transect Pulls") 

plot
ggplotly(plot)


#ok now let's find the average and std. deviation for each bag pull and put that into a new data frame



col1avg <- data.frame("Sample" = "col1", "Avg_iCO2" = mean(col1$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col1$Delta_Raw_iCO2))
col2avg <- data.frame("Sample" = "col2", "Avg_iCO2" = mean(col2$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col2$Delta_Raw_iCO2))
col3avg <- data.frame("Sample" = "col3", "Avg_iCO2" = mean(col3$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col3$Delta_Raw_iCO2))
ecu2avg <- data.frame("Sample" = "ecu2", "Avg_iCO2" = mean(ecu2$Delta_Raw_iCO2), "StdDev_iCO2" = sd(ecu2$Delta_Raw_iCO2))
col4avg <- data.frame("Sample" = "col4", "Avg_iCO2" = mean(col4$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col4$Delta_Raw_iCO2))
col5avg <- data.frame("Sample" = "col5", "Avg_iCO2" = mean(col5$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col5$Delta_Raw_iCO2))
ecu3avg <- data.frame("Sample" = "ecu3", "Avg_iCO2" = mean(ecu3$Delta_Raw_iCO2), "StdDev_iCO2" = sd(ecu3$Delta_Raw_iCO2))
col6avg <- data.frame("Sample" = "col6", "Avg_iCO2" = mean(col6$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col6$Delta_Raw_iCO2))
col7avg <- data.frame("Sample" = "col7", "Avg_iCO2" = mean(col7$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col7$Delta_Raw_iCO2))
ecu4avg <- data.frame("Sample" = "ecu4", "Avg_iCO2" = mean(ecu4$Delta_Raw_iCO2), "StdDev_iCO2" = sd(ecu4$Delta_Raw_iCO2))



sumjuly17 <- rbind(col1avg, col2avg, col3avg, ecu2avg, col4avg, col5avg, ecu3avg, col6avg, col7avg, ecu4avg)

write.csv(sumjuly17, here("Picarro/EOSTransects/071619/", "sumjuly17.csv"))
