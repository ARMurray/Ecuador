library(here)
library(ggplot2)
library(dplyr)

# *** SET THE DATE ***
date<- "07182019"


# eos1 data
eos1 <- read.csv(here("FieldData/EosFD",paste0("eos1_",date,".csv")))
eos1$Year <- paste0("20",eos1$Year)
eos1$dateTime <- as.POSIXct(as.character(paste0(eos1$Month,"/",eos1$Day,"/",eos1$Year," ",eos1$Time)), format = "%m/%d/%Y %H:%M:%OS")
eos1 <- eos1%>%
  select(dateTime,Flux,Temperature..C.,CO2.Soil..ppm.,
         CO2.Soil.STD..ppm.,CO2.ATM..ppm.,CO2.ATM.STD..ppm.,Mode)
colnames(eos1) <- c("DateTime","Flux_eos1","Temp_C_eos1","CO2_Soil_ppm_eos1","CO2_Soil_STD_ppm_eos1",
                    "CO2_ATM_ppm_eos1","CO2_ATM_STD_ppm_eos1","Mode")


# Subset data so only records at 5 minute intervals are retained
sub.1 <- subset(eos1, format(DateTime,'%OS')=='00')
sub.2 <- subset(sub.1, format(DateTime,'%M')%in% c("00","05","10","15","20","25","30","35","40","45","50","55","60"))


eos1plot <- ggplot(sub.2)+
  geom_line(aes(x= DateTime, y= Flux_eos1)) 
eos1plot



# Export the data
write.csv(eos1,here("outputs",paste0("eosFD1_4A_",date,".csv")))

