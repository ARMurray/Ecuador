install.packages("streamMetabolizer", dependencies=TRUE, 
                 repos=c("https://owi.usgs.gov/R","https://cran.rstudio.com"))
update.packages(oldPkgs=c("streamMetabolizer","unitted"), dependencies=TRUE,
                repos=c("https://owi.usgs.gov/R", "https://cran.rstudio.com"))
library(streamMetabolizer)
library(dplyr)
library(unitted)
library(here)
library(lubridate)

#read in file
dat <- read.csv("C:/Users/kriddie/Documents/kriddie_personal/Ecuador Proyecto IRU/Ecuador/Analysis/Stream_Metabolism/EC_IRU1_2020-01-21_XX.csv")
#prepare timestamp
dat$DateTime <- as.POSIXct(dat$DateTime, format="%m/%d/%Y %H:%M", tz='Etc/GMT+5')
lubridate::tz(dat$DateTime)
dat$DateTime <- streamMetabolizer::calc_solar_time(dat$DateTime, longitude=-78.200471) 

