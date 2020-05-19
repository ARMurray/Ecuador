library(dplyr)
library(lubridate)
library(here)
library(tidyr)

df <- read.csv(here::here("data_4_analysis/All_Stream_Data.csv"))%>%
  select(DateTime,Inj,CDOM_ppb,Chlorophylla_ug.L)%>%
  filter(Inj == "No")
df$DateTime <- ymd_hms(df$DateTime)
df <- df[1:nrow(df)-1,]
df$hour <- substr(as.character(df$DateTime),12,13)

#cdom
plot(df$CDOM_ppb~df$hour)

# chl-A
plot(df$Chlorophylla_ug.L~df$hour)

do <- read.csv(here::here("data_4_analysis/All_Stream_Data.csv"))%>%
  select(DateTime,Inj,DO1_mg.L,DO2_mg.L,DO4_mg.L)%>%
  filter(Inj == "No")%>%
  pivot_longer(cols = c("DO1_mg.L","DO2_mg.L","DO4_mg.L"), names_to = "DO_mg.L")
do$DateTime <- ymd_hms(do$DateTime)
do <- do[1:nrow(do)-1,]
do$hour <- substr(as.character(do$DateTime),12,13)

plot(do$value~do$hour, col=do$DO_mg.L)
library(ggplot2)
ggplot(do)+
  geom_point(aes(x = hour, y = value, col = DO_mg.L))
