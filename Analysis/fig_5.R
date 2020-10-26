
library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)
library('knitr')
library(ggpubr)
library("ggpubr")

date<- "07182019"


# eos1 data
eos2 <- read.csv(here("FieldData/EosFD",paste0("eos2_",date,".csv")))
eos2$Year <- paste0("20",eos2$Year)
eos2$dateTime <- as.POSIXct(as.character(paste0(eos2$Year,"-",eos2$Month,"-",eos2$Day," ",eos2$Time)), format = "%Y-%m-%d %H:%M:%OS")
eos2 <- eos2%>%
  select(dateTime,Flux,Temperature..C.,CO2.Soil..ppm.,
         CO2.Soil.STD..ppm.,CO2.ATM..ppm.,CO2.ATM.STD..ppm.,Mode)
colnames(eos2) <- c("DateTime","Flux_eos2","Temp_C_eos2","CO2_Soil_ppm_eos2","CO2_Soil_STD_ppm_eos2",
                    "CO2_ATM_ppm_eos2","CO2_ATM_STD_ppm_eos2","Mode")


# Subset data so only records at 5 minute intervals are retained
sub.1 <- subset(eos2, format(DateTime,'%OS')=='00')
sub.2 <- subset(sub.1, format(DateTime,'%M')%in% c("00","05","10","15","20","25","30","35","40","45","50","55","60"))

row.names(sub.2) <- NULL

col1.1 <- sub.2[435:438,]
col2.1 <- sub.2[443:446,]
col3.1 <- sub.2[452:455,]
col4.1 <- sub.2[460:463,]
col5.1 <- sub.2[472:475,]
col6.1 <- sub.2[480:483,]
col7.1 <- sub.2[489:492,]
date<- "07222019"


# eos1 data
eos2 <- read.csv(here("FieldData/EosFD",paste0("eos2_",date,".csv")))
eos2$Year <- paste0("20",eos2$Year)
eos2$dateTime <- as.POSIXct(as.character(paste0(eos2$Year,"-",eos2$Month,"-",eos2$Day," ",eos2$Time)), format = "%Y-%m-%d %H:%M:%OS")
eos2 <- eos2%>%
  select(dateTime,Flux,Temperature..C.,CO2.Soil..ppm..,
         CO2.Soil.STD..ppm.,CO2.ATM..ppm.,CO2.ATM.STD..ppm.,Mode)
colnames(eos2) <- c("DateTime","Flux_eos2","Temp_C_eos2","CO2_Soil_ppm_eos2","CO2_Soil_STD_ppm_eos2",
                    "CO2_ATM_ppm_eos2","CO2_ATM_STD_ppm_eos2","Mode")


# Subset data so only records at 5 minute intervals are retained
sub.1 <- subset(eos2, format(DateTime,'%OS')=='00')
sub.2 <- subset(sub.1, format(DateTime,'%M')%in% c("00","05","10","15","20","25","30","35","40","45","50","55","60"))

rownames(sub.2) <- NULL
sub.2$Flux_eos2 <- as.numeric(as.character(sub.2$Flux_eos2))

col1.2 <- sub.2[1758:1761,]
col2.2 <- sub.2[1754:1757,]
col3.2 <- sub.2[1749:1752,]
col4.2 <- sub.2[1743:1746,]
col5.2 <- sub.2[1711:1714,]
col6.2 <- sub.2[1716:1719,]
col7.2 <- sub.2[1726:1729,]
col8.2 <- sub.2[1732:1735,]
date<- "07312019"


# eos1 data
eos2 <- read.csv(here("FieldData/EosFD",paste0("eos2_",date,".csv")))
eos2$Year <- paste0("20",eos2$Year)
eos2$dateTime <- as.POSIXct(as.character(paste0(eos2$Year,"-",eos2$Month,"-",eos2$Day," ",eos2$Time)), format = "%Y-%m-%d %H:%M:%OS")
eos2 <- eos2%>%
  select(dateTime,Flux,Temperature..C.,CO2.Soil..ppm..,
         CO2.Soil.STD..ppm.,CO2.ATM..ppm.,CO2.ATM.STD..ppm.,Mode)
