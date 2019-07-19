#install.packages("tmaptools")
#install.packages("here")
library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)


#Howdy parnters. Let's use this space to put some GPs points together and make them look #coolll


#First I need to make a new column in all of the files that have the proper attritbution 
#let's set that up 
#here's what it'll be:
#streamhike
#focuswatershed
#WestCatchment
#GeneralGeog
#EOStransects
#Levelandbarro
#Synoptics 

#Let's import it one by one 

date <- '070519'

GPS1 <- read_shape(here("FieldData/GPS", paste0("GPS_",date,".shp")))
GPS1$Category <- "GeneralGeog"
GPS1$Category[12] <- ""