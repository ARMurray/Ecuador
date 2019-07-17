#install.packages("tmaptools")
#install.packages("here")
library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)


#Howdy parnters. Let's use this space to put some GPs points together and make them look #coolll


#First we're going to bring in all the .shp files we want to combine 

Raw <- read_shape()