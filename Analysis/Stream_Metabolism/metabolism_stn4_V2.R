library(streamMetabolizer)
library(tidyverse)
library(imputeTS)
library(lubridate)
library(here)


# Prep data for stream metabolizer
# Instructions: `http://usgs-r.github.io/streamMetabolizer/`

# Import non-injection data
dat <- read.csv(here::here("data_4_analysis/All_Stream_Data.csv"))%>%
  select(DateTime,Inj.x,DO4_mg.L,tempC_421,lvl_421_m,stn3_Q)%>%
  filter(Inj.x == "No")%>%
  drop_na()

dat$DateTime <- as.POSIXct(dat$DateTime,format = "%Y-%m-%d %H:%M:%S", tz = "Etc/GMT+5")


# Add in DO and level data collected into January 2020
# and obtained from Esteban (cap expired at 3:15 PM 1/18/2020)
doExt <- read.csv(here("FieldData/Esteban/HOBO_CSVs/DO/20645540_January_2020.csv"), skip=1)%>%
  select(Date.Time..GMT.04.00,DO.conc..mg.L..LGR.S.N..20645540..SEN.S.N..20645540.)
colnames(doExt) <- c("DateTime","DO_mgL")
doExt$DateTime <- lubridate::mdy_hms(doExt$DateTime)
doExt$DO_mgL <-  ifelse(doExt$DO_mgL < 0 , 0 , doExt$DO_mgL)
#doExt <- doExt%>%
#  filter(DateTime > lubridate::ymd_hms("2019-08-19 00:00:00"))

# Bring in Water Level and estimate discharge for new data
lvl <- read.csv(here("FieldData/Esteban/WaterLevel_BaroCompensated_csv/stn3_compensated_lvl.csv"))%>%
  mutate(DateTime = lubridate::mdy_hms(paste0(Date," ",Time)))%>%
  select(DateTime,LEVEL_m,TEMPERATURE,discharge_m3perS)

# Merge new data together
doExtMerge <- doExt%>%
  left_join(lvl)

# Combine old and new data
dat2 <- dat%>%
  select(DateTime,DO4_mg.L,tempC_421,lvl_421_m,stn3_Q)
colnames(dat2) <- c("DateTime","DO_mgL","temp_C","level_m","discharge")

doExt2 <- doExtMerge%>%
  select(DateTime,DO_mgL,TEMPERATURE,LEVEL_m,discharge_m3perS)%>%
  mutate(LEVEL_m = LEVEL_m)

colnames(doExt2) <- c("DateTime","DO_mgL","temp_C","level_m","discharge")

lubridate::tz(doExt2) <- "Etc/GMT+5"

allDat <- rbind(dat2,doExt2)

# Convert to solar time
allDat$solar.time <- calc_solar_time(allDat$DateTime, longitude=-78.2)

#Import barometric pressure
baro <- read.csv(here::here("FieldData/LevelLogger/Last_Collection/brllgr_2019-08-14.csv"),skip = 10)
colnames(baro) <- c("Date","Time","ms","kPa","Temp_C")
baro$DateTime <- lubridate::mdy_hms(paste0(as.character(baro$Date)," ",as.character(baro$Time)))

# Import new baro through January and combine
baro2 <- read.csv(here::here("FieldData/Esteban/Datos Logger de Gavilan Cayambe Coca_January 2020/solinst/2107266-enero-2020.csv"),skip = 11)
colnames(baro2) <- c("Date","Time","ms","kPa","Temp_C")
baro2$DateTime <- lubridate::mdy_hms(paste0(as.character(baro2$Date)," ",as.character(baro2$Time)))

baroBind <- rbind(baro,baro2)

baroBind$millibars <- baroBind$kPa*10

baro <- baroBind%>%
  select(DateTime,millibars)

dat <- merge(allDat,baro,by="DateTime")


# Calculate DO Saturation
dat$DO.sat <- calc_DO_sat(dat$temp_C,dat$millibars)

# Calculate light
dat$light <- calc_light(dat$solar.time,-.3,-78.2)

