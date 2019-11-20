# Merge all data into a single dataframe
library(here)
library(tidyr)
library(dplyr)
library(zoo)


# Vaisala Data
Vaisala <- read.csv(here("data_4_analysis/Vaisala_Stations_AllData.csv"))
Vaisala$DateTime <- as.POSIXct(Vaisala$DateTime)
Vaisala <- Vaisala%>%
  mutate(ID = paste0(Vaisala$DateTime,Vaisala$VID))

# Remove Duplicates
Vaisala <- Vaisala[!duplicated(Vaisala[,'ID']),]%>%
  select(-X, -ID)%>%
  spread(VID,PPM)

# Need to get rid of the seconds in Vaisala times because they are staggering data
V1 <- Vaisala%>%
  select(DateTime,V1)%>%
  filter(!is.na(V1))
V1$DateTime <- as.character(V1$DateTime)
V1$DateTime <- as.POSIXct(substr(V1$DateTime,1,16))
#V1 <- V1[complete.cases(V1),]

V2 <- Vaisala%>%
  select(DateTime,V2)%>%
  filter(!is.na(V2))
V2$DateTime <- as.character(V2$DateTime)
V2$DateTime <- as.POSIXct(substr(V2$DateTime,1,16))

#Need to remove erroneous data from use of campbel logger with incorrect settings
V2 <- V2%>%
  filter(DateTime < as.POSIXct("2019-08-01 16:31:00")|DateTime>as.POSIXct("2019-08-03 10:15:00"))%>%
  filter(DateTime < as.POSIXct("2019-08-08 11:37:00")|DateTime>as.POSIXct("2019-08-09 10:03:00"))%>%
  filter(DateTime < as.POSIXct("2019-07-22 21:50:00")|DateTime>as.POSIXct("2019-07-26 16:00:00"))

#V2 <- V2[complete.cases(V2),]

V3 <- Vaisala%>%
  select(DateTime,V3)%>%
  filter(!is.na(V3))
V3$DateTime <- as.character(V3$DateTime)
V3$DateTime <- as.POSIXct(substr(V3$DateTime,1,16))
#V3 <- V3[complete.cases(V3),]

V4 <- Vaisala%>%
  select(DateTime,V4)%>%
  filter(!is.na(V4))
V4$DateTime <- as.character(V4$DateTime)
V4$DateTime <- as.POSIXct(substr(V4$DateTime,1,16))
#V4 <- V4[complete.cases(V4),]

vMerge <- merge(V1,V2, all = TRUE)
vMerge <- merge(vMerge,V3, all=TRUE)
vMerge <- merge(vMerge,V4, all=TRUE)

vMerge <- vMerge%>%
  filter(!is.na(V1)|!is.na(V3)|!is.na(V4))%>%
  distinct()

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
colnames(watTemp) <- c("DateTime","tempC_421","tempC_425","tempC_430",
                       "tempC_435","tempC_436","tempC_437","tempC_442")
watTemp$DateTime <- as.POSIXct(as.character(watTemp$DateTime))

# EC
EC <- read.csv(here("data_4_analysis/all_EC.csv"))%>%
  select(DateTime, uS, Station)%>%
  spread(Station, uS)
colnames(EC) <- c("DateTime","EC1_uS","EC2_uS","EC4_uS")
EC$DateTime <- as.POSIXct(EC$DateTime)

# DO
DO <- read.csv(here("data_4_analysis/all_DO.csv"))%>%
  select(DateTime,DO_mg_L,Station)%>%
  spread(Station, DO_mg_L)
colnames(DO) <- c("DateTime","DO1_mg.L","DO2_mg.L","DO4_mg.L")
DO$DateTime <- as.POSIXct(DO$DateTime)

# Injection Times
inj <- read.csv(here("data_4_analysis/injectionTimes.csv"))%>%
  select(-X)%>%
  distinct()
inj$DateTime <- as.POSIXct(inj$DateTime, format = "%m/%d/%Y %H:%M")