colnames(eos2) <- c("DateTime","Flux_eos2","Temp_C_eos2","CO2_Soil_ppm_eos2","CO2_Soil_STD_ppm_eos2",
                    "CO2_ATM_ppm_eos2","CO2_ATM_STD_ppm_eos2","Mode")

eos1 <- read.csv(here("FieldData/EosFD/eos1_FIX_07312019.csv"))
eos1 <- eos1%>%
  select(DateTime,Flux_1,Temp_C_1,CO2_Soil_1,
         CO2_Soil_STD_1,CO2_ATM_1,CO2_ATM_STD_1,Mode_1)
colnames(eos1) <- c("DateTime","Flux_eos1","Temp_C_eos1","CO2_Soil_ppm_eos1","CO2_Soil_STD_ppm_eos1","CO2_ATM_ppm_eos1","CO2_ATM_STD_ppm_eos1","Mode")

eos1$Flux_eos1 <- as.numeric(as.character(eos1$Flux_eos1))

col1.3 <- eos1[2321:2324,]
col2.3 <- eos1[2326:2329,]
col3.3 <- eos1[2331:2334,]
col4.3 <- eos1[2336:2339,]
col5.3 <- eos2[1614:1617,]
col6.3 <- eos2[1620:1623,]
col7.3 <- eos2[1625:1628,]
col8.3 <- eos2[1631:1634,]
date<- "08012019"


# eos2 data
eos2 <- read.csv(here("FieldData/EosFD",paste0("eos2_",date,".csv")))
eos2$Year <- paste0("20",eos2$Year)
eos2$dateTime <- as.POSIXct(as.character(paste0(eos2$Year,"-",eos2$Month,"-",eos2$Day," ",eos2$Time)), format = "%Y-%m-%d %H:%M:%OS")
eos2 <- eos2%>%
  select(dateTime,Flux,Temperature..C.,CO2.Soil..ppm..,
         CO2.Soil.STD..ppm.,CO2.ATM..ppm.,CO2.ATM.STD..ppm.,Mode)
colnames(eos2) <- c("DateTime","Flux_eos2","Temp_C_eos2","CO2_Soil_ppm_eos2","CO2_Soil_STD_ppm_eos2",
                    "CO2_ATM_ppm_eos2","CO2_ATM_STD_ppm_eos2","Mode")


col1.4 <- eos2[2536:2539,]
col2.4 <- eos2[2532:2535,]
col3.4 <- eos2[2540:2543,]
col4.4 <- eos2[2544:2547,]
col5.4 <- eos2[2507:2510,]
col6.4 <- eos2[2511:2514,]
col7.4 <- eos2[2515:2518,]
col8.4 <- eos2[2520:2523,]

# eos2 data
eos2 <- read.csv(here("FieldData/EosFD/eos2_08142019.csv"))

eos2$Year <- paste0("20",eos2$Year)
eos2$dateTime <- as.POSIXct(as.character(paste0(eos2$Year,"-",eos2$Month,"-",eos2$Day," ",eos2$Time)), format = "%Y-%m-%d %H:%M:%OS")
eos2 <- eos2%>%
  select(dateTime,Flux)
colnames(eos2) <- c("DateTime","Flux_eos2")

eos2$Flux_eos2 <- as.numeric(as.character(eos2$Flux_eos2))

col1.5 <- eos2[2815:2818,]
col2.5 <- eos2[2820:2823,]
col3.5 <- eos2[2824:2826,]
col4.5 <- eos2[2829:2832,]
col5.5 <- eos2[2808:2811,]
col6.5 <- eos2[2796:2799,]
col7.5 <- eos2[2800:2803,]
col8.5 <- eos2[2804:2807,]

