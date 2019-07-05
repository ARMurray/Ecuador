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

#change co2..ppm column name to just ppm

GM70$ppm <- GM70$CO2..ppm

# Convert time to POSIXct in a new column called "DateTime"
GM70$DateTime <- paste0(GM70$X)
GM70$DateTime <- as.POSIXct(GM70$DateTime, format = "%m/%d/%Y %H:%M:%S")
GM70 <- GM70%>%
  select(DateTime, ppm)



outPlot <- ggplot(GM70, aes(x = DateTime, y = ppm))+ 
  geom_point()+
  geom_line()
outPlot
