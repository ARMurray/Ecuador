library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
allaug02 <- read.csv(here("Picarro/EOSTransects/080119/methaneaug02Data.csv"))

#make posic.ct, posixct again
allaug02$PosixCT <- as.POSIXct(allaug02$PosixCT)


ecu3 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 18:22:11"
                        & allaug02$PosixCT < "2019-08-02 18:24:06"), ]
ecu3$Sample <- as.character("ecu3")

col1 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 18:26:09"
                         & allaug02$PosixCT < "2019-08-02 18:28:02"), ]
col1$Sample <- as.character("col1")

col2 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 18:30:16"
                         & allaug02$PosixCT < "2019-08-02 18:33:15"), ]
col2$Sample <- as.character("col2")

col3 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 18:35:00"
                         & allaug02$PosixCT < "2019-08-02 18:38:00"), ]
col3$Sample <- as.character("col3")

col4 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 18:40:00"
                         & allaug02$PosixCT < "2019-08-02 18:42:00"), ]
col4$Sample <- as.character("col4")

col5 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 18:44:00"
                         & allaug02$PosixCT < "2019-08-02 18:46:00"), ]
col5$Sample <- as.character("col5")

ecu4 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 18:48:42"
                        & allaug02$PosixCT < "2019-08-02 18:50:59"), ]
ecu4$Sample <- as.character("ecu4")

col6 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 18:53:00"
                         & allaug02$PosixCT < "2019-08-02 18:57:00"), ]
col6$Sample <- as.character("col6")

col7 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 19:00:00"
                         & allaug02$PosixCT < "2019-08-02 19:03:00"), ]
col7$Sample <- as.character("col7")

col8 <- allaug02[ which(allaug02$PosixCT > "2019-08-02 19:06:00"
                         & allaug02$PosixCT < "2019-08-02 19:09:00"), ]
col8$Sample <- as.character("col8")




samplesaug02 <- rbind(col1, col2, col3, col4, col5, col6, col7, ecu3, ecu4, col8)

write.csv(samplesaug02, here("Picarro/EOSTransects/080119/", "allsamplesaug02.csv"))

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


sumaug02 <- rbind(col1avg, col2avg, col3avg, col4avg, col5avg, col6avg, col7avg, ecu3avg, col8avg, ecu4avg)

write.csv(sumaug02, here("Picarro/EOSTransects/080119/", "summethaneaug02.csv"))