# Merge
merge <- merge(inj,vMerge, all = TRUE)
merge <- merge(merge,C6, all = TRUE)
merge <- merge(merge, eosFD, all = TRUE)%>%
  distinct()
merge <- merge(merge,ppt, all = TRUE)
merge <- merge(merge,lvl, all = TRUE)
merge <- merge(merge,watTemp, all = TRUE)
merge <- merge(merge, air, all = TRUE)
merge <- merge(merge, EC, all = TRUE)
merge <- merge(merge,DO, all=TRUE)


## Create new precipitation variables
## Calculate ppt as a running total of the previous X hours
#We have precipitation data at five minute intervals for the entire period of data collection thanks to a weather station close to our study site. Data was obtained from the [FONAG hydrometeorolical monitoring netowrk](http://sedc.fonag.org.ec/reportes/consultas/) (Station M5024). I run an iterator to total precipitation for the previous rows. Data collection began on July 9, 2019.
#For now I'll create three variables: 24-hour / 48-hour / 72-hour rainfall. This code exists in [Merge_All_Data.R](github.com)


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

plot <- ggplot(df)+
  geom_point(aes(x=DateTime, y=lvl_436_m))
# We don't want to go too crazy with interpolating data we did not collect
# HOWEVER, there is some data we can do this for, such as water level since we collected it consistently
# and we are interpolating very short periods of time for the purpose of having values in every row
# to go along with the other variables such as pCO2

# linear estimation of water level
# 421
aprx <- na.approx(df$lvl_421_m)

NAs <- which(!is.na(df$lvl_421_m))       #Find the locations of NAs
recFirst <- NAs[1]
recLast <- NAs[length(NAs)]

df.new <- data.frame()   #Iterate to insert iterpolated numbers into data
for (n in 2:recFirst-1){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = NA)
  df.new <- rbind(df.new, new)
}

for (n in recFirst:recLast){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = aprx[n-recFirst+1])
  df.new <- rbind(df.new, new)
}

for (n in recLast:nrow(df)){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = NA)
  df.new <- rbind(df.new, new)
}

lvl_421 <- df.new
colnames(lvl_421) <- c("DateTime","lvl_421_m")



# 425
aprx <- na.approx(df$lvl_425_m)
NAs <- which(!is.na(df$lvl_425_m))       #Find the locations of NAs
recFirst <- NAs[1]
recLast <- NAs[length(NAs)]
df.new <- data.frame()   #Iterate to insert iterpolated numbers into data
for (n in 2:recFirst-1){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = NA)
  df.new <- rbind(df.new, new)
}
for (n in recFirst:recLast){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = aprx[n-recFirst+1])
  df.new <- rbind(df.new, new)
}
for (n in recLast:nrow(df)){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = NA)
  df.new <- rbind(df.new, new)
}
lvl_425 <- df.new
colnames(lvl_425) <- c("DateTime","lvl_425_m")

# 430
aprx <- na.approx(df$lvl_430_m)
NAs <- which(!is.na(df$lvl_430_m))       #Find the locations of NAs
recFirst <- NAs[1]
recLast <- NAs[length(NAs)]
df.new <- data.frame()   #Iterate to insert iterpolated numbers into data
for (n in 2:recFirst-1){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = NA)
  df.new <- rbind(df.new, new)
}
for (n in recFirst:recLast){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = aprx[n-recFirst+1])
  df.new <- rbind(df.new, new)
}
for (n in recLast:nrow(df)){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = NA)
  df.new <- rbind(df.new, new)
}

lvl_430 <- df.new
colnames(lvl_430) <- c("DateTime","lvl_430_m")

