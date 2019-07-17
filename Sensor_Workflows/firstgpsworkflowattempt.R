install.packages("tmaptools")
install.packages("here")
library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)

# This script is for the processing of data collected from the GPS Garmen e20x 

# Enter the date you want to process in the format 'mmddyyyy'
date <- '05-JUL-19'

# Import the GPS data for the date specified above.
GPS1 <- read_GPX(here("FieldData/GPS/GPS1", paste0("Waypoints_",date,".gpx")), layers = "waypoints")

#change time to posixct
GPS1$DateTime <- as.POSIXct(substr(as.character(GPS1$time),1,19), format = "%Y/%m/%d %H:%M:%OS")

#Delete excess columns 
GPS1 <- GPS1 %>%
  select(DateTime, name, ele, geometry)

#Delete excess points specific to this set of data

GPS1 <- GPS1[-c(3,5,13,16), ]

GPS1$name <- as.character(GPS1$name)
GPS1$name[12] <- "WPUD9"

write_shape(GPS1,here("FieldData/GPS/GPS_070519"))
