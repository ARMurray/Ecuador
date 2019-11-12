## Discharge plots

library(plotly)
library(dplyr)
library(ggplot2)

df <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))%>%
  select(DateTime,Inj,V1,V2,V3,V4,Flux_1,Flux_2,tempC_436_m,airTemp_c,ppt24Tot,ppt48Tot,ppt72Tot,stn1_Q,stn2_Q,stn3_Q,stn4_Q)
df$DateTime <- as.POSIXct(df$DateTime, format = "%m/%d/%Y %H:%M")


stn1Q <- ggplot(df)+
  geom_line(aes(x=DateTime, y= stn1_Q))

ggplotly(stn1Q)
