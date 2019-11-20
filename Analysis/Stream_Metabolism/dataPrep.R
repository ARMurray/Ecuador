library(streamMetabolizer)
library(dplyr)
library(here)


# Prep data for stream metabolizer
# Instructions: `http://usgs-r.github.io/streamMetabolizer/`

# Import non-injection data
dat <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))%>%
  select(DateTime,Inj,DO1_mg.L,DO2_mg.L,DO4_mg.L,tempC_436,lvl_436_m,lvl_421_m )%>%
  filter(Inj == "No")

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

# Set up data frame for model run at each station

# DO Sensor 1
df1 <- dat%>%
  select(solar.time,DO1_mg.L,DO.sat,lvl_436_m,tempC_436,light)
colnames(df1) <- c("solar.time","DO.obs","DO.sat","depth","temp.water","light")

df1 <- df1[complete.cases(df1),]
df1 <- df1%>%
  distinct()

# DO Sensor 2
df2 <- dat%>%
  select(solar.time,DO2_mg.L,DO.sat,lvl_421_m,tempC_436,light)
colnames(df2) <- c("solar.time","DO.obs","DO.sat","depth","temp.water","light")

df2 <- df2[complete.cases(df2),]
df2 <- df2%>%
  distinct()

# DO Sensor 4 (We need to use water level from another sensor here, we'll use station 1 as it was most similar)
df4 <- dat%>%
  select(solar.time,DO4_mg.L,DO.sat,lvl_436_m,tempC_436,light)
colnames(df4) <- c("solar.time","DO.obs","DO.sat","depth","temp.water","light")

df4 <- df4[complete.cases(df4),]
df4 <- df4%>%
  distinct()

# Baysean model parameters
bayes_name <- mm_name(type='bayes', pool_K600='none', err_obs_iid=TRUE, err_proc_iid=TRUE)
bayes_specs <- specs(bayes_name)

bayes_specs <- revise(bayes_specs, burnin_steps=4000, saved_steps=6000, n_cores=2, GPP_daily_mu=3, GPP_daily_sigma=2)

# Fit the models
mm1 <- metab(bayes_specs, data=df1)
mm2 <- metab(bayes_specs, data=df2)
mm4 <- metab(bayes_specs, data=df4)

# Write model outputs to text files
capture.output(mm1,file=here("Analysis/Stream_Metabolism/ModelOutputs/DO_1_Output.txt"))
capture.output(mm2,file=here("Analysis/Stream_Metabolism/ModelOutputs/DO_2_Output.txt"))
capture.output(mm4,file=here("Analysis/Stream_Metabolism/ModelOutputs/DO_4_Output.txt"))

# Predictions
pred1 <- predict_metab(mm1)
pred2 <- predict_metab(mm2)
pred4 <- predict_metab(mm4)

# Write Predictions to files
write.csv(pred1, here("Analysis/Stream_Metabolism/ModelOutputs/DO_1_Predictions.txt"))
write.csv(pred2, here("Analysis/Stream_Metabolism/ModelOutputs/DO_2_Predictions.txt"))
write.csv(pred4, here("Analysis/Stream_Metabolism/ModelOutputs/DO_4_Predictions.txt"))

mcmc <- get_mcmc(mm1)
rstan::traceplot(mcmc, pars='K600_daily', nrow=6)

# Plots
plot_metab_preds(mm1)
plot_metab_preds(mm2)
plot_metab_preds(mm4)
