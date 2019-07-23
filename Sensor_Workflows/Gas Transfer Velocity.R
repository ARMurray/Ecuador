library(tidyverse)
library(ggplot2)
library(pracma)
library(sf)
library(lwgeom)

#Uploading Shape Files for Slope
GPSPts<-st_read("C:/Users/nehemiah/Desktop/Ecuador/FieldData/GPS/GPS_071819.shp")

#Finding Distance Between points
Dist<-st_distance(GPSPts[35,],GPSPts[34,])
Dist                  

#Finding Elevation
Elev<-GPSPts$ele[35]-GPSPts$ele[34]
Elev

#Uploading 