# Set up data frame for model run at each station

# DO Sensor 3
df2 <- dat%>%
  select(solar.time,DO_mgL,DO.sat,level_m,temp_C,light, discharge)
colnames(df2) <- c("solar.time","DO.obs","DO.sat","depth","temp.water","light","discharge")


df2 <- df2[complete.cases(df2),]
df2 <- df2%>%
  distinct()%>%
  arrange(solar.time)

# Fix timestamps and interpolate missing data (Station 1)
## Round timestamps to closest 15-minute
df2a <- df2%>%
  mutate("solar.time" = round_date(solar.time, '15 minutes'))

## Create full dataframe of timesteps
timestep <- df2$solar.time[2]-df2$solar.time[1]
fulltime1 <- data.frame(solar.time=seq.POSIXt(df2$solar.time[1], df2$solar.time[length(df2$solar.time)], by=timestep))%>%
  mutate(solar.time=round_date(solar.time,'15 minutes'))%>%
  left_join(df2a)%>%
  na_interpolation(option = 'linear', maxgap = Inf)%>%
  filter(solar.time < lubridate::ymd_hms("2020-01-18 02:45:00"))  # remove data collected after sensor was pulled



# ***************** Baysean model parameters ********************** #

# Set the output folder
#dir.create(here::here("Analysis/Stream_Metabolism/ModelOutputs/stn1_outputs"))   
folder <- here::here("Analysis/Stream_Metabolism/ModelOutputs/stn4_outputs_JAN_k60")    

date <- 202101210001            # UPDATE THIS!!!!

for(n in 1:100){
  rk600 <- round(runif(1,0.5,60),2)  # Set random K600 between 0.5 and 400
  
  rBurnIn <- round(runif(1,100,400),0)  # Set random burn in steps 100-400
  
  rSteps <- round(runif(1,200,600),0)  # set random saved steps 200-600
  
  id <- date+n
  
  
  bayes_name <- mm_name(type='bayes', pool_K600='binned', err_obs_iid=TRUE, err_proc_iid=TRUE)
  bayes_specs <- specs(bayes_name)
  
  bayes_specs <- revise(bayes_specs, burnin_steps=rBurnIn, saved_steps=rSteps, n_cores=12, GPP_daily_mu=3, GPP_daily_sigma=2, init.K600.daily = rk600 )
  
  t1 <- Sys.time() # Record start time
  mm1 <- metab(bayes_specs, data=fulltime1) # Fit the model
  t2 <- Sys.time() # Record end time
  
  params <- data.frame("Parameter" = names(bayes_specs), "Value" = as.character(bayes_specs)) # Write some model specs to a csv
  
  times <- data.frame("Parameter"=c("Station 2 Time"),
                      "Value" = c(paste0(round(t2-t1,2)," ",units.difftime(t2-t1))))      # Add Completion Times
  
  outParams <- rbind(params,times)  # Combine output parameters
  outParams$run <- n   # Add a column to note which run this was in the loop
  
  write.csv(outParams,paste0(folder,"/DO_2_Specs_",id,".csv"))
  
  capture.output(mm1,file=paste0(folder,"/DO_2_Output_",id,".txt")) # Write model outputs to text files
  
  pred1 <- predict_metab(mm1) # Predictions
  
  write.csv(pred1,paste0(folder,"/DO_2_Predictions_",id,".csv")) # Write Predictions to file
  
  print(paste0("Completed Iteration #",n))
  write(paste0("Completed Iteration #",n," at: ", Sys.time()),file=paste0(folder,"_TimeStamps_",date,".txt"),append=TRUE)
  
  ## K600 Plots
  #  mcmc <- get_mcmc(mm1)
  #  png(filename=paste0(folder,"/mcmc_stn1_",n,".png"))
  #  rstan::traceplot(mcmc, pars='K600_daily', nrow=6)
  #  dev.off()
  
  # ER & GPP Plots
  #  png(filename=paste0(folder,"/metabolism_stn1_",n,".png"))
  #  plot_metab_preds(mm1)
  #  dev.off()
}
