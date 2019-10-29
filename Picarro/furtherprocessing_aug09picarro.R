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


col1 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 15:23:30"
                        & allaug09$PosixCT < "2019-08-09 15:25:30"), ]
col1$Sample <- as.character("col1")

col2 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 15:29:30"
                         & allaug09$PosixCT < "2019-08-09 15:31:30"), ]
col2$Sample <- as.character("col2")

col3 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 15:34:30"
                         & allaug09$PosixCT < "2019-08-09 15:35:30"), ]
col3$Sample <- as.character("col3")

col4 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 15:40:30"
                         & allaug09$PosixCT < "2019-08-09 15:43:30"), ]
col4$Sample <- as.character("col4")

col5 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 15:46:30"
                         & allaug09$PosixCT < "2019-08-09 15:47:30"), ]
col5$Sample <- as.character("col5")

col6 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 15:50:30"
                         & allaug09$PosixCT < "2019-08-09 15:53:30"), ]
col6$Sample <- as.character("col6")

col7 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 15:58:30"
                         & allaug09$PosixCT < "2019-08-09 15:59:30"), ]
col7$Sample <- as.character("col7")

col8 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 16:05:30"
                         & allaug09$PosixCT < "2019-08-09 16:08:30"), ]
col8$Sample <- as.character("col8")

ecu1 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 14:41:42"
                        & allaug09$PosixCT < "2019-08-09 14:42:21"), ]
ecu1$Sample <- as.character("ecu1")

ecu2 <- allaug09[ which(allaug09$PosixCT > "2019-08-09 16:11:57"
                        & allaug09$PosixCT < "2019-08-09 16:12:09"), ]
ecu2$Sample <- as.character("ecu2")


samplesaug09 <- rbind(col1, col2, col3, col4, col5, col6, col7, col8, ecu1, ecu2)

write.csv(samplesaug09, here("Picarro/EOSTransects/080819/", "samplesalldataaug09.csv"))



#let's get the average and std. deviation of all ecu samples 

ecu1avg <- data.frame("Sample" = "ecu1", "Avg_iCO2" = mean(ecu1$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu1$Delta_30s_iCO2))
ecu2avg <- data.frame("Sample" = "ecu2", "Avg_iCO2" = mean(ecu2$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu2$Delta_30s_iCO2))

sumaug09ecu <- rbind(ecu1avg, ecu2avg)

write.csv(sumaug09ecu, here("Picarro/EOSTransects/080819/", "sumecuaug09.csv"))


#now let's get the ecuador averages for this day combinded

#First let's make a table with just the ecu samples

ecutogether <- rbind(ecu1, ecu2)

Aug09avg <- data.frame("Day" = "Aug09", "Avg_iCO2" = mean(ecutogether$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecutogether$Delta_30s_iCO2))

write.csv(Aug09avg, here("Picarro/EOSTransects/071619/", "Aug09alldayecuavg.csv"))

