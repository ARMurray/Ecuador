library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
alljuly23 <- read.csv(here("Picarro/EOSTransects/072219/methanejuly23Data.csv"))

#make posic.ct, posixct again
alljuly23$PosixCT <- as.POSIXct(alljuly23$PosixCT)



ecu1 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 15:14:11"
                         & alljuly23$PosixCT < "2019-07-23 15:18:47"), ]
ecu1$Sample <- as.character("ecu1")

col1 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 15:21:50"
                         & alljuly23$PosixCT < "2019-07-23 15:25:09"), ]
col1$Sample <- as.character("col1")

col2 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 16:19:21"
                         & alljuly23$PosixCT < "2019-07-23 16:22:31"), ]
col2$Sample <- as.character("col2")

col3 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 16:03:00"
                         & alljuly23$PosixCT < "2019-07-23 16:06:00"), ]
col3$Sample <- as.character("col3")

ecu2 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 15:55:45"
                         & alljuly23$PosixCT < "2019-07-23 15:59:40"), ]
ecu2$Sample <- as.character("ecu2")

col4 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 15:43:00"
                         & alljuly23$PosixCT < "2019-07-23 15:46:00"), ]
col4$Sample <- as.character("col4")

col5 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 15:28:08"
                         & alljuly23$PosixCT < "2019-07-23 15:32:01"), ]
col5$Sample <- as.character("col5")

ecu3 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 16:31:12"
                         & alljuly23$PosixCT < "2019-07-23 16:35:21"), ]
ecu3$Sample <- as.character("ecu3")

col6 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 16:25:00"
                         & alljuly23$PosixCT < "2019-07-23 16:27:00"), ]
col6$Sample <- as.character("col6")

col7 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 16:11:00"
                         & alljuly23$PosixCT < "2019-07-23 16:14:00"), ]
col7$Sample <- as.character("col7")

col8 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 15:35:40"
                         & alljuly23$PosixCT < "2019-07-23 15:39:00"), ]
col8$Sample <- as.character("col8")



samplesjuly23 <- rbind(col1, col2, col3, col4, col5, col6, col7, ecu2, ecu3, col8, ecu1)

write.csv(samplesjuly23, here("Picarro/EOSTransects/072219/", "allsamplesjuly23.csv"))

#now let's plot only the samples 



#ok now let's find the average and std. deviation for each bag pull and put that into a new data frame



col1avg <- data.frame("Sample" = "col1", "Avg_iCH4" = mean(col1$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col1$Delta_iCH4_Raw))
col2avg <- data.frame("Sample" = "col2", "Avg_iCH4" = mean(col2$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col2$Delta_iCH4_Raw))
col3avg <- data.frame("Sample" = "col3", "Avg_iCH4" = mean(col3$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col3$Delta_iCH4_Raw))
ecu1avg <- data.frame("Sample" = "ecu1", "Avg_iCH4" = mean(ecu1$Delta_iCH4_Raw), "StdDev_iCH4" = sd(ecu1$Delta_iCH4_Raw))
col4avg <- data.frame("Sample" = "col4", "Avg_iCH4" = mean(col4$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col4$Delta_iCH4_Raw))
col5avg <- data.frame("Sample" = "col5", "Avg_iCH4" = mean(col5$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col5$Delta_iCH4_Raw))
ecu2avg <- data.frame("Sample" = "ecu2", "Avg_iCH4" = mean(ecu2$Delta_iCH4_Raw), "StdDev_iCH4" = sd(ecu2$Delta_iCH4_Raw))
col6avg <- data.frame("Sample" = "col6", "Avg_iCH4" = mean(col6$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col6$Delta_iCH4_Raw))
col7avg <- data.frame("Sample" = "col7", "Avg_iCH4" = mean(col7$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col7$Delta_iCH4_Raw))
ecu3avg <- data.frame("Sample" = "ecu3", "Avg_iCH4" = mean(ecu3$Delta_iCH4_Raw), "StdDev_iCH4" = sd(ecu3$Delta_iCH4_Raw))
col8avg <- data.frame("Sample" = "col8", "Avg_iCH4" = mean(col8$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col8$Delta_iCH4_Raw))


sumjuly23 <- rbind(col1avg, col2avg, col3avg, col4avg, col5avg, col6avg, col7avg, ecu2avg, ecu3avg, ecu1avg, col8avg)

write.csv(sumjuly23, here("Picarro/EOSTransects/072219/", "summethanejuly23.csv"))
