library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
allaug13 <- read.csv(here("Picarro/EOSTransects/081319/allaug13Data.csv"))

#make posic.ct, posixct again
allaug13$PosixCT <- as.POSIXct(allaug13$PosixCT)

#subset the data
Subsaug13 <- allaug13[c(82900:89200), ]

#Do an initial plot of C02 
plot <- ggplot(allaug13)+
geom_point(aes(x= PosixCT, y= X12CO2)) +
labs(x = "Time", y = "CO2") +
ggtitle("aug13 EOS Transect Pulls") 
plot

#Do an initial plot of Delta_i 
plot <- ggplot(Subsaug13)+
geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2)) +
labs(x = "Time", y = "Delta_Raw") +
ggtitle("aug13 EOS Transect Pulls") 

plot
ggplotly(plot)



ecu3 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 20:44:00"
                        & allaug13$PosixCT < "2019-08-13 20:48:00"), ]
ecu3$Sample <- as.character("ecu3")


col1 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 20:53:00"
                         & allaug13$PosixCT < "2019-08-13 20:55:00"), ]
col1$Sample <- as.character("col1")

col2 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 20:59:00"
                         & allaug13$PosixCT < "2019-08-13 21:02:00"), ]
col2$Sample <- as.character("col2")

col3 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 21:06:00"
                         & allaug13$PosixCT < "2019-08-13 21:09:00"), ]
col3$Sample <- as.character("col3")

col4 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 21:14:00"
                         & allaug13$PosixCT < "2019-08-13 21:16:00"), ]
col4$Sample <- as.character("col4")

col5 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 21:21:00"
                         & allaug13$PosixCT < "2019-08-13 21:23:00"), ]
col5$Sample <- as.character("col5")

ecu4 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 21:27:00"
                        & allaug13$PosixCT < "2019-08-13 21:29:00"), ]
ecu4$Sample <- as.character("ecu4")

col6 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 21:33:00"
                         & allaug13$PosixCT < "2019-08-13 21:36:00"), ]
col6$Sample <- as.character("col6")

col7 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 21:41:00"
                         & allaug13$PosixCT < "2019-08-13 21:43:00"), ]
col7$Sample <- as.character("col7")

col8 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 21:47:00"
                         & allaug13$PosixCT < "2019-08-13 21:49:00"), ]
col8$Sample <- as.character("col8")



samplesaug13 <- rbind(col1, col2, col3, col4, col5, col6, col7, col8, ecu3, ecu4)

write.csv(samplesaug13, here("Picarro/EOSTransects/081319/", "samplesaug13.csv"))

#now let's plot only the samples 

#Do an initial plot of Delta_i 
plot <- ggplot(samplesaug13)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2)) +
  labs(x = "Time", y = "Delta_Raw") +
  ggtitle("aug13 EOS Transect Pulls") 

plot
ggplotly(plot)


#ok now let's find the average and std. deviation for each bag pull and put that into a new data frame



col1avg <- data.frame("Sample" = "col1", "Avg_iCO2" = mean(col1$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col1$Delta_Raw_iCO2))
col2avg <- data.frame("Sample" = "col2", "Avg_iCO2" = mean(col2$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col2$Delta_Raw_iCO2))
col3avg <- data.frame("Sample" = "col3", "Avg_iCO2" = mean(col3$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col3$Delta_Raw_iCO2))
ecu3avg <- data.frame("Sample" = "ecu3", "Avg_iCO2" = mean(ecu3$Delta_Raw_iCO2), "StdDev_iCO2" = sd(ecu3$Delta_Raw_iCO2))
col4avg <- data.frame("Sample" = "col4", "Avg_iCO2" = mean(col4$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col4$Delta_Raw_iCO2))
col5avg <- data.frame("Sample" = "col5", "Avg_iCO2" = mean(col5$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col5$Delta_Raw_iCO2))
ecu4avg <- data.frame("Sample" = "ecu4", "Avg_iCO2" = mean(ecu4$Delta_Raw_iCO2), "StdDev_iCO2" = sd(ecu4$Delta_Raw_iCO2))
col6avg <- data.frame("Sample" = "col6", "Avg_iCO2" = mean(col6$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col6$Delta_Raw_iCO2))
col7avg <- data.frame("Sample" = "col7", "Avg_iCO2" = mean(col7$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col7$Delta_Raw_iCO2))
col8avg <- data.frame("Sample" = "col8", "Avg_iCO2" = mean(col8$Delta_Raw_iCO2), "StdDev_iCO2" = sd(col8$Delta_Raw_iCO2))



sumaug13 <- rbind(col1avg, col2avg, col3avg, col4avg, col5avg, col6avg, col7avg, col8avg)

write.csv(sumaug13, here("Picarro/EOSTransects/081319/", "sumaug13.csv"))
