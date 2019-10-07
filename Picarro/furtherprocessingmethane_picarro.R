library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
allaug09 <- read.csv(here("Picarro/EOSTransects/080819/comprehensiveaug09.csv"))

#make posic.ct, posixct again
allaug09$PosixCT <- as.POSIXct(allaug09$PosixCT)



ecu3 <- allaug09[ which(allaug09$PosixCT > "2019-08-13 20:44:00"
                        & allaug09$PosixCT < "2019-08-13 20:48:00"), ]
ecu3$Sample <- as.character("ecu3")

col1 <- allaug09[ which(allaug09$PosixCT > "2019-08-13 20:53:00"
                         & allaug09$PosixCT < "2019-08-13 20:55:00"), ]
col1$Sample <- as.character("col1")

col2 <- allaug09[ which(allaug09$PosixCT > "2019-08-13 20:59:00"
                         & allaug09$PosixCT < "2019-08-13 21:02:00"), ]
col2$Sample <- as.character("col2")

col3 <- allaug09[ which(allaug09$PosixCT > "2019-08-13 21:06:00"
                         & allaug09$PosixCT < "2019-08-13 21:09:00"), ]
col3$Sample <- as.character("col3")

col4 <- allaug09[ which(allaug09$PosixCT > "2019-08-13 21:14:00"
                         & allaug09$PosixCT < "2019-08-13 21:16:00"), ]
col4$Sample <- as.character("col4")

col5 <- allaug09[ which(allaug09$PosixCT > "2019-08-13 21:21:00"
                         & allaug09$PosixCT < "2019-08-13 21:23:00"), ]
col5$Sample <- as.character("col5")

ecu4 <- allaug09[ which(allaug09$PosixCT > "2019-08-13 21:27:00"
                        & allaug09$PosixCT < "2019-08-13 21:29:00"), ]
ecu4$Sample <- as.character("ecu4")

col6 <- allaug09[ which(allaug09$PosixCT > "2019-08-13 21:33:00"
                         & allaug09$PosixCT < "2019-08-13 21:36:00"), ]
col6$Sample <- as.character("col6")

col7 <- allaug09[ which(allaug09$PosixCT > "2019-08-13 21:41:00"
                         & allaug09$PosixCT < "2019-08-13 21:43:00"), ]
col7$Sample <- as.character("col7")

col8 <- allaug09[ which(allaug09$PosixCT > "2019-08-13 21:47:00"
                         & allaug09$PosixCT < "2019-08-13 21:49:00"), ]
col8$Sample <- as.character("col8")




samplesaug09 <- rbind(col1, col2, col3, col4, col5, col6, col7, col8, ecu3, ecu4)

write.csv(samplesaug09, here("Picarro/EOSTransects/080819/", "allsamplesaug09.csv"))

#now let's plot only the samples 



#ok now let's find the average and std. deviation for each bag pull and put that into a new data frame



col1avg <- data.frame("Sample" = "col1", "Avg_iCH4" = mean(col1$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col1$Delta_iCH4_Raw))
col2avg <- data.frame("Sample" = "col2", "Avg_iCH4" = mean(col2$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col2$Delta_iCH4_Raw))
col3avg <- data.frame("Sample" = "col3", "Avg_iCH4" = mean(col3$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col3$Delta_iCH4_Raw))
ecu3avg <- data.frame("Sample" = "ecu3", "Avg_iCH4" = mean(ecu3$Delta_iCH4_Raw), "StdDev_iCH4" = sd(ecu3$Delta_iCH4_Raw))
col4avg <- data.frame("Sample" = "col4", "Avg_iCH4" = mean(col4$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col4$Delta_iCH4_Raw))
col5avg <- data.frame("Sample" = "col5", "Avg_iCH4" = mean(col5$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col5$Delta_iCH4_Raw))
ecu4avg <- data.frame("Sample" = "ecu4", "Avg_iCH4" = mean(ecu4$Delta_iCH4_Raw), "StdDev_iCH4" = sd(ecu4$Delta_iCH4_Raw))
col6avg <- data.frame("Sample" = "col6", "Avg_iCH4" = mean(col6$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col6$Delta_iCH4_Raw))
col7avg <- data.frame("Sample" = "col7", "Avg_iCH4" = mean(col7$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col7$Delta_iCH4_Raw))
col8avg <- data.frame("Sample" = "col8", "Avg_iCH4" = mean(col8$Delta_iCH4_Raw), "StdDev_iCH4" = sd(col8$Delta_iCH4_Raw))


sumaug09 <- rbind(col1avg, col2avg, col3avg, col4avg, col5avg, col6avg, col7avg, col8avg, ecu3avg, ecu4avg)

write.csv(sumaug09, here("Picarro/EOSTransects/080819/", "summethaneaug09.csv"))
