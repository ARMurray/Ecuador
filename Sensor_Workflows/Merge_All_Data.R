# Merge all data into a single dataframe
library(here)
library(tidyr)
library(dplyr)


# Vaisala Data
Vaisala <- read.csv(here("data_4_analysis/Vaisala_Stations_AllData.csv"))
Vaisala$DateTime <- as.POSIXct(Vaisala$DateTime)
Vaisala <- Vaisala%>%
  mutate(ID = paste0(Vaisala$DateTime,Vaisala$VID))

# Remove Duplicates
Vaisala <- Vaisala[!duplicated(Vaisala[,'ID']),]%>%
  select(-X, -ID)%>%
  spread(VID,PPM)

# C6 Data
C6 <- read.csv(here("data_4_analysis/C6.csv"))%>%
  select(DateTime,Turbidity_NTU,Chlorophylla_ug.L,Phycocyanin_ppb,CDOM_ppb)
C6$DateTime <- as.POSIXct(C6$DateTime, format = "%m/%d/%Y %H:%M")

# eosFD Data
eosFD <- read.csv(here("data_4_analysis/eosFD_All.csv"))%>%
  select(-X)
eosFD$DateTime <- as.POSIXct(eosFD$DateTime)

# Precipitation Data
ppt <- read.csv(here("data_4_analysis/ppt_5min.csv"))
ppt$DateTime <- as.POSIXct(as.character(ppt$DateTime), format = "%m/%d/%Y %H:%M")


# Air Temperature Data
air <- read.csv(here("data_4_analysis/airTemp_5min.csv"))
air$DateTime <- as.POSIXct(as.character(air$DateTime), format = "%m/%d/%Y %H:%M")

# Level Data
lvl <- read.csv(here("data_4_analysis/WaterLevel_Cleaned.csv"))%>%
  select(DateTime, LEVEL_m,Serial)%>%
  spread(Serial,LEVEL_m)
colnames(lvl) <- c("DateTime","lvl_421_m","lvl_425_m","lvl_430_m","lvl_435_m",
                   "lvl_436_m","lvl_437_m","lvl_442_m")
lvl$DateTime <- as.POSIXct(as.character(lvl$DateTime))

# Water Temperature Data
watTemp <- read.csv(here("data_4_analysis/WaterLevel_Cleaned.csv"))%>%
  select(DateTime, TEMP_c,Serial)%>%
  spread(Serial,TEMP_c)
colnames(watTemp) <- c("DateTime","tempC_421_m","tempC_425_m","tempC_430_m",
                       "tempC_435_m","tempC_436_m","tempC_437_m","tempC_442_m")
watTemp$DateTime <- as.POSIXct(as.character(watTemp$DateTime))
# Merge
merge <- merge(Vaisala,C6, all = TRUE)
merge <- merge(merge, eosFD, all = TRUE)%>%
  distinct()
merge <- merge(merge,ppt, all = TRUE)
merge <- merge(merge,lvl, all = TRUE)
merge <- merge(merge,watTemp, all = TRUE)
merge <- merge(merge, air, all = TRUE)
# STILL NEED DO EC AND LEVEL

## Create new precipitation variables
ppt24Df <- data.frame()
for(n in 2449:nrow(merge)){
  date <- as.POSIXct(as.character(merge[n,'DateTime']))
  sub <- merge%>%
    filter(DateTime < date & DateTime > date - 86400) #86,400 is the number of seconds in a day
  pptTot <- sum(sub$ppt_mm, na.rm = TRUE)
  newData <- data.frame("DateTime" = date, "ppt24Tot" = pptTot)
  ppt24Df <- rbind(ppt24Df, newData)
}

ppt48Df <- data.frame()
for(n in 2449:nrow(merge)){
  date <- as.POSIXct(as.character(merge[n,'DateTime']))
  sub <- merge%>%
    filter(DateTime < date & DateTime > date - 172800) #86,400 is the number of seconds in a day
  pptTot <- sum(sub$ppt_mm, na.rm = TRUE)
  newData <- data.frame("DateTime" = date, "ppt48Tot" = pptTot)
  ppt48Df <- rbind(ppt48Df, newData)
}

ppt72Df <- data.frame()
for(n in 2449:nrow(merge)){
  date <- as.POSIXct(as.character(merge[n,'DateTime']))
  sub <- merge%>%
    filter(DateTime < date & DateTime > date - 259200) #86,400 is the number of seconds in a day
  pptTot <- sum(sub$ppt_mm, na.rm = TRUE)
  newData <- data.frame("DateTime" = date, "ppt72Tot" = pptTot)
  ppt72Df <- rbind(ppt72Df, newData)
}

df <- merge(merge,ppt24Df, all = TRUE)
df <- merge(df,ppt48Df, all = TRUE)
df <- merge(df,ppt72Df, all = TRUE)



# Write the data
write.csv(df, here("data_4_analysis/All_Stream_Data.csv"))


plot <- ggplot(merge)+
  geom_point(aes(x = DateTime, y = airTemp_c))
plot
