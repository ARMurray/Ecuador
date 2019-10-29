library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
alljuly23 <- read.csv(here("Picarro/EOSTransects/072219/comprehensivejuly23.csv"))

# Combine Date and time into one column
alljuly23$DateTime <- paste0(alljuly23$DATE," ",substr(alljuly23$TIME,1,8))

# Convert to PosixCT
alljuly23$PosixCT <- as.POSIXct(alljuly23$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#make posic.ct, posixct again
alljuly23$PosixCT <- as.POSIXct(alljuly23$PosixCT)

#only take what you need
alljuly23 <- alljuly23 %>%
  select(DATE, PosixCT, X12CO2, Delta_Raw_iCO2, Delta_30s_iCO2,HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)

#savethis
write.csv(alljuly23, here("Picarro/EOSTransects/072219/alldeltajuly23.csv"))

#subset the data
subsjuly23 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 15:00:00"
                 & alljuly23$PosixCT < "2019-07-23 16:45:00"), ]
#savethis
write.csv(subsjuly23, here("Picarro/EOSTransects/072219/subsjuly23.csv"))

#Do an initial plot of Delta_i 
plot <- ggplot(subsjuly23)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2), color="blue")+
  geom_point(aes(x= PosixCT, y= Delta_30s_iCO2), color="red")+
  labs(x = "Time", y = "Delta")+
  ggtitle("July 23 Delta Co2 Raw and 30 seconds") 

plot
ggplotly(plot)

#Now let's get the exact sample times that we need for 30 seconds 

ecu1 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 15:15:24"
                         & alljuly23$PosixCT < "2019-07-23 15:18:17"), ]
ecu1$Sample <- as.character("ecu1")

col1 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 15:22:20"
                        & alljuly23$PosixCT < "2019-07-23 15:24:39"), ]
col1$Sample <- as.character("col1")

col5 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 15:28:38"
                         & alljuly23$PosixCT < "2019-07-23 15:31:31"), ]
col5$Sample <- as.character("col5")

col8 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 15:36:10"
                         & alljuly23$PosixCT < "2019-07-23 15:38:30"), ]
col8$Sample <- as.character("col8")

col4 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 15:43:30"
                         & alljuly23$PosixCT < "2019-07-23 15:45:30"), ]
col4$Sample <- as.character("col4")

ecu2 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 15:56:15"
                         & alljuly23$PosixCT < "2019-07-23 15:59:10"), ]
ecu2$Sample <- as.character("ecu2")

col3 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 16:03:30"
                         & alljuly23$PosixCT < "2019-07-23 16:05:30"), ]
col3$Sample <- as.character("col3")

col7 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 16:11:30"
                         & alljuly23$PosixCT < "2019-07-23 16:13:30"), ]
col7$Sample <- as.character("col7")

col2 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 16:19:51"
                         & alljuly23$PosixCT < "2019-07-23 16:22:01"), ]
col2$Sample <- as.character("col2")

col6 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 16:25:30"
                         & alljuly23$PosixCT < "2019-07-23 16:26:30"), ]
col6$Sample <- as.character("col6")

ecu3 <- alljuly23[ which(alljuly23$PosixCT > "2019-07-23 16:31:42"
                        & alljuly23$PosixCT < "2019-07-23 16:34:51"), ]
ecu3$Sample <- as.character("ecu3")





samplesjuly23 <- rbind(col1, col2, col3, col4, col5, col6, col7, col8, ecu1, ecu3, ecu2)

write.csv(samplesjuly23, here("Picarro/EOSTransects/072219/", "samplesalldatajuly23.csv"))


#let's get the average and std. deviation of all ecu samples 

ecu1avg <- data.frame("Sample" = "ecu1", "Avg_iCO2" = mean(ecu1$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu1$Delta_30s_iCO2))
ecu2avg <- data.frame("Sample" = "ecu2", "Avg_iCO2" = mean(ecu2$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu2$Delta_30s_iCO2))
ecu3avg <- data.frame("Sample" = "ecu3", "Avg_iCO2" = mean(ecu3$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu3$Delta_30s_iCO2))

sumjuly23ecu <- rbind(ecu1avg, ecu2avg, ecu3avg)

write.csv(sumjuly23ecu, here("Picarro/EOSTransects/072219/", "sumecujuly23.csv"))


#now let's get the ecuador averages for this day combinded

#First let's make a table with just the ecu samples

ecutogether <- rbind(ecu1,ecu2,ecu3)

July23avg <- data.frame("Day" = "July17", "Avg_iCO2" = mean(ecutogether$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecutogether$Delta_30s_iCO2))

write.csv(July23avg, here("Picarro/EOSTransects/072219/", "july23alldayecuavg.csv"))
