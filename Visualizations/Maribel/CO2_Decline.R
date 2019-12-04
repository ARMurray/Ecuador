library(here)
library(tidyverse)
library(ggplot2)
library(plotly)
library(scales)
library(tidyr)
library(plotly)

df <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))%>%
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

legendtitle <- list(yref='paper',xref="paper",y=.65,x=1.1, text="<b>Station</b>",showarrow=F)


plot <- filter%>%
  group_by(DateTime)%>%
  plot_ly( x =~Distance, y=~log(ppm), hoverinfo = "text",
           text = ~paste("Station: ", Station,
                         "<br> Date: ", DateTime))%>%
  add_lines(line = list(color = 'rgb(0, 0, 0)'), showlegend=FALSE)%>%
  add_markers(color = ~Station)%>%
  layout(
    title = "Change in CO<sub>2</sub>[ppm]",
    xaxis = list(showticklabels = TRUE,
                 tickangle = 0,
                 tickfont = xaxisFont,
                 exponentformat = "E"),
    yaxis = list(title = "This is the Y axis!", type = "",titlefont = labelFont,
                 showticklabels = FALSE,
                 tickangle = 0,
                 tickfont = yaxisFont),
    annotations = list(legendtitle),
    legend = list(x=1, y=.5)
  )
plot
