library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
allaug09 <- read.csv(here("Picarro/EOSTransects/080819/comprehensiveaug09.csv"))

# Combine Date and time into one column
allaug09$DateTime <- paste0(allaug09$DATE," ",substr(allaug09$TIME,1,8))

# Convert to PosixCT
allaug09$PosixCT <- as.POSIXct(allaug09$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#make posic.ct, posixct again
allaug09$PosixCT <- as.POSIXct(allaug09$PosixCT)

#only take what you need
allaug09 <- allaug09 %>%
  select(DATE, PosixCT, X12CO2, Delta_Raw_iCO2, Delta_30s_iCO2,HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)

#savethis
write.csv(allaug09, here("Picarro/EOSTransects/080819/alldeltaaug09.csv"))

#subset the data
subsaug09 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 14:30:00"
                 & allaug09$PosixCT < "2019-08-09 16:15:00"), ]
#savethis
write.csv(subsaug09, here("Picarro/EOSTransects/080819/subsaug09.csv"))

#Do an initial plot of Delta_i 
plot <- ggplot(subsaug09)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2), color="blue")+
  geom_point(aes(x= PosixCT, y= Delta_30s_iCO2), color="red")+
  labs(x = "Time", y = "Delta")+
  ggtitle("August 09 Delta Co2 Raw and 30 seconds") 

plot
ggplotly(plot)

#Now let's get the exact sample times that we need for 30 seconds 


col1 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 18:26:39"
                        & allaug09$PosixCT < "2019-08-09 18:27:32"), ]
col1$Sample <- as.character("col1")

col2 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 18:30:46"
                         & allaug09$PosixCT < "2019-08-09 18:32:45"), ]
col2$Sample <- as.character("col2")

col3 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 18:35:30"
                         & allaug09$PosixCT < "2019-08-09 18:37:30"), ]
col3$Sample <- as.character("col3")

col4 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 18:40:30"
                         & allaug09$PosixCT < "2019-08-09 18:41:30"), ]
col4$Sample <- as.character("col4")

col5 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 18:44:30"
                         & allaug09$PosixCT < "2019-08-09 18:45:30"), ]
col5$Sample <- as.character("col5")

col6 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 18:53:30"
                         & allaug09$PosixCT < "2019-08-09 18:56:30"), ]
col6$Sample <- as.character("col6")

col7 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 19:00:30"
                         & allaug09$PosixCT < "2019-08-09 19:02:30"), ]
col7$Sample <- as.character("col7")

col8 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 19:06:30"
                         & allaug09$PosixCT < "2019-08-09 19:08:30"), ]
col8$Sample <- as.character("col8")

ecu1 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 18:49:50"
                        & allaug09$PosixCT < "2019-08-09 18:50:45"), ]
ecu1$Sample <- as.character("ecu1")

ecu2 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 18:49:50"
                        & allaug09$PosixCT < "2019-08-09 18:50:45"), ]
ecu2$Sample <- as.character("ecu2")


samplesaug09 <- rbind(col1, col2, col3, col4, col5, col6, col7, ecu3, ecu4)

write.csv(samplesaug09, here("Picarro/EOSTransects/080819/", "samplesalldataaug09.csv"))



#let's get the average and std. deviation of all ecu samples 

ecu3avg <- data.frame("Sample" = "ecu3", "Avg_iCO2" = mean(ecu3$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu3$Delta_30s_iCO2))
ecu4avg <- data.frame("Sample" = "ecu4", "Avg_iCO2" = mean(ecu4$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu4$Delta_30s_iCO2))

sumaug09ecu <- rbind(ecu3avg, ecu4avg)

write.csv(sumaug09ecu, here("Picarro/EOSTransects/081319/", "sumecuaug09.csv"))

