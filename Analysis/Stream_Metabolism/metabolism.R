library(streamMetabolizer)
library(dplyr)
library(here)


# Prep data for stream metabolizer
# Instructions: `http://usgs-r.github.io/streamMetabolizer/`

# Import non-injection data
dat <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))%>%
  select(DateTime,Inj,DO1_mg.L,DO2_mg.L,DO4_mg.L,tempC_421,lvl_436_m,lvl_421_m,stn3_Q)%>%
  filter(Inj == "No")

dat$DateTime <- as.POSIXct(dat$DateTime, tz = "Etc/GMT+5")

# Convert to solar time
dat$solar.time <- calc_solar_time(dat$DateTime, longitude=-78.2)

#Import barometric pressure
baro <- read.csv(here("FieldData/LevelLogger/Last_Collection/brllgr_2019-08-14.csv"),skip = 10)
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

# DO Sensor 2
df2 <- dat%>%
  select(solar.time,DO2_mg.L,DO.sat,lvl_421_m,tempC_421,light,stn3_Q)
colnames(df2) <- c("solar.time","DO.obs","DO.sat","depth","temp.water","light","discharge")

df2 <- df2[complete.cases(df2),]
df2 <- df2%>%
  distinct()%>%
  arrange(solar.time)

# DO Sensor 4 
df4 <- dat%>%
  select(solar.time,DO4_mg.L,DO.sat,lvl_421_m,tempC_421,light,stn3_Q)
colnames(df4) <- c("solar.time","DO.obs","DO.sat","depth","temp.water","light","discharge")

df4 <- df4[complete.cases(df4),]
df4 <- df4%>%
  distinct()%>%
  arrange(solar.time)

# Baysean model parameters
bayes_name <- mm_name(type='bayes', pool_K600='binned', err_obs_iid=TRUE, err_proc_iid=TRUE)
bayes_specs <- specs(bayes_name)

bayes_specs <- revise(bayes_specs, burnin_steps=100, saved_steps=300, n_cores=4, GPP_daily_mu=3, GPP_daily_sigma=2)

# Fit the models
mm1 <- metab(bayes_specs, data=df1)
mm2 <- metab(bayes_specs, data=df2)
mm4 <- metab(bayes_specs, data=df4)


# Set the output folder
dir.create("Analysis/Stream_Metabolism/ModelOutputs/model_03272020_01/")
folder <- here("Analysis/Stream_Metabolism/ModelOutputs/model_03272020_01/")

# Write model parameters
writeLines(paste0(bayes_specs), paste0(folder,"specs.txt"))

# Write model outputs to text files
capture.output(mm1,file=paste0(folder,"/DO_1_Output.txt"))
capture.output(mm2,file=paste0(folder,"/DO_2_Output.txt"))
capture.output(mm4,file=paste0(folder,"/DO_4_Output.txt"))

# Predictions
pred1 <- predict_metab(mm1)
pred2 <- predict_metab(mm2)
pred4 <- predict_metab(mm4)

# Write Predictions to files
write.csv(pred1,paste0(folder,"/DO_1_Predictions.csv"))
write.csv(pred2,paste0(folder,"/DO_2_Predictions.csv"))
write.csv(pred4,paste0(folder,"/DO_4_Predictions.csv"))

mcmc <- get_mcmc(mm1)
rstan::traceplot(mcmc, pars='K600_daily', nrow=6)

# Plots
plot_metab_preds(mm1)
plot_metab_preds(mm2)
plot_metab_preds(mm4)