# 435
aprx <- na.approx(df$lvl_435_m)
NAs <- which(!is.na(df$lvl_435_m))       #Find the locations of NAs
recFirst <- NAs[1]
recLast <- NAs[length(NAs)]
df.new <- data.frame()   #Iterate to insert iterpolated numbers into data
for (n in 2:recFirst-1){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = NA)
  df.new <- rbind(df.new, new)
}
for (n in recFirst:recLast){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = aprx[n-recFirst+1])
  df.new <- rbind(df.new, new)
}
for (n in recLast:nrow(df)){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = NA)
  df.new <- rbind(df.new, new)
}
lvl_435 <- df.new
colnames(lvl_435) <- c("DateTime","lvl_435_m")

# 436
aprx <- na.approx(df$lvl_436_m)
NAs <- which(!is.na(df$lvl_436_m))       #Find the locations of NAs
recFirst <- NAs[1]
recLast <- NAs[length(NAs)]
df.new <- data.frame()   #Iterate to insert iterpolated numbers into data
for (n in 2:recFirst-1){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = NA)
  df.new <- rbind(df.new, new)
}
for (n in recFirst:recLast){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = aprx[n-recFirst+1])
  df.new <- rbind(df.new, new)
}
for (n in recLast:nrow(df)){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = NA)
  df.new <- rbind(df.new, new)
}
lvl_436 <- df.new
colnames(lvl_436) <- c("DateTime","lvl_436_m")

# 437
aprx <- na.approx(df$lvl_437_m)
NAs <- which(!is.na(df$lvl_437_m))       #Find the locations of NAs
recFirst <- NAs[1]
recLast <- NAs[length(NAs)]
df.new <- data.frame()   #Iterate to insert iterpolated numbers into data
for (n in 2:recFirst-1){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = NA)
  df.new <- rbind(df.new, new)
}
for (n in recFirst:recLast){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = aprx[n-recFirst+1])
  df.new <- rbind(df.new, new)
}
for (n in recLast:nrow(df)){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = NA)
  df.new <- rbind(df.new, new)
}
lvl_437 <- df.new
colnames(lvl_437) <- c("DateTime","lvl_437_m")

# 442
aprx <- na.approx(df$lvl_442_m)
NAs <- which(!is.na(df$lvl_442_m))       #Find the locations of NAs
recFirst <- NAs[1]
recLast <- NAs[length(NAs)]
df.new <- data.frame()   #Iterate to insert iterpolated numbers into data
for (n in 2:recFirst-1){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = NA)
  df.new <- rbind(df.new, new)
}
for (n in recFirst:recLast){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = aprx[n-recFirst+1])
  df.new <- rbind(df.new, new)
}
for (n in recLast:nrow(df)){
  row <- df[n,]
  new <- data.frame(DateTime = row$DateTime, lvl = NA)
  df.new <- rbind(df.new, new)
}
lvl_442 <- df.new
colnames(lvl_442) <- c("DateTime","lvl_442_m")

# Merge the new level data together
dt <- lvl_421$DateTime
lvl_421 <- lvl_421%>%
  select(lvl_421_m)
lvl_425 <- lvl_425%>%
  select(lvl_425_m)
lvl_430 <- lvl_430%>%
  select(lvl_430_m)
lvl_435 <- lvl_435%>%
  select(lvl_435_m)
lvl_436 <- lvl_436%>%
  select(lvl_436_m)
lvl_437 <- lvl_437%>%
  select(lvl_437_m)
lvl_442 <- lvl_442%>%
  select(lvl_442_m)

lvlBind <- cbind(dt,lvl_421,lvl_425,lvl_430,lvl_435,lvl_436,lvl_437,lvl_442)


# Merge the level data into the main data frame
lvlBind <- lvlBind[1:nrow(lvlBind)-1,]%>%
  select(-dt)
dfFinal <- df%>%
  select(-lvl_421_m,-lvl_425_m,-lvl_430_m,-lvl_435_m,-lvl_436_m,-lvl_437_m,-lvl_442_m)%>%
  cbind(lvlBind)%>%
  distinct()

write.csv(dfFinal, here("data_4_analysis/All_Stream_Data.csv"))
