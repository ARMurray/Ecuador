library(here)
library(tidyverse)
library(ggplot2)
library(plotly)
library(scales)

df <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))%>%
  select(DateTime,Inj,V1,V2,V3,V4)
df$DateTime <- as.POSIXct(df$DateTime)


# Axis font
xaxisFont <- list(
  family = "Arial, sans-serif",
  size = 22,
  color = "black"
)

yaxisFont <- list(
  family = "Arial, sans-serif",
  size = 22,
  color = "black"
)

labelFont <- list(
  family = "Arial, sans-serif",
  size = 28,
  color = "black"
)



plot <- df%>%
  plot_ly(x = ~DateTime)%>%
  add_markers(y = ~V1, name = "Station 1")%>%
  add_markers(y = ~V2, name = "Station 2")%>%
  add_markers(y = ~V3, name = "Station 3")%>%
  add_markers(y=~V4, name = "Station 4")%>%
  layout(
    xaxis = list(
      type = "date",
      title = "Date", titlefont = labelFont,
      showticklabels = TRUE,
      tickangle = 325,
      tickfont = xaxisFont, tickformat = "%b %d"),
    title = "CO<sub>2</sub> Concentration [ppm]",
    yaxis = list(title = "CO<sub>2</sub> [ppm]",titlefont = labelFont,
                 showticklabels = TRUE,
                 tickangle = 0,
                 tickfont = yaxisFont),
    showlegend=T)
