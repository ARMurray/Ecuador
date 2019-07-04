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


dataMerge <- rbind(V1,V2,V3,V4)

dataMerge$VID <- as.factor(dataMerge$VID)


outPlot <- ggplot(dataMerge, aes(x = DateTime, y = Volts, group = VID))+
  geom_line(aes(col=VID))
outPlot
