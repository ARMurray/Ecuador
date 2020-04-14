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

# DO Sensor 1
df1 <- dat%>%
  select(solar.time,DO1_mg.L,DO.sat,lvl_421_m,tempC_421,light,stn3_Q)
colnames(df1) <- c("solar.time","DO.obs","DO.sat","depth","temp.water","light","discharge")

df1 <- df1[complete.cases(df1),]
df1 <- df1%>%
  distinct()%>%
  arrange(solar.time)

# Fix timestamps and interpolate missing data (Station 1)
## Round timestamps to closest 15-minute
df1a <- df1%>%
  mutate("solar.time" = round_date(solar.time, '15 minutes'))

## Create full dataframe of timesteps
timestep <- df1$solar.time[2]-df1$solar.time[1]
fulltime1 <- data.frame(solar.time=seq.POSIXt(df1$solar.time[1], df1$solar.time[length(df1$solar.time)], by=timestep))%>%
  mutate(solar.time=round_date(solar.time,'15 minutes'))%>%
  left_join(df1a)%>%
  na_interpolation(option = 'linear', maxgap = Inf)


# ***************** Baysean model parameters ********************** #

# Set the output folder
dir.create(here::here("Analysis/Stream_Metabolism/ModelOutputs/stn1_model_04142020_01"))       ### MAKE    TO      THESE!!!!
folder <- here::here("Analysis/Stream_Metabolism/ModelOutputs/stn1_model_04142020_01")         ###     SURE  CHANGE     !!!!


outdf <- data.frame()   # Create empty data frame to write model parameters to

for(n in 1:20){
  rk600 <- round(runif(1,0.5,31),2)  # Set random K600 between 0.5 and 31
  
  rBurnIn <- round(runif(1,100,400),0)  # Set random burn in steps
  
  rSteps <- round(runif(1,200,600),0)  # set random saved steps


  bayes_name <- mm_name(type='bayes', pool_K600='binned', err_obs_iid=TRUE, err_proc_iid=TRUE)
  bayes_specs <- specs(bayes_name)

  bayes_specs <- revise(bayes_specs, burnin_steps=rBurnIn, saved_steps=rSteps, n_cores=12, GPP_daily_mu=3, GPP_daily_sigma=2, init.K600.daily = rk600 )

  t1 <- Sys.time() # Record start time
  mm1 <- metab(bayes_specs, data=fulltime1) # Fit the model
  t2 <- Sys.time() # Record end time

  params <- data.frame("Parameter" = names(bayes_specs), "Value" = as.character(bayes_specs)) # Write some model specs to a csv

  times <- data.frame("Parameter"=c("Station 1 Time"),
                    "Value" = c(paste0(round(t2-t1,2)," ",units.difftime(t2-t1))))      # Add Completion Times
  
  outParams <- rbind(params,times)  # Combine output parameters
  outParams$run <- n   # Add a column to note which run this was in the loop

  outdf <- rbind(outdf,outParams)   # Add each iteration to an output data frame that will be written to a file after the loop completes

  capture.output(mm1,file=paste0(folder,"/DO_1_Output_",n,".txt")) # Write model outputs to text files
  
  pred1 <- predict_metab(mm1) # Predictions
  
  write.csv(pred1,paste0(folder,"/DO_1_Predictions_",n,".csv")) # Write Predictions to file
  
  ## K600 Plots
  mcmc <- get_mcmc(mm1)
  png(filename=paste0(folder,"/mcmc_stn1_",n,".png"))
  rstan::traceplot(mcmc, pars='K600_daily', nrow=6)
  dev.off()
  
  # ER & GPP Plots
  png(filename=paste0(folder,"/metabolism_stn1_",n,".png"))
  plot_metab_preds(mm1)
  dev.off()
}

write.csv(outdf,paste0(folder,"/specs.csv"))




