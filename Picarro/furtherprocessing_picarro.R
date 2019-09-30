library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
allaug02 <- read.csv(here("Picarro/EOSTransects/080119/allaug02Data.csv"))

#make posic.ct, posixct again
allaug02$PosixCT <- as.POSIXct(allaug02$PosixCT)

#subset the data
Subsaug02 <- allaug02[c(53272:59000), ]

#Do an initial plot of C02 
plot <- ggplot(allaug02)+
geom_point(aes(x= PosixCT, y= X12CO2)) +
labs(x = "Time", y = "CO2") +
ggtitle("aug02 EOS Transect Pulls") 
plot

#Do an initial plot of Delta_i 
plot <- ggplot(Subsaug02)+
geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2)) +
labs(x = "Time", y = "Delta_Raw") +
ggtitle("aug02 EOS Transect Pulls") 

plot
ggplotly(plot)




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



samplesaug02 <- rbind(col1, col2, col3, ecu4, col4, col5, ecu3, col6, col7, col8)

write.csv(samplesaug02, here("Picarro/EOSTransects/080119/", "samplesaug02.csv"))

#now let's plot only the samples 

#Do an initial plot of Delta_i 
plot <- ggplot(samplesaug02)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2)) +
  labs(x = "Time", y = "Delta_Raw") +
  ggtitle("aug02 EOS Transect Pulls") 

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



sumaug02 <- rbind(col1avg, col2avg, col3avg, ecu3avg, col4avg, col5avg, ecu4avg, col6avg, col7avg, col8avg)

write.csv(sumaug02, here("Picarro/EOSTransects/080119/", "sumaug02.csv"))
