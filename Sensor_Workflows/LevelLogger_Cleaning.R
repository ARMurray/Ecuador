library(ggplot2)
library(tidyverse)
library(here)

level <- read.csv(here("FieldData/LevelLogger/WaterLevel_All.csv"))
level$DateTime <- as.POSIXct(as.character(level$DateTime),format = "%Y-%m-%d %H:%M")

# Clean errors from Level data
level <- level%>%
  filter(LEVEL_m > .08) # These are the times loggers were out of the water

# Level logger 1 read deep water erroneously on July 23-25
# We determined it ended up in a backpack and went back down to
# Quito which explains the increase in logged pressure
Lvl_1 <- level%>%
  filter(Serial == "2020436")

# Create data frame of stn 1 before bad data
Lvl1_pre23 <- Lvl_1%>%
  filter(DateTime < as.POSIXct("2019-07-23 13:45"))

# Create data frame for stn 1 after bad data
Lvl1_post25 <- Lvl_1%>%
  filter(DateTime > as.POSIXct("2019-07-25 15:30"))

# put the two new data frames together
Lvl1_fix <- rbind(Lvl1_pre23,Lvl1_post25)

# Replace the old with the new
level <- level%>%
  filter(!Serial == "2020436")

level <- rbind(level, Lvl1_fix)

# Remove the first point from 35 (Wasn't in the water yet)
level <- level%>%
  filter(!DateTime == as.POSIXct("2019-07-17 15:30:00"))

# Adjust 2020435 due to sensor disturbance (The pipe was shifted when data was collected)
# The shifts were cross referenced with collection dates to verify this.
lvl35 <- level%>%
  filter(Serial == "2020435")
lvl35_blk1 <- lvl35%>%
  filter(DateTime < as.POSIXct("2019-07-19 15:45:00"))
lvl35_blk2 <- lvl35%>%
  filter(DateTime > as.POSIXct("2019-07-19 15:30:00")&DateTime < as.POSIXct("2019-07-24 14:15:00"))
lvl35_blk2$LEVEL_m <- lvl35_blk2$LEVEL_m - .0463

lvl35_blk3 <- lvl35%>%
  filter(DateTime > as.POSIXct("2019-07-24 14:15:00")&DateTime < as.POSIXct("2019-08-02 13:00:00"))
lvl35_blk3$LEVEL_m <- lvl35_blk3$LEVEL_m + .0206

lvl35_blk4 <- lvl35%>%
  filter(DateTime > as.POSIXct("2019-08-02 13:00:00"))
lvl35_blk4$LEVEL_m <- lvl35_blk4$LEVEL_m - .0146

lvl35_adj <- rbind(lvl35_blk1,lvl35_blk2,lvl35_blk3,lvl35_blk4)

# Replace level logger 2020435 data in level data frame
level <- level%>%
  filter(!Serial == "2020435")

level <- rbind(level, lvl35_adj)


level$Serial <- as.factor(level$Serial)



# Here we estimate missing station 1 data using station 3 data
# First we filter data so we just have station 1 and 2
stn1_2 <- level%>%
  filter(Serial == "2020436" | Serial == "2020421")%>%
  select(DateTime, LEVEL_m, Serial)
stn1_2_wide <- spread(stn1_2, Serial, LEVEL_m)
colnames(stn1_2_wide) <- c("DateTime","Station_3","Station_1")

stn1_2_complete <- na.omit(stn1_2_wide) # Keep only rows with both data points


lm <- lm(stn1_2_complete$Station_1~stn1_2_complete$Station_3)
summary(lm)


lvl4est <- stn1_2_wide%>%
  filter(is.na(Station_1) & !is.na(Station_3))
lvl4est$Station_1 <- lvl4est$Station_3 - (lvl4est$Station_3 * 0.047655)

levelMod <- stn1_2_wide%>%
  filter(!is.na(Station_1))
levelMod <- rbind(levelMod,lvl4est)

# gather then add serial
lvlModLong <- levelMod%>%
  gather(Station,LEVEL_m,-DateTime)%>%
  mutate(Serial = ifelse(Station == "Station_1", "2020436",
                                ifelse(Station =="Station_3","2020421", NA)))%>%
  arrange(Serial,DateTime)%>%
  select(DateTime,LEVEL_m,Serial)

# Put temp back in
stn1_2_Temp <- level%>%
  filter(Serial == "2020436" | Serial == "2020421")%>%
  mutate(Join = paste0(DateTime,Serial))%>%
  select(Join,TEMP_c)


tjoin <- lvlModLong%>%
  mutate(Join = paste0(DateTime,Serial))


lvlwT <- merge(tjoin,stn1_2_Temp,all.x=TRUE)%>%
  select(DateTime,LEVEL_m,TEMP_c,Serial)%>%
  arrange(Serial,DateTime)

levelClean <- level%>%
  filter(!Serial == "2020421" & !Serial =="2020436")%>%
  select(DateTime,LEVEL_m,TEMP_c,Serial)%>%
  rbind(lvlwT)%>%
  distinct()%>%
  arrange(Serial, DateTime)


write.csv(levelClean, here("data_4_analysis/WaterLevel_Cleaned.csv"))

plot <- ggplot(lvlwT)+
  geom_point(aes(x=DateTime, y = LEVEL_m, group=Serial, col=Serial))
plot

