library(here)
library(tidyverse)
library(ggplot2)
library(plotly)
library(scales)
library(tidyr)
library(plotly)

df <- read.csv(here::here("data_4_analysis/All_Stream_Data.csv"))%>%
  select(DateTime,Inj,V1,V2,V3,V4,DO1_mg.L,DO2_mg.L,DO4_mg.L,Flux_1,Flux_2,tempC_436,airTemp_c,ppt24Tot,ppt48Tot,ppt72Tot,stn1_Q,stn2_Q,stn3_Q,stn4_Q)%>%
  filter(Inj == "Yes")%>%
  na.omit()
df$DateTime <- as.POSIXct(df$DateTime)


filter <- df%>%
  filter(DateTime > as.POSIXct("2019-07-22 15:00") & DateTime < as.POSIXct("2019-07-22 20:00"))%>%
  select(DateTime,V1,V2,V3,V4)%>%
  gather(Station,ppm,-DateTime)%>%
  mutate(Distance = ifelse(Station == "V1", 6,
                           ifelse(Station == "V2", 26,
                                  ifelse(Station =="V3", 56,
                                         ifelse(Station == "V4", 140,NA)))))


## FONT SETTINGS
# Axis font
xaxisFont <- list(
  family = "Arial, sans-serif",
  size = 16,
  color = "black"
)

yaxisFont <- list(
  family = "Arial, sans-serif",
  size = 12,
  color = "black"
)

labelFont <- list(
  family = "Arial, sans-serif",
  size = 18,
  color = "black"
)

legendtitle <- list(yref='paper',xref="paper",y=.95,x=.85, text="<b>Station</b>",showarrow=F)


plot <- filter%>%
  group_by(DateTime)%>%
  plot_ly( x =~Distance, y=~log(ppm), hoverinfo = "text",
           text = ~paste("Station: ", Station,
                         "<br> Date: ", DateTime))%>%
  add_lines(line = list(color = 'rgb(0, 0, 0)'), showlegend=FALSE)%>%
  add_markers(color = ~Station)%>%
  layout(
    title = "<b>Change in CO<sub>2</sub>[ppm]</b>",
    xaxis = list(title = "Distance [m]", type = "",titlefont = labelFont,
                showticklabels = TRUE,
                 tickangle = 0,
                 tickfont = xaxisFont,
                 exponentformat = "E"),
    yaxis = list(title = "logCO<sub>2</sub>[ppm]", type = "",titlefont = labelFont,
                 showticklabels = TRUE,
                 tickangle = 0,
                 tickfont = yaxisFont),
    annotations = list(legendtitle),
    legend = list(x=.75, y=.9)
  )
plot
