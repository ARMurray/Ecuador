install.packages("tmaptools")
library(tmaptools)
library(ggplot2)


# This script is for the processing of data collected from the GPS Garmen e20x 

# Enter the date you want to process in the format 'mmddyyyy'
date <- '07062019'

# Import the Vaisala data for the date specified above.
waypoints6july <- read.csv(here("FieldData/GM70HandheldVaisala",paste0("GM70_",date,".csv")))


july6points <- read_GPX("C:/Users/hmir/Desktop/7-6 and 7-5 gps data/Waypoints_06-JUL-19.gpx", layers = "waypoints")
july6waypoint <- read.csv("C:/Users/hmir/Documents/Ecuador/FieldData/GPS/july6points.csv")