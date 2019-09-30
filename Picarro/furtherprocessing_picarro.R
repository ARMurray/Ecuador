library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
alljuly30 <- read.csv(here("Picarro/EOSTransects/072919/alljuly30Data.csv"))

#make posic.ct, posixct again
alljuly30$PosixCT <- as.POSIXct(alljuly30$PosixCT)

#subset the data
Subsjuly30 <- alljuly30[c(56370:70000), ]

#Do an initial plot of C02 
plot <- ggplot(alljuly30)+
geom_point(aes(x= PosixCT, y= X12CO2)) +
labs(x = "Time", y = "CO2") +
ggtitle("july30 EOS Transect Pulls") 
plot

#Do an initial plot of Delta_i 
plot <- ggplot(Subsjuly30)+
geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2)) +
labs(x = "Time", y = "Delta_Raw") +
ggtitle("july30 EOS Transect Pulls") 

plot
ggplotly(plot)




ecu1 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 15:24:17"
                                     & alljuly30$PosixCT < "2019-07-30 15:28:50"), ]
ecu1$Sample <- as.character("ecu1")

col1 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 15:31:35"
                         & alljuly30$PosixCT < "2019-07-30 15:35:08"), ]
col1$Sample <- as.character("col1")

col2 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 15:38:00"
                         & alljuly30$PosixCT < "2019-07-30 15:42:00"), ]
col2$Sample <- as.character("col2")

col3 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 15:45:00"
                         & alljuly30$PosixCT < "2019-07-30 15:49:00"), ]
col3$Sample <- as.character("col3")

col4 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 15:52:00"
                         & alljuly30$PosixCT < "2019-07-30 15:56:00"), ]
col4$Sample <- as.character("col4")

col5 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 15:59:54"
                         & alljuly30$PosixCT < "2019-07-30 16:03:00"), ]
col5$Sample <- as.character("col5")

ecu2 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 16:05:58"
                         & alljuly30$PosixCT < "2019-07-30 16:09:10"), ]
ecu2$Sample <- as.character("ecu2")

col6 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 16:10:00"
                         & alljuly30$PosixCT < "2019-07-30 16:13:00"), ]
col6$Sample <- as.character("col6")

col7 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 16:15:00"
                         & alljuly30$PosixCT < "2019-07-30 16:19:00"), ]
col7$Sample <- as.character("col7")

col8 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 16:21:00"
                         & alljuly30$PosixCT < "2019-07-30 16:24:00"), ]
col8$Sample <- as.character("col8")

col5test <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 16:26:00"
                         & alljuly30$PosixCT < "2019-07-30 16:29:00"), ]
col5test$Sample <- as.character("col5test")

ecu3 <- alljuly30[ which(alljuly30$PosixCT > "2019-07-30 16:31:57"
                         & alljuly30$PosixCT < "2019-07-30 16:35:00"), ]
ecu3$Sample <- as.character("ecu3")

samplesjuly30 <- rbind(col1, col2, col3, ecu2, col4, col5, ecu3, col6, col7, ecu1, col8, col5test)

write.csv(samplesjuly30, here("Picarro/EOSTransects/072919/", "samplesjuly30.csv"))

#now let's plot only the samples 

#Do an initial plot of Delta_i 
plot <- ggplot(samplesjuly30)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2)) +
  labs(x = "Time", y = "Delta_Raw") +
  ggtitle("july30 EOS Transect Pulls") 

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
col8avg <- data.frame("Sample" = "col8", "Avg_iCO2" = mean(col8$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col8$Delta_Raw_iCO2))
ecu1avg <- data.frame("Sample" = "ecu4", "Avg_iCO2" = mean(ecu1$Delta_Raw_iCO2), "StdDev_iCO2" = sd(ecu1$Delta_Raw_iCO2))
col5testavg <- data.frame("Sample" = "col5test", "Avg_iCO2" = mean(col5test$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col5test$Delta_Raw_iCO2))


sumjuly30 <- rbind(col1avg, col2avg, col3avg, ecu2avg, col4avg, col5avg, ecu3avg, col6avg, col7avg, ecu1avg, col8avg, col5avg)

write.csv(sumjuly30, here("Picarro/EOSTransects/072919/", "sumjuly30.csv"))
