library(dplyr)
library(ggplot2)
library(lubridate)
library(here)

df <- read.csv(here::here("data_4_analysis/Vaisala_Stations_AllData_Dirty.csv"))%>%
  mutate(DateTime = ymd_hms(DateTime))


atmospheric <- df%>%
  filter(PPM<350)%>%
  filter(PPM>200)%>%
  filter(VID == "V2")

plot <- ggplot(atmospheric)+
  geom_line(aes(x=DateTime,  y=PPM))

library(plotly)
ggplotly(plot)
