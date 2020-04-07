library(tidyverse)
library(here)
library(dplyr)
library(ggplot2)
library(plotly)

data <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))
data$DateTime <- as.POSIXct(data$DateTime)
inj3 <- data%>%
  filter(DateTime > as.POSIXct("2019-07-22 13:30:00"))%>%
  filter(DateTime < as.POSIXct("2019-07-22 21:00:00"))

mh <- ggplot(inj3, aes(x = DateTime))+
  geom_point(aes(y = V1, colour = "Vaisala 1"))+
  scale_color_manual(values=c("#1A5807", "#F3C519", "#1B48A9", "#63ABF9"))+
  geom_point(aes(y = V2, colour = "Vaisala 2"))+
  geom_point(aes(y = V3, colour = "Vaisala 3"))+
  geom_point(aes(y = V4, colour = "Vaisala 4"))+
  labs(title = "Injection #3 - July 22", x = "Time", y = expression(bold(pCO["2"]~"[ppm]"))) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=20),
        axis.title.y = element_text(size = 20))+
  theme(legend.position= "none") +
  theme(panel.border = element_rect(fill=NA, colour = "black", size=1.5))


mh
