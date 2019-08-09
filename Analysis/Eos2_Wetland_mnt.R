library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)
library('knitr')

date<- "08012019"


# eos1 data
eos2 <- read.csv(here("FieldData/EosFD",paste0("eos2_",date,".csv")))
eos2$Year <- paste0("20",eos2$Year)
eos2$dateTime <- as.POSIXct(as.character(paste0(eos2$Month,"/",eos2$Day,"/",eos2$Year," ",eos2$Time)), format = "%m/%d/%Y %H:%M:%OS")
eos2 <- eos2%>%
  select(dateTime,Flux,Temperature..C.,CO2.Soil..ppm..,
         CO2.Soil.STD..ppm.,CO2.ATM..ppm.,CO2.ATM.STD..ppm.,Mode)
colnames(eos2) <- c("DateTime","Flux_eos2","Temp_C_eos2","CO2_Soil_ppm_eos2","CO2_Soil_STD_ppm_eos2",
                    "CO2_ATM_ppm_eos2","CO2_ATM_STD_ppm_eos2","Mode")


# Subset data so only records at 5 minute intervals are retained
sub.1 <- subset(eos2, format(DateTime,'%OS')=='00')
sub.2 <- subset(sub.1, format(DateTime,'%M')%in% c("00","05","10","15","20","25","30","35","40","45","50","55","60"))
row.names(sub.2)<- NULL

eos2_wetland <- sub.2[1616:2098,]
eos2_wetland_avg <- mean(eos2_wetland$Flux_eos2)
eos2_wetland_min <- min(eos2_wetland$Flux_eos2)
eos2_wetland_max <- max(eos2_wetland$Flux_eos2)
eos2_wetland_std_dev <- sd(eos2_wetland$Flux_eos2)

plot <- ggplot(eos2_wetland)+
  geom_line(aes(x= DateTime, y= Flux_eos2)) +
  labs(x = "Time", y = "Flux")
plot