# eos2 data
eos2 <- read.csv(here("FieldData/EosFD/eos2_08142019.csv"))
eos2$Year <- paste0("20",eos2$Year)
eos2$dateTime <- as.POSIXct(as.character(paste0(eos2$Year,"-",eos2$Month,"-",eos2$Day," ",eos2$Time)), format = "%Y-%m-%d %H:%M:%OS")
eos2 <- eos2%>%
  select(dateTime,Flux)
colnames(eos2) <- c("DateTime","Flux_eos2")

eos2$Flux_eos2 <- as.numeric(as.character(eos2$Flux_eos2))

col1.6 <- eos2[3280:3283,]
col2.6 <- eos2[3284:3287,]
col3.6 <- eos2[3288:3291,]
col4.6 <- eos2[3292:3295,]
col5.6 <- eos2[3262:3265,]
col6.6 <- eos2[3266:3269,]
col7.6 <- eos2[3270:3273,]
col8.6 <- eos2[3274:3277,]
eos1 <- read.csv(here("FieldData/EosFD/eos1_08132019.1.csv"))
eos1$Year <- paste0("20",eos1$Year)
eos1$dateTime <- as.POSIXct(as.character(paste0(eos1$Year,"-",eos1$Month,"-",eos1$Day," ",eos1$Time)), format = "%Y-%m-%d %H:%M:%OS")
eos1 <- eos1%>%
  select(dateTime,Flux,Temperature..C.,CO2.Soil..ppm.,
         CO2.Soil.STD..ppm.,CO2.ATM..ppm.,CO2.ATM.STD..ppm.,Mode)
colnames(eos1) <- c("DateTime","Flux_eos1","Temp_C_eos1","CO2_Soil_ppm_eos1","CO2_Soil_STD_ppm_eos1",
                    "CO2_ATM_ppm_eos1","CO2_ATM_STD_ppm_eos1","Mode")
eos1$Flux_eos1 <- as.numeric(as.character(eos1$Flux_eos1))

eos2 <- read.csv(here("FieldData/EosFD/eos2_08142019.csv"))
eos2$Year <- paste0("20",eos2$Year)
eos2$dateTime <- as.POSIXct(as.character(paste0(eos2$Year,"-",eos2$Month,"-",eos2$Day," ",eos2$Time)), format = "%Y-%m-%d %H:%M:%OS")
eos2 <- eos2%>%
  select(dateTime,Flux)
colnames(eos2) <- c("DateTime","Flux_eos2")

eos2$Flux_eos2 <- as.numeric(as.character(eos2$Flux_eos2))

col1.7 <- eos2[3701:3704,]
col2.7 <- eos2[3706:3709,]
col3.7 <- eos2[3711:3714,]
col4.7 <- eos2[3715:3718,]
col5.7 <- eos1[1344:1347,]
col6.7 <- eos1[1348:1351,]
col7.7 <- eos1[1352:1355,]
col8.7 <- eos1[1356:1359,]

drycol <- c(col1.1$Flux_eos2,col1.2$Flux_eos2, col1.3$Flux_eos1, col1.4$Flux_eos2, col1.5$Flux_eos2, col1.6$Flux_eos2, col1.7$Flux_eos2, col2.1$Flux_eos2, col2.2$Flux_eos2, col2.3$Flux_eos1, col2.4$Flux_eos2, col2.5$Flux_eos2, col2.6$Flux_eos2, col2.7$Flux_eos2, col7.1$Flux_eos2, col7.2$Flux_eos2, col7.3$Flux_eos2, col7.4$Flux_eos2, col7.5$Flux_eos2, col7.6$Flux_eos2, col7.7$Flux_eos1, col8.2$Flux_eos2, col8.3$Flux_eos2, col8.4$Flux_eos2, col8.5$Flux_eos2, col8.6$Flux_eos2, col8.7$Flux_eos1)
drycol <- data.frame(drycol)
avgdrycol <- mean(drycol$drycol)
sddrycol <- sd(drycol$drycol)

