# Electrical Conductivity
library(here)
library(ggplot2)
install.packages('colorspace')
library(dplyr)
library(plotly)
library(lubridate)

date <- "07122019"

EC1 <- read.csv(here("FieldData/EC",paste0("EC1_",date,".csv")),skip = 1)
EC1 <- EC1[,2:4]

colnames(EC1) <- c("DateTime","EC","tempF")

EC1$DateTime <- as.POSIXct(as.character(EC1$DateTime), format = "%m/%d/%Y %H:%M:%S")

plot <- ggplot(EC1)+
  geom_line(aes(x = DateTime, y = EC))

plot

ggplotly(plot)
