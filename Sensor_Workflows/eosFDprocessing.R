library(here)
library(ggplot2)
library(dplyr)

# *** SET THE DATE ***
date<- "06182019"


# eos1 data
eos1 <- read.csv(here("FieldData/EosFD",paste0("eos1_",date,".csv")))
eos1$Year <- paste0("20",eos1$Year)
eos1$dateTime <- as.POSIXct(as.character(paste0(eos1$Month,"/",eos1$Day,"/",eos1$Year," ",eos1$Time)), format = "%m/%d/%Y %H:%M:%OS")
eos1 <- eos1%>%
  select(dateTime,Flux,Temperature..C.,CO2.Soil..ppm.,
         CO2.Soil.STD..ppm.,CO2.ATM..ppm.,CO2.ATM.STD..ppm.,Mode)
colnames(eos1) <- c("DateTime","Flux_eos1","Temp_C_eos1","CO2_Soil_ppm_eos1","CO2_Soil_STD_ppm_eos1",
                    "CO2_ATM_ppm_eos1","CO2_ATM_STD_ppm_eos1","Mode")

<<<<<<< HEAD
# Subset data so only records at 5 minute intervals are retained
sub.1 <- subset(eos1, format(DateTime,'%OS')=='00')
sub.2 <- subset(sub.1, format(DateTime,'%M')in c("00","05","10","15","20","25","30",
                                                 "35","40","45","50","55","60"))

=======
sub.1 <- subset(eos1, format(DateTime,'%OS')=='00')
sub.2 <- subset(sub.1, format(DateTime, '%M') %in% c("00","05","10","15","20","25","30","35","40","45","50","55","60"))
>>>>>>> 45b69106fbb7ee0b5194477beb453111f40eae53

# eos2 data 
eos2 <- read.csv(here("FieldData/EosFD", paste0("eos2_",date,".csv")))
eos2$Year <- paste0("20",eos2$Year)
eos2$dateTime <- as.POSIXct(as.character(paste0(eos2$Month,"/",eos2$Day,"/",eos2$Year," ",eos2$Time)), format = "%m/%d/%Y %H:%M:%OS")
eos2 <- eos2%>%
  select(dateTime,Flux,Temperature..C.,CO2.Soil..ppm..,
         CO2.Soil.STD..ppm.,CO2.ATM..ppm.,CO2.ATM.STD..ppm.,Mode)
colnames(eos2) <- c("DateTime","Flux_eos2","Temp_C_eos2","CO2_Soil_ppm_eos2","CO2_Soil_STD_ppm_eos2",
                    "CO2_ATM_ppm_eos2","CO2_ATM_STD_ppm_eos2","Mode")

sub.11 <- subset(eos2, format(DateTime, '%OS') == '00')
sub.22 <- subset(sub.11, format(DateTime, '%M') %in% c("00","05","10","15","20","25","30","35","40","45","50","55","60"))

# Find the first and last time stamps that both eosFD sensors have data

# eos1<- sub.11[35:42,]

# eos2 <- sub.22[30:37,]

# Merge the data into a single data frame
bothEos <- merge(sub.2, sub.22,by="DateTime")

# Export the data
write.csv(bothEos,here("outputs",paste0("eosFD_4A_",date,".csv")))