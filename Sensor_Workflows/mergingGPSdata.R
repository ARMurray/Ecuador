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

date <- '071019'

GPS1 <- read_shape(here("FieldData/GPS", paste0("GPS_",date,".shp")))




GPS1$name <- as.character(GPS1$name)
GPS1$name[13] <- "STR49"

GPS1$Category <- "WestCatchment"
GPS1$Category[3] <- "GeneralGeog"

write_shape(GPS1,here("FieldData/GPS", paste0("GPS_",date, ".shp")))

#now let's put everything in one file and separate them by category


### Get a list of all the files
gps_Files <- list.files(here::here("FieldData/GPS"),pattern = '.shp')

#create an empty data.frame
allgeogData <- st_read(here::here("FieldData/GPS",gps_Files[1]))


### Combine all geog data
for(i in 2:length(gps_Files)){
  file <- gps_Files[i]
  data <- st_read(here::here("FieldData/GPS",file))
  allgeogData <- rbind(allgeogData,data)
}

#ok let's try this another way. 

GPS1 <- read_shape(here("FieldData/GPS/GPS_071019.shp"))
GPS2 <- read_shape(here("FieldData/GPS/GPS_070919.shp"))
GPS3 <- read_shape(here("FieldData/GPS/GPS_070519.shp"))

allgeogdata <- rbind(GPS1, GPS2,GPS3)
