library(here)
library(ggplot2)
library(dplyr)

# *** SET THE DATE ***
date<- "07152019"

# Loop through all of the eosFD #1 files
eos_1_Files <- list.files(path = here("FieldData/EosFD/"), pattern = "eos1")

# Create an empty data frame to append to
eos_1_Data <- data.frame()

### Combine eosFD 1 data
for(i in 1:length(eos_1_Files)){
  file <- eos_1_Files[i]
  data <- read.csv(here::here("FieldData/EosFD",file),
                   blank.lines.skip = TRUE, header = FALSE,skip=1,
                   col.names = c("Month","Day","Year","Time","Flux_1","Temp_C_1",
                                 "CO2_Soil_1","CO2_Soil_STD_1","CO2_ATM_1","CO2_ATM_STD_1",
                                 "Mode_1","X1","X2","X3","X4"))
  eos_1_Data <- rbind(eos_1_Data,data)
}

eos_1_Data$Year <- paste0("20",eos_1_Data$Year)
eos_1_Data$DateTime <- as.POSIXct(as.character(paste0(eos_1_Data$Month,"/",eos_1_Data$Day,"/",eos_1_Data$Year," ",eos_1_Data$Time)), format = "%m/%d/%Y %H:%M:%OS")
eos_1_Data <- eos_1_Data%>%
  select(DateTime,Flux_1,Temp_C_1,CO2_Soil_1,
         CO2_Soil_STD_1,CO2_ATM_1,CO2_ATM_STD_1,Mode_1)

# Subset data so only records at 5 minute intervals are retained
sub.1 <- subset(eos_1_Data, format(DateTime,'%OS')=='00')
sub.2 <- subset(sub.1, format(DateTime,'%M')%in% c("00","05","10","15","20","25","30","35","40","45","50","55","60"))

### Combine eosFD 2 data
eos_2_Files <- list.files(path = here("FieldData/EosFD/"), pattern = "eos2")

# Create an empty data frame to append to
eos_2_Data <- data.frame()


for(i in 1:length(eos_2_Files)){
  file <- eos_2_Files[i]
  data <- read.csv(here::here("FieldData/EosFD",file),
                   blank.lines.skip = TRUE, header = FALSE,skip=1,
                   col.names = c("Month","Day","Year","Time","Flux_2","Temp_C_2",
                                 "CO2_Soil_2","CO2_Soil_STD_2","CO2_ATM_2","CO2_ATM_STD_2",
                                 "Mode_2","X1","X2","X3","X4"))
  eos_2_Data <- rbind(eos_2_Data,data)
}

eos_2_Data$Year <- paste0("20",eos_2_Data$Year)
eos_2_Data$DateTime <- as.POSIXct(as.character(paste0(eos_2_Data$Month,"/",eos_2_Data$Day,"/",eos_2_Data$Year," ",eos_2_Data$Time)), format = "%m/%d/%Y %H:%M:%OS")
eos_2_Data <- eos_2_Data%>%
  select(DateTime,Flux_2,Temp_C_2,CO2_Soil_2,
         CO2_Soil_STD_2,CO2_ATM_2,CO2_ATM_STD_2,Mode_2)

# Subset data so only records at 5 minute intervals are retained
sub.11 <- subset(eos_2_Data, format(DateTime,'%OS')=='00')
sub.22 <- subset(sub.11, format(DateTime,'%M')%in% c("00","05","10","15","20","25","30","35","40","45","50","55","60"))

# Merge the data into a single data frame
bothEos <- merge(sub.2, sub.22,by="DateTime", all = TRUE)

# Export the data
write.csv(bothEos,here("data_4_analysis/eosFD_Stream.csv"))

