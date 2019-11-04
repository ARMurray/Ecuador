library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#open up the cleaned file that you want to work with 
allaug13 <- read.csv(here("Picarro/EOSTransects/081319/comprehensiveaug13.csv"))

# Combine Date and time into one column
allaug13$DateTime <- paste0(allaug13$DATE," ",substr(allaug13$TIME,1,8))

# Convert to PosixCT
allaug13$PosixCT <- as.POSIXct(allaug13$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#make posic.ct, posixct again
allaug13$PosixCT <- as.POSIXct(allaug13$PosixCT)

#only take what you need
allaug13 <- allaug13 %>%
  select(DATE, PosixCT, X12CO2, Delta_Raw_iCO2, Delta_30s_iCO2,HR_12CH4, HP_12CH4, Delta_iCH4_Raw, HR_Delta_iCH4_Raw, HR_Delta_iCH4_30s, HP_Delta_iCH4_Raw, HP_Delta_iCH4_30s)

#savethis
write.csv(allaug13, here("Picarro/EOSTransects/081319/alldeltaaug13.csv"))

#subset the data
subsaug13 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 20:30:00"
                 & allaug13$PosixCT < "2019-08-13 22:00:00"), ]
#savethis
write.csv(subsaug13, here("Picarro/EOSTransects/081319/subsaug13.csv"))

#Do an initial plot of Delta_i 
plot <- ggplot(subsaug13)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2), color="blue")+
  geom_point(aes(x= PosixCT, y= Delta_30s_iCO2), color="red")+
  labs(x = "Time", y = "Delta")+
  ggtitle("August 13 Delta Co2 Raw and 30 seconds") 

plot
ggplotly(plot)

#Now let's get the exact sample times that we need for 30 seconds 

ecu3 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 20:44:30"
                        & allaug13$PosixCT < "2019-08-13 20:47:30"), ]
ecu3$Sample <- as.character("ecu3")

col1 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 20:53:30"
                        & allaug13$PosixCT < "2019-08-13 20:54:30"), ]
col1$Sample <- as.character("col1")

col2 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 20:59:30"
                         & allaug13$PosixCT < "2019-08-13 21:01:30"), ]
col2$Sample <- as.character("col2")

col3 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 21:06:30"
                         & allaug13$PosixCT < "2019-08-13 21:08:30"), ]
col3$Sample <- as.character("col3")

col4 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 21:14:30"
                         & allaug13$PosixCT < "2019-08-13 21:15:30"), ]
col4$Sample <- as.character("col4")

col5 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 21:21:30"
                         & allaug13$PosixCT < "2019-08-13 21:22:30"), ]
col5$Sample <- as.character("col5")

ecu4 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 21:27:30"
                        & allaug13$PosixCT < "2019-08-13 21:28:30"), ]
ecu4$Sample <- as.character("ecu4")

col6 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 21:33:30"
                         & allaug13$PosixCT < "2019-08-13 21:35:30"), ]
col6$Sample <- as.character("col6")

col7 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 21:41:30"
                         & allaug13$PosixCT < "2019-08-13 21:42:30"), ]
col7$Sample <- as.character("col7")

col8 <- allaug13[ which(allaug13$PosixCT > "2019-08-13 21:47:30"
                         & allaug13$PosixCT < "2019-08-13 21:48:30"), ]
col8$Sample <- as.character("col8")


samplesaug13 <- rbind(col1, col2, col3, col4, col5, col6, col7, col8, ecu3, ecu4)

write.csv(samplesaug13, here("Picarro/EOSTransects/081319/", "samplesalldataaug13.csv"))



#let's get the average and std. deviation of all ecu samples 

ecu3avg <- data.frame("Sample" = "ecu3", "Avg_iCO2" = mean(ecu3$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu3$Delta_30s_iCO2))
ecu4avg <- data.frame("Sample" = "ecu4", "Avg_iCO2" = mean(ecu4$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecu4$Delta_30s_iCO2))

sumaug13ecu <- rbind(ecu3avg, ecu4avg)

write.csv(sumaug13ecu, here("Picarro/EOSTransects/081319/", "sumecuaug13.csv"))


#now let's get the ecuador averages for this day combinded

#First let's make a table with just the ecu samples

ecutogether <- rbind(ecu3, ecu4)

Aug13avg <- data.frame("Day" = "Aug13", "Avg_iCO2" = mean(ecutogether$Delta_30s_iCO2), "StdDev_iCO2" = sd(ecutogether$Delta_30s_iCO2))

write.csv(Aug13avg, here("Picarro/EOSTransects/071619/", "Aug13alldayecuavg.csv"))

#ok we need to get a summary table just for the collars for each day 

#ok now let's find the average and std. deviation for each bag pull and put that into a new data frame



col1avg <- data.frame("Sample" = "col1", "Avg_iCO2" = mean(col1$Delta_30s_iCO2), "StdDev_iCO2" = sd(col1$Delta_30s_iCO2))
col2avg <- data.frame("Sample" = "col2", "Avg_iCO2" = mean(col2$Delta_30s_iCO2), "StdDev_iCO2" = sd(col2$Delta_30s_iCO2))
col3avg <- data.frame("Sample" = "col3", "Avg_iCO2" = mean(col3$Delta_30s_iCO2), "StdDev_iCO2" = sd(col3$Delta_30s_iCO2))
col4avg <- data.frame("Sample" = "col4", "Avg_iCO2" = mean(col4$Delta_30s_iCO2), "StdDev_iCO2" = sd(col4$Delta_30s_iCO2))
col5avg <- data.frame("Sample" = "col5", "Avg_iCO2" = mean(col5$Delta_30s_iCO2), "StdDev_iCO2" = sd(col5$Delta_30s_iCO2))
col6avg <- data.frame("Sample" = "col6", "Avg_iCO2" = mean(col6$Delta_30s_iCO2), "StdDev_iCO2" = sd(col6$Delta_30s_iCO2))
col7avg <- data.frame("Sample" = "col7", "Avg_iCO2" = mean(col7$Delta_30s_iCO2), "StdDev_iCO2" = sd(col7$Delta_30s_iCO2))
col8avg <- data.frame("Sample" = "col8", "Avg_iCO2" = mean(col8$Delta_30s_iCO2), "StdDev_iCO2" = sd(col8$Delta_30s_iCO2))



sumaug13_30 <- rbind(col1avg, col2avg, col3avg, col4avg, col5avg, col6avg, col7avg, col8avg)

write.csv(sumaug13_30, here("Picarro/EOSTransects/081319/", "sumaug13_30sec_uncorrected.csv"))


#ok now let's do the correction 

sumaug13_30$Correction <- as.numeric("0.734068306")
sumaug13_30$CorrectedAverage <- as.numeric(c(sumaug13_30$Avg_iCO2 + sumaug13_30$Correction))

write.csv(sumaug13_30, here("Picarro/EOSTransects/081319/", "sumaug13_30sec_corrected.csv"))