#satcol <- c(col3.1$Flux_eos2, col3.2$Flux_eos2, col3.3$Flux_eos1, col3.4$Flux_eos2, col3.5$Flux_eos2, col3.6$Flux_eos2, col3.7$Flux_eos2, col4.1$Flux_eos2, col4.2$Flux_eos2, col4.3$Flux_eos1, col4.4$Flux_eos2, col4.5$Flux_eos2, col4.6$Flux_eos2, col4.7$Flux_eos2, col5.1$Flux_eos2, col5.2$Flux_eos2, col5.3$Flux_eos2, col5.4$Flux_eos2, col5.5$Flux_eos2, col5.6$Flux_eos2, col5.7$Flux_eos1, col6.1$Flux_eos2, col6.2$Flux_eos2, col6.3$Flux_eos2, col6.4$Flux_eos2, col6.5$Flux_eos2, col6.6$Flux_eos2, col6.7$Flux_eos1)
#satcol <- data.frame(satcol)
#avgsatcol <- mean(satcol$satcol)
#sdsatcol <- sd(satcol$satcol)
satcol <- c(col3.1$Flux_eos2, col3.2$Flux_eos2, col3.3$Flux_eos1, col3.4$Flux_eos2, col3.5$Flux_eos2, col3.6$Flux_eos2, col3.7$Flux_eos2, col4.1$Flux_eos2, col4.2$Flux_eos2, col4.3$Flux_eos1, col4.4$Flux_eos2, col4.5$Flux_eos2, col4.6$Flux_eos2, col4.7$Flux_eos2, col6.1$Flux_eos2, col6.2$Flux_eos2, col6.3$Flux_eos2, col6.4$Flux_eos2, col6.5$Flux_eos2, col6.6$Flux_eos2, col6.7$Flux_eos1)
satcol <- data.frame(satcol)
avgsatcol <- mean(satcol$satcol)
sdsatcol <- sd(satcol$satcol)

df <- data.frame(sat=c("avgSat", "avgDry"),
                 avg=c(avgsatcol, avgdrycol),
                 sd= c(sdsatcol,sddrycol))
df




p <- ggplot(df, aes(x=sat, y=avg)) + 
  geom_bar(stat="identity", position=position_dodge()) +
  geom_errorbar(aes(ymin=avg-sd, ymax=avg+sd), width=.2,
                position=position_dodge(.9))
p


synoptics <- read.csv(here("FieldData/EosFD/All_Synoptic_Flux_Data.csv"))
synoptics <- data.frame(synoptics)
synoptics
flux1 <- data.frame(c(synoptics[1:23,]$Flux, synoptics[1:19,]$Flux.1, synoptics[1:24,]$Flux.2, synoptics[1:24,]$Flux.3, synoptics[1:24,]$Flux.4))
flux2 <- data.frame(c(synoptics[24:39,]$Flux, synoptics[20:31,]$Flux.1, synoptics[25:40,]$Flux.2, synoptics[25:40,]$Flux.3, synoptics[25:39,]$Flux.4))
avgbelow <- mean(flux1$c.synoptics.1.23....Flux..synoptics.1.19....Flux.1..synoptics.1.24..)
avgabove <- mean(flux2$c.synoptics.24.39....Flux..synoptics.20.31....Flux.1..synoptics.25.40..)
sdbelow <- sd(flux1$c.synoptics.1.23....Flux..synoptics.1.19....Flux.1..synoptics.1.24..)
sdabove <- sd(flux2$c.synoptics.24.39....Flux..synoptics.20.31....Flux.1..synoptics.25.40..)
df <- data.frame(sat=c("Sat", "Dry", "below", "above"),
                 avg=c(avgsatcol, avgdrycol, avgbelow, avgabove),
                 sd= c(sdsatcol,sddrycol, sdbelow, sdabove))
                 
df
#my_data <- data.frame(group=c("Upper", "Lower", "Dry", "Sat"),
                      #flux=c(flux2, flux1, drycol, satcol))


#res.aov <- aov(flux ~ group, data = my_data)
# Summary of the analysis
#summary(res.aov)


