library(ggplot2)
library(tidyverse)
library(here)
library(plotly)

discharge <- read.csv(here("data_4_analysis/recorded_discharge.csv"))

level <- read.csv(here("FieldData/LevelLogger/WaterLevel_All.csv"))
level$DateTime <- as.POSIXct(as.character(level$DateTime),format = "%Y-%m-%d %H:%M")



# Reformat the dates
discharge$DateTime <- as.POSIXct(paste0(discharge$Date," ",discharge$Time),format = "%m/%d/%Y %H:%M")


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

level$Serial <- as.factor(level$Serial)
# Plot stream level
lvlPlot <- ggplot(level)+
  geom_point(aes(x = DateTime, y = LEVEL_m, group = Serial, col = Serial))

ggplotly(lvlPlot)


# Estimate water level at station 1 on July 24 at 1:00 PM
stn1_2 <- level%>%
  filter(Serial == "2020436" | Serial == "2020421")%>%
  select(DateTime, LEVEL_m, Serial)
stn1_2_wide <- spread(stn1_2, Serial, LEVEL_m)
stn1_2_wide <- na.omit(stn1_2_wide)

colnames(stn1_2_wide) <- c("DateTime","Station_3","Station_1")

stn1_2_wide$dif <- stn1_2_wide$Station_3 - stn1_2_wide$Station_1
