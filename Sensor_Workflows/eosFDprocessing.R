library(here)
library(ggplot2)
library(dplyr)

# *** SET THE DATE ***
date<- "07152019"


# eos1 data
eos1 <- read.csv(here("FieldData/EosFD",paste0("eos1_",date,".csv")),
                 col.names = c("Month","Day","Year","Time","Flux_1","Temp_C_1",
                               "CO2_Soil_1","CO2_Soil_STD_1","CO2_ATM_1","CO2_ATM_STD_1",
                               "Mode_1","X1","X2","X3","X4"),header = FALSE, skip = 1)
eos1$Year <- paste0("20",eos1$Year)
eos1$DateTime <- as.POSIXct(as.character(paste0(eos1$Month,"/",eos1$Day,"/",eos1$Year," ",eos1$Time)), format = "%m/%d/%Y %H:%M:%OS")
eos1 <- eos1%>%
  select(DateTime,Flux_1,Temp_C_1,CO2_Soil_1,
         CO2_Soil_STD_1,CO2_ATM_1,CO2_ATM_STD_1,Mode_1)

# Subset data so only records at 5 minute intervals are retained
sub.1 <- subset(eos1, format(DateTime,'%OS')=='00')
sub.2 <- subset(sub.1, format(DateTime,'%M')%in% c("00","05","10","15","20","25","30","35","40","45","50","55","60"))


sub.1 <- subset(eos1, format(DateTime,'%OS')=='00')
sub.2 <- subset(sub.1, format(DateTime, '%M') %in% c("00","05","10","15","20","25","30","35","40","45","50","55","60"))


# eos2 data 
eos2 <- read.csv(here("FieldData/EosFD",paste0("eos2_",date,".csv")),
                 col.names = c("Month","Day","Year","Time","Flux_2","Temp_C_2",
                               "CO2_Soil_2","CO2_Soil_STD_2","CO2_ATM_2","CO2_ATM_STD_2",
                               "Mode_2","X1","X2","X3","X4"),header = FALSE, skip = 1)
eos2$Year <- paste0("20",eos2$Year)
eos2$DateTime <- as.POSIXct(as.character(paste0(eos2$Month,"/",eos2$Day,"/",eos2$Year," ",eos2$Time)), format = "%m/%d/%Y %H:%M:%OS")
eos2 <- eos2%>%
  select(DateTime,Flux_2,Temp_C_2,CO2_Soil_2,
         CO2_Soil_STD_2,CO2_ATM_2,CO2_ATM_STD_2,Mode_2)

sub.11 <- subset(eos2, format(DateTime, '%OS') == '00')
sub.22 <- subset(sub.11, format(DateTime, '%M') %in% c("00","05","10","15","20","25","30","35","40","45","50","55","60"))

# Find the first and last time stamps that both eosFD sensors have data


# Merge the data into a single data frame
bothEos <- merge(sub.2, sub.22,by="DateTime")

# Export the data
write.csv(bothEos,here("outputs",paste0("eosFD_4A_",date,".csv")))

