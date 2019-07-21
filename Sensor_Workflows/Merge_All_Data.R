# Merge all data into a single dataframe
library(here)
library(dplyr)

# Vaisala Data
Vaisala <- read.csv(here("data_4_analysis/Vaisala_Stations_AllData.csv"))
Vaisala$DateTime <- as.POSIXct(Vaisala$DateTime)
Vaisala <- Vaisala%>%
  select(-X)%>%
  spread(VID,PPM)

# C6 Data
C6 <- read.csv(here("data_4_analysis/C6.csv"))%>%
  select(DateTime,Turbidity_NTU,Chlorophylla_ug.L,Phycocyanin_ppb,CDOM_ppb)
C6$DateTime <- as.POSIXct(C6$DateTime)

# eosFD Data
eosFD <- read.csv(here("data_4_analysis/eosFD_Stream.csv"))%>%
  select(-X)
eosFD$DateTime <- as.POSIXct(eosFD$DateTime)

# Precipitation Data
ppt <- read.csv(here("data_4_analysis/ppt.csv"))
ppt$Date <- as.POSIXct(as.character(ppt$Date), format = "%m/%d/%Y")

# Merge
merge <- merge(Vaisala,C6, all = TRUE)
merge <- merge(merge, eosFD, all = TRUE)%>%
  distinct()


# STILL NEED DO EC AND LEVEL


# Write the data
write.csv(merge, here("data_4_analysis/All_Stream_Data.csv"))


