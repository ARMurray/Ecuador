install.packages("tmaptools")
library(tmaptools)
library(ggplot2)

july6points <- read_GPX("C:/Users/hmir/Desktop/7-6 and 7-5 gps data/Waypoints_06-JUL-19.gpx", layers = "waypoints")
write.csv(july6points, "C:/Users/hmir/Desktop/7-6 and 7-5 gps data/july6points.csv")
july6waypoint <- read.csv("C:/Users/hmir/Desktop/7-6 and 7-5 gps data/july6points.csv")