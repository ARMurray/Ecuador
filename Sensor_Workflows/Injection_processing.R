library(ggplot2)
library(tidyverse)
library(dplyr)
library(here)

VB1<- read.csv(here::here("FieldData/Vaisala/VB1_08012019_1min.csv"))
VB2<- read.csv(here::here("FieldData/Vaisala/VB2_08152019_1min.csv"))
VB3<- read.csv(here::here("FieldData/Vaisala/VB3_08022019_1min.csv"))
VB4<- read.csv(here::here("FieldData/Vaisala/VB"))

# Convert time to POSIXct in a new column called "DateTime"
VB1$DateTime <- paste0(VB1$Date," ",VB1$Time)
VB1$DateTime <- as.POSIXct(VB1$DateTime, format = "%m/%d/%Y %H:%M:%S")

VB2$DateTime <- paste0(VB2$Date," ",VB1$Time)
VB2$DateTime <- as.POSIXct(VB2$DateTime, format = "%m/%d/%Y %H:%M:%S")


VB3$DateTime <- paste0(VB3$Date," ",VB3$Time)
VB3$DateTime <- as.POSIXct(VB3$DateTime, format = "%m/%d/%Y %H:%M:%S")

# Format the data, adjust based on field calibration and remove duplicate rows
VB1 <- VB1%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)-5,VID="V1")%>%
  select(DateTime,PPM,VID)%>%
  distinct()

VB2 <- VB2%>%
  dplyr::mutate(PPM=(CO2 * 10)-30,VID="V2")%>%
  select(DateTime,PPM,VID)%>%
  distinct()

VB3 <- VB3%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)+17.5,VID="V3")%>%
  select(DateTime,PPM,VID)%>%
  distinct()



# Combine data and make the ID field a factor so it is groupable
VMerge <- rbind(VB1,VB2,VB3)%>%
  filter(PPM > 100)%>%
  filter(PPM < 10000)


# Make a simple plot
outPlot <- ggplot(VMerge, aes(x = DateTime, y = PPM, group = VID))+
  scale_color_manual(values=c("#1A5807", "#F3C519", "#1B48A9"))+
  geom_point(aes(col=VID), size = .5)

outPlot
