library(streamMetabolizer)
library(dplyr)
library(imputeTS)
library(lubridate)
library(tidyr)
library(here)


# Prep data for stream metabolizer
# Instructions: `http://usgs-r.github.io/streamMetabolizer/`

# Import non-injection data
dat <- read.csv(here::here("data_4_analysis/All_Stream_Data.csv"))%>%
  select(DateTime,Inj,DO1_mg.L,DO2_mg.L,DO4_mg.L,tempC_421,lvl_436_m,lvl_421_m,stn3_Q)%>%
  filter(Inj == "No")

dat$DateTime <- as.POSIXct(dat$DateTime,format = "%Y-%m-%d %H:%M:%S", tz = "Etc/GMT+5")

# Convert to solar time
dat$solar.time <- calc_solar_time(dat$DateTime, longitude=-78.2)

#Import barometric pressure
baro <- read.csv(here::here("FieldData/LevelLogger/Last_Collection/brllgr_2019-08-14.csv"),skip = 10)
colnames(baro) <- c("Date","Time","ms","kPa","Temp_C")
baro$millibars <- baro$kPa*10
baro$DateTime <- as.POSIXct(paste0(as.character(baro$Date)," ",as.character(baro$Time)),format = "%m/%d/%Y %H:%M",tz = "Etc/GMT+5")

baro <- baro%>%
  select(DateTime,millibars)

dat <- merge(dat,baro,by="DateTime")


# Calculate DO Saturation
dat$DO.sat <- calc_DO_sat(dat$tempC_421,dat$millibars)

# Calculate light
dat$light <- calc_light(dat$solar.time,-.3,-78.2)

# Set up data frame for model run at each station

# DO Sensor 2
df2 <- dat%>%
  select(solar.time,DO2_mg.L,DO.sat,lvl_421_m,tempC_421,light,stn3_Q)
colnames(df2) <- c("solar.time","DO.obs","DO.sat","depth","temp.water","light","discharge")

df2 <- df2[complete.cases(df2),]
df2 <- df2%>%
  distinct()%>%
  arrange(solar.time)

# Fix timestamps and interpolate missing data (Station 2)
## Round timestamps to closest 15-minute
df2a <- df2%>%
  mutate("solar.time" = round_date(solar.time, '15 minutes'))

## Create full dataframe of timesteps
timestep <- df2$solar.time[2]-df2$solar.time[1]
fulltime2 <- data.frame(solar.time=seq.POSIXt(df2$solar.time[1], df2$solar.time[length(df2$solar.time)], by=timestep))%>%
  mutate(solar.time=round_date(solar.time,'15 minutes'))%>%
  left_join(df2a)%>%
  na_interpolation(option = 'linear', maxgap = Inf)


# ***************** Baysean model parameters ********************** #

# Set the output folder
#dir.create(here::here("Analysis/Stream_Metabolism/ModelOutputs/stn2_outputs"))   
folder <- here::here("Analysis/Stream_Metabolism/ModelOutputs/stn2_outputs")    


outdf <- data.frame()   # Create empty data frame to write model parameters to

date <- 202005030000    # UPDATE THIS!!!!

for(n in 1:100){
  rk600 <- round(runif(1,0.5,400),2)  # Set random K600 between 0.5 and 31
  
  rBurnIn <- round(runif(1,100,400),0)  # Set random burn in steps
  
  rSteps <- round(runif(1,200,600),0)  # set random saved steps
  
  id <- date+n
  
  bayes_name <- mm_name(type='bayes', pool_K600='binned', err_obs_iid=TRUE, err_proc_iid=TRUE)
  bayes_specs <- specs(bayes_name)
  
  bayes_specs <- revise(bayes_specs, burnin_steps=rBurnIn, saved_steps=rSteps, n_cores=12, GPP_daily_mu=3, GPP_daily_sigma=2, init.K600.daily = rk600 )
  
  t1 <- Sys.time() # Record start time
  mm2 <- metab(bayes_specs, data=fulltime2) # Fit the model
  t2 <- Sys.time() # Record end time
  
  params <- data.frame("Parameter" = names(bayes_specs), "Value" = as.character(bayes_specs)) # Write some model specs to a csv
  
  times <- data.frame("Parameter"=c("Station 2 Time"),
                      "Value" = c(paste0(round(t2-t1,2)," ",units.difftime(t2-t1))))      # Add Completion Times
  
  outParams <- rbind(params,times)  # Combine output parameters
  outParams$run <- n   # Add a column to note which run this was in the loop
  
  write.csv(outParams,paste0(folder,"/DO_2_Specs_",id,".csv"))
  
  capture.output(mm2,file=paste0(folder,"/DO_2_Output_",id,".txt")) # Write model outputs to text files
  
  pred2 <- predict_metab(mm2) # Predictions
  
  write.csv(pred2,paste0(folder,"/DO_2_Predictions_",id,".csv")) # Write Predictions to file
  
  ## K600 Plots
#  mcmc <- get_mcmc(mm2)
#  png(filename=paste0(folder,"/mcmc_stn2_",n,".png"))
#  rstan::traceplot(mcmc, pars='K600_daily', nrow=6)
#  dev.off()
  
  # ER & GPP Plots
#  png(filename=paste0(folder,"/metabolism_stn2_",n,".png"))
#  plot_metab_preds(mm2)
#  dev.off()
}
