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
  select(dateTime,Flux,Temperature..C.,CO2.Soil..ppm.,
         CO2.Soil.STD..ppm.,CO2.ATM..ppm.,CO2.ATM.STD..ppm.,Mode)
colnames(eos2) <- c("DateTime","Flux_eos2","Temp_C_eos2","CO2_Soil_ppm_eos2","CO2_Soil_STD_ppm_eos2",
                    "CO2_ATM_ppm_eos2","CO2_ATM_STD_ppm_eos2","Mode")


# Subset data so only records at 5 minute intervals are retained
sub.1 <- subset(eos2, format(DateTime,'%OS')=='00')
sub.2 <- subset(sub.1, format(DateTime,'%M')%in% c("00","05","10","15","20","25","30","35","40","45","50","55","60"))


eos2plot <- ggplot(sub.2)+
  geom_line(aes(x= DateTime, y= Flux_eos2)) 
eos2plot



# Export the data
write.csv(eos1,here("outputs",paste0("eosFD2_4A_",date,".csv")))

