# Electrical Conductivity
library(here)
library(ggplot2)
install.packages('colorspace')
library(dplyr)
install.packages('assertthat')
library(plotly)
install.packages('lubridate')
library(lubridate)

date <- "08022019"

EC1 <- read.csv("C:/Users/aestacio/Downloads/EcuadorFieldData/Ecuador/FieldData/EC/EC_1_08022019.csv", skip = 1)
EC1 <- EC1[,2:4]

colnames(EC1) <- c("DateTime","EC","tempC")

EC1$DateTime <- as.POSIXct(as.character(EC1$DateTime), format = "%m/%d/%Y %H:%M:%S")

plot <- ggplot(EC1)+
  geom_line(aes(x = DateTime, y = EC))

plot

ggplotly(plot)
