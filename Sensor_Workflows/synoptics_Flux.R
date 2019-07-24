#flux of synoptics 
library(here)
library(ggplot2)
library(dplyr)

# *** SET THE DATE ***
date<- "07182019"


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
sub.2 <- sub.2[500:565,]
rownames(sub.2) <- NULL

eos2plot <- ggplot(sub.2)+
  geom_line(aes(x= DateTime, y= Flux_eos2)) 
eos2plot

syn1 <- sub.2[2:6,]
syn5 <- sub.2[8:11,]
syn8 <- sub.2[13:17,]
syn11 <- sub.2[19:22,]
syn14 <- sub.2[27:30,]
waterfall <- sub.2[36:39,]
syn20 <- sub.2[44:47,]
syn23 <- sub.2[50:53,]
syn29 <- sub.2[57:60,]
syn35 <- sub.2[63:66,]
