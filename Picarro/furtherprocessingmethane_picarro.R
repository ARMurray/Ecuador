library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
alljuly17 <- read.csv(here("Picarro/EOSTransects/071619/methanejuly17Data.csv"))

#make posic.ct, posixct again
alljuly17$PosixCT <- as.POSIXct(alljuly17$PosixCT)




col1 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:11:09"
                         & alljuly17$PosixCT < "2019-07-17 18:14:15"), ]
col1$Sample <- as.character("col1")

col2 <- alljuly17[ which(alljuly17$PosixCT > "2019-07-17 18:24:48"
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



samplesjuly17 <- rbind(col1, col2, col3, col4, col5, col6, col7, ecu2, ecu3, ecu4)

write.csv(samplesjuly17, here("Picarro/EOSTransects/071619/", "allsamplesjuly17.csv"))

#now let's plot only the samples 



#ok now let's find the average and std. deviation for each bag pull and put that into a new data frame



col1avg <- data.frame("Sample" = "col1", "Avg_iCH4" = mean(col1$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col1$Delta_iCH4_Raw))
col2avg <- data.frame("Sample" = "col2", "Avg_iCH4" = mean(col2$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col2$Delta_iCH4_Raw))
col3avg <- data.frame("Sample" = "col3", "Avg_iCH4" = mean(col3$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col3$Delta_iCH4_Raw))
ecu3avg <- data.frame("Sample" = "ecu3", "Avg_iCH4" = mean(ecu3$Delta_iCH4_Raw), "StdDev_iCH4" = sd(ecu3$Delta_iCH4_Raw))
col4avg <- data.frame("Sample" = "col4", "Avg_iCH4" = mean(col4$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col4$Delta_iCH4_Raw))
col5avg <- data.frame("Sample" = "col5", "Avg_iCH4" = mean(col5$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col5$Delta_iCH4_Raw))
ecu2avg <- data.frame("Sample" = "ecu4", "Avg_iCH4" = mean(ecu4$Delta_iCH4_Raw), "StdDev_iCH4" = sd(ecu4$Delta_iCH4_Raw))
col6avg <- data.frame("Sample" = "col6", "Avg_iCH4" = mean(col6$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col6$Delta_iCH4_Raw))
col7avg <- data.frame("Sample" = "col7", "Avg_iCH4" = mean(col7$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col7$Delta_iCH4_Raw))
ecu4avg <- data.frame("Sample" = "ecu4", "Avg_iCH4" = mean(ecu4$Delta_iCH4_Raw), "StdDev_iCH4" = sd(ecu4$Delta_iCH4_Raw))



sumjuly17 <- rbind(col1avg, col2avg, col3avg, col4avg, col5avg, col6avg, col7avg, ecu2avg, ecu3avg, ecu4avg)

write.csv(sumjuly17, here("Picarro/EOSTransects/071619/", "summethanejuly17.csv"))
