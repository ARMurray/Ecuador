library(here)
library(ggplot2)
library(tidyverse)

# This script is for the processing of data collected from the GM70 Handheld Vaisala 

# Enter the date you want to process in the format 'mmddyyyy'
date <- '07042019'

# Enter Coordinates for each sensor
GM70_Lat <- "Input latitude in decimal degrees"
GM70_Lon <- "Input Longitude in decimal degrees"



# Import the Vaisala data for the date specified above.
GM70 <- read.csv(here("FieldData/GM70HandheldVaisala",paste0("GM70_",date,".csv")))


# Convert time to POSIXct in a new column called "DateTime"
V1 <- V1[1:5000,]
V1$DateTime <- paste0(V1$Date," ",V1$Time)
V1$DateTime <- as.POSIXct(V1$DateTime, format = "%m/%d/%Y %H:%M:%S")
V1 <- V1%>%
  select(DateTime,Volts)

V2$DateTime <- paste0(V2$Date," ",V2$Time)
V2$DateTime <- as.POSIXct(V2$DateTime, format = "%m/%d/%Y %H:%M:%S")
V2 <- V2%>%
  select(DateTime,Volts)

V3$DateTime <- paste0(V3$Date," ",V3$Time)
V3$DateTime <- as.POSIXct(V3$DateTime, format = "%m/%d/%Y %H:%M:%S")
V3 <- V3%>%
  select(DateTime,Volts)

V4$DateTime <- paste0(V4$Date," ",V4$Time)
V4$DateTime <- as.POSIXct(V4$DateTime, format = "%m/%d/%Y %H:%M:%S")
V4 <- V4%>%
  select(DateTime,Volts)

# We noticed that the OMEGA loggers started at different times
# meaning the seconds are off and cannot be merged. In the future 
# we must program them  to start at the same time. For now we will just subset
# and cbind them

V1 <- V1[1667:4391,]%>%
  dplyr::mutate(VID="1")
V2 <- V2[1617:4341,]%>%
  dplyr::mutate(VID="2")
V3 <- V3[5:2729,]%>%
  dplyr::mutate(VID="3")
V4 <- V4[445:3169,]%>%
  dplyr::mutate(VID="4")

dataMerge <- rbind(V1,V2,V3,V4)

dataMerge$VID <- as.factor(dataMerge$VID)


outPlot <- ggplot(dataMerge, aes(x = DateTime, y = Volts, group = VID))+
  geom_line(aes(col=VID))
outPlot
