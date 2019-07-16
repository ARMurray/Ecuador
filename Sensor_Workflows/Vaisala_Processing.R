library(here)
library(ggplot2)
library(tidyverse)

# This script is for the processing of data collected from the 4 vaisalas
# which are permanently installed inside of the 4 large weatherproof boxes

# Enter the date you want to process in the format 'mmddyyyy'
date <- '07152019'

# Import the Vaisala data for the date specified above.
V1 <- read.csv(here("FieldData/Vaisala",paste0("VB1_",date,".csv")))
V2 <- read.csv(here("FieldData/Vaisala",paste0("VB2_",date,".csv")))
V3 <- read.csv(here("FieldData/Vaisala",paste0("VB3_",date,".csv")))
V4 <- read.csv(here("FieldData/Vaisala",paste0("VB4_",date,".csv")))

# Convert time to POSIXct in a new column called "DateTime"
V1$DateTime <- paste0(V1$Date," ",V1$Time)
V1$DateTime <- as.POSIXct(V1$DateTime, format = "%m/%d/%Y %H:%M:%S")

# Format the data and adjust based on field calibration
V1 <- V1%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)-5,VID="1")%>%
  select(DateTime,PPM,VID)

V2$DateTime <- paste0(V2$Date," ",V2$Time)
V2$DateTime <- as.POSIXct(V2$DateTime, format = "%m/%d/%Y %H:%M:%S")
V2 <- V2%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)-30,VID="2")%>%
  select(DateTime,PPM,VID)

V3$DateTime <- paste0(V3$Date," ",V3$Time)
V3$DateTime <- as.POSIXct(V3$DateTime, format = "%m/%d/%Y %H:%M:%S")
V3 <- V3%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)+17.5,VID="3")%>%
  select(DateTime,PPM,VID)

V4$DateTime <- paste0(V4$Date," ",V4$Time)
V4$DateTime <- as.POSIXct(V4$DateTime, format = "%m/%d/%Y %H:%M:%S")
V4 <- V4%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)+17.5,VID="4")%>%
  select(DateTime,PPM,VID)

# Combine data and make the ID field a factor so it is groupable
dataMerge <- rbind(V1,V2,V3,V4)
dataMerge$VID <- as.factor(dataMerge$VID)

# Make a simple plot
outPlot <- ggplot(dataMerge, aes(x = DateTime, y = PPM, group = VID))+
  geom_line(aes(col=VID))
outPlot