p <- ggplot(df, aes(x=sat, y=avg)) + 
  geom_bar(stat="identity", position=position_dodge(), fill = c("dodgerblue3", "dodgerblue1", "darkolivegreen4", "darkolivegreen3")) +
  geom_errorbar(aes(ymin=avg-sd, ymax=avg+sd), width=.2,
                position=position_dodge(.9)) +
labs(x= "Landscape Position", y=expression(bold(CO["2"]~Flux~'[umol'/~m^2~s~']')),axis.title.y = element_text(face="bold")) + theme_bw(base_size = 20) +
  theme( axis.text.y = element_text(size=14), axis.text.x = element_text(size=14), axis.title.x = element_text(face="bold"))+
  scale_x_discrete(labels=c("Upper Reach", "Lower Reach", "Unsaturated Terrestrial", "Saturated Terrestrial"))+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 
p
eos2 <- read.csv(here("FieldData/EosFD/eos2_08142019.csv"))
eos2$Year <- paste0("20",eos2$Year)
eos2$dateTime <- as.POSIXct(as.character(paste0(eos2$Year,"-",eos2$Month,"-",eos2$Day," ",eos2$Time)), format = "%Y-%m-%d %H:%M:%OS")
eos2 <- eos2%>%
  select(dateTime,Flux)
colnames(eos2) <- c("DateTime","Flux_eos2")
eos2$Flux_eos2 <- as.numeric(as.character(eos2$Flux_eos2))


eos1 <- read.csv(here("FieldData/EosFD/eos1_08132019.1.csv"))
eos1$Year <- paste0("20",eos1$Year)
eos1$dateTime <- as.POSIXct(as.character(paste0(eos1$Year,"-",eos1$Month,"-",eos1$Day," ",eos1$Time)), format = "%Y-%m-%d %H:%M:%OS")
eos1 <- eos1%>%
  select(dateTime,Flux,Temperature..C.,CO2.Soil..ppm.,
         CO2.Soil.STD..ppm.,CO2.ATM..ppm.,CO2.ATM.STD..ppm.,Mode)
colnames(eos1) <- c("DateTime","Flux_eos1","Temp_C_eos1","CO2_Soil_ppm_eos1","CO2_Soil_STD_ppm_eos1","CO2_ATM_ppm_eos1","CO2_ATM_STD_ppm_eos1","Mode")
eos1$Flux_eos1 <- as.numeric(as.character(eos1$Flux_eos1))

land <- eos2[3078:3251,]
land <- subset(land, format(DateTime,'%OS')=='00')
land <- subset(land, format(DateTime,'%M')%in% c("00","05","10","15","20","25","30","35","40","45","50","55","60"))
row.names(land) <- NULL

water <- eos1[580:753,]
water <- subset(water, format(DateTime,'%OS')=='00')
water <- subset(water, format(DateTime,'%M')%in% c("00","05","10","15","20","25","30","35","40","45","50","55","60"))
row.names(water) <- NULL


landwater <- ggplot() + geom_point(data = land, aes(x= DateTime, y= Flux_eos2), color = "green", size = 1) +
  geom_point(data = water, aes(x=DateTime, y= Flux_eos1), color = "blue", size = 1) +
  labs(x= "Date", y=expression(bold(CO["2"]~Flux~'[umol'/~m^2~s~']')),axis.title.y = element_text(face="bold")) + theme_bw(base_size = 20) +
  theme( axis.text.y = element_text(size=14), axis.text.x = element_text(size=14), axis.title.x = element_text(face="bold"))+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 
landwater


landwater <- ggplot() + geom_line(data = land, aes(x= DateTime, y= Flux_eos2), color = "green", size = 1) +
  geom_line(data = water, aes(x=DateTime, y= Flux_eos1), color = "blue", size = 1) + labs(x = "Date",y=expression(bold(Flux~'[umol'/~m^2~s^1~']')))+ theme_bw(base_size = 18)

landwater
