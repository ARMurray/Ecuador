install.packages("streamMetabolizer", dependencies=TRUE, 
                 repos=c("https://owi.usgs.gov/R","https://cran.rstudio.com"))
update.packages(oldPkgs=c("streamMetabolizer","unitted"), dependencies=TRUE,
                repos=c("https://owi.usgs.gov/R", "https://cran.rstudio.com"))
library(streamMetabolizer)
library(dplyr)
library(unitted)
library(here)
library(lubridate)
library(unitted)

#read in file
dat <- read.csv("C:/Users/kriddie/Documents/kriddie_personal/Ecuador Proyecto IRU/Ecuador/Analysis/Stream_Metabolism/EC_IRU1_2020-01-21_XX.csv")
#rename columns
names(dat)[names(dat) == "Discharge_m3s"] <- "discharge"
names(dat)[names(dat) == "DO_mgL"] <- "DO.obs"
#prepare timestamp
dat$DateTime <- as.POSIXct(dat$DateTime, format="%m/%d/%Y %H:%M", tz='Etc/GMT+5')
lubridate::tz(dat$DateTime)
dat$solar.time <- streamMetabolizer::calc_solar_time(dat$DateTime, longitude=-78.200471) 

##calculate depth
  #using regression from level logger and depth in middle of stream reach
dat$depth <- dat$Level_m*1.6396 - 0.1748 
  #using calc_depth() - example: calc_depth(Q, c = u(0.409, "m"), f = u(0.294, ""))
      #Q - discharge (m^3 s^-1)
      #c - coefficient representing depth at unit discharge (usually m)
      #f - exponent in depth-discharge relation (unitless)
    #how do I determine variables c and f? Can't use 
#dat$depth_calc <- calc_depth(Q=u(dat$Discharge_m3s, "m^3 s^-1"), c=u(1.4648,"m"),  f = u(0.294, ""))

#calc_DO_sat
dat$AirPres_mb <- dat$AirPres_kPa*10
dat$DO.sat <- calc_DO_sat(temp=u(dat$WaterTemp_c,"degC"), press=u(dat$AirPres_kPa,"mb"), sal=u(0,"PSU")) # units are checked

#calculate light
#max.PAR: 	numeric or unitted_numeric: the PAR (umol m^-2 s^-1) that each day should reach at peak light

#Modis Data - MCD18A2 provides a daily, 3-hour global product at 5 km resolution
#UNITS: Einstein m-2 d-1... supposedly? It's hard to find an answer for this. I will assume the SI units for PAR
#data does not provide time of collection, so I used the maximum value from daily collected values from July 2 to August 19 

dat$light <- calc_light(dat$DateTime, -0.328202, -78.2004711, max.PAR = u(426.994171,
                              "umol m^-2 s^-1")
                    #  , attach.units = is.unitted(DateTime)
                    )

#Convert photosynthetically active radiation (PAR) to shortwave radiation (SW). 
#Uses a fixed ratio between PAR and SW, ignoring the minor seasonal changes in this ratio (see Britton and Dodd (1976)). 
#dat$SW <- convert_PAR_to_SW(dat$PAR, coef = 0.473)

#Choose a model structure
bayes_name <- mm_name(type='bayes', pool_K600='none', err_obs_iid=TRUE, err_proc_iid=TRUE)
#We now pass the model name to specs() to get a list of default specifications for this model.
bayes_specs <- specs(bayes_name)
