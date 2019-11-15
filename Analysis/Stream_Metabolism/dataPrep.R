library(streamMetabolizer)
library(dplyr)
library(here)


# Prep data for stream metabolizer

dat <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))%>%
  select(DateTime,Inj,DO1_mg.L,DO2_mg.L,DO4_mg.L,tempC_436,lvl_436_m,lvl_421_m )

dat$DateTime <- as.POSIXct(dat$DateTime, tz = "Etc/GMT+5")

# Convert to solar time
dat$solar.time <- calc_solar_time(dat$DateTime, longitude=-78.2)


#Import barometric pressure
baro <- read.csv(here("FieldData/LevelLogger/Last_Collection/brllgr_2019-08-14.csv"),skip = 10)
colnames(baro) <- c("Date","Time","ms","kPa","Temp_C")
baro$millibars <- baro$kPa*10
baro$DateTime <- as.POSIXct(paste0(as.character(baro$Date)," ",as.character(baro$Time)),format = "%m/%d/%Y %H:%M")

baro <- baro%>%
  select(DateTime,millibars)

dat <- merge(dat,baro,by="DateTime")


# Calculate DO Saturation
dat$DO.sat <- calc_DO_sat(dat$tempC_436,dat$millibars)

# Calculate light
dat$light <- calc_light(dat$solar.time,-.3,-78.2)

# Set up data frame for model run
df <- dat%>%
  select(solar.time,DO1_mg.L,DO.sat,lvl_436_m,tempC_436,light)
colnames(df) <- c("solar.time","DO.obs","DO.sat","depth","temp.water","light")

df <- df[complete.cases(df),]
df <- df%>%
  distinct()


# Baysean model
bayes_name <- mm_name(type='bayes', pool_K600='none', err_obs_iid=TRUE, err_proc_iid=TRUE)
bayes_specs <- specs(bayes_name)

bayes_specs <- revise(bayes_specs, burnin_steps=2000, saved_steps=200, n_cores=1, GPP_daily_mu=3, GPP_daily_sigma=2)

# Fit the model
mm <- metab(bayes_specs, data=df)

# Predictions
predict_metab(mm)


mcmc <- get_mcmc(mm)
rstan::traceplot(mcmc, pars='K600_daily', nrow=6)
