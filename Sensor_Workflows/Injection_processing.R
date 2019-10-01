library(ggplot2)
library(tidyverse)
library(dplyr)
library(here)
library(plotly)

VB1<- read.csv(here::here("FieldData/Vaisala/VB1_07262019_1min.csv"))
VB2<- read.csv(here::here("FieldData/Vaisala/VB2_08132019_1min.csv"))
VB3<- read.csv(here::here("FieldData/Vaisala/VB3_07262019_1min.csv"))
VB4<- read.csv(here::here("FieldData/Vaisala/VB4_07262019_1min.csv"))

# Convert time to POSIXct in a new column called "DateTime"
VB1$DateTime <- paste0(VB1$Date," ",VB1$Time)
VB1$DateTime <- as.POSIXct(VB1$DateTime, format = "%m/%d/%Y %I:%M:%S %p")

colnames(VB2) <- c("DateTime","Voltage")
#VB2$DateTime <- paste0(VB2$Date," ",VB1$Time)
VB2$DateTime <- as.POSIXct(VB2$DateTime, format = "%m/%d/%Y %H:%M")

# Correct time offset
VB2$DateTime <- VB2$DateTime - 3600


VB3$DateTime <- paste0(VB3$Date," ",VB3$Time)
VB3$DateTime <- as.POSIXct(VB3$DateTime, format = "%m/%d/%Y %I:%M:%S %p")

VB4$DateTime <- paste0(VB4$Date," ",VB4$Time)
VB4$DateTime <- as.POSIXct(VB4$DateTime, format = "%m/%d/%Y %I:%M:%S %p")

# Format the data, adjust based on field calibration and remove duplicate rows
VB1 <- VB1%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)-5,VID="V1")%>%
  dplyr::select(DateTime,PPM,VID)%>%
  distinct()

VB2 <- VB2%>%
  dplyr::mutate(PPM=(Voltage * 10)-30,VID="V2")%>%
  select(DateTime,PPM,VID)%>%
  distinct()

VB3 <- VB3%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)+17.5,VID="V3")%>%
  select(DateTime,PPM,VID)%>%
  distinct()

VB4 <- VB4%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)+17.5,VID="V4")%>%
  select(DateTime,PPM,VID)%>%
  distinct()

# Combine data and make the ID field a factor so it is groupable
VMerge <- rbind(VB1,VB2,VB3,VB4)%>%
  filter(PPM > 100)%>%
  filter(PPM < 10000)

# Time Filter
filt <- VMerge%>%
  filter(DateTime > as.POSIXct("2019-07-26 11:45:00", format = "%Y-%m-%d %H:%M:%S"))%>%
  filter(DateTime < as.POSIXct("2019-07-26 15:45:00", format = "%Y-%m-%d %H:%M:%S"))

# Make a simple plot
outPlot <- ggplot(filt, aes(x = DateTime, y = PPM, group = VID))+
  scale_color_manual(values=c("#1A5807", "#F3C519", "#1B48A9","#32a852"))+
  geom_point(aes(col=VID), size = 1)

outPlot
