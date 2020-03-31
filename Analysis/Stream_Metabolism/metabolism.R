library(streamMetabolizer)
library(dplyr)
library(imputeTS)
library(here)


# Prep data for stream metabolizer
# Instructions: `http://usgs-r.github.io/streamMetabolizer/`

# Import non-injection data
dat <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))%>%
  select(DateTime,Inj,DO1_mg.L,DO2_mg.L,DO4_mg.L,tempC_421,lvl_436_m,lvl_421_m,stn3_Q)%>%
  filter(Inj == "No")

dat$DateTime <- as.POSIXct(dat$DateTime,format = "%m/%d/%Y %H:%M", tz = "Etc/GMT+5")

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

# Fix timestamps and interpolate missing data (Station 1)
## Round timestamps to closest 15-minute
df1a <- df1%>%
  mutate("solar.time" = round_date(solar.time, '15 minutes'))

## Create full datafram of timesteps
timestep <- df1$solar.time[2]-df1$solar.time[1]
fulltime1 <- data.frame(solar.time=seq.POSIXt(df1$solar.time[1], df1$solar.time[length(df1$solar.time)], by=timestep))%>%
  mutate(solar.time=round_date(solar.time,'15 minutes'))%>%
  left_join(df1a)%>%
  na_interpolation(option = 'linear', maxgap = Inf)

# plot the comparrison
#plot1 <- ggplot()+
#  geom_point(data=fulltime, aes(x=solar.time,y=DO.obs),col='red',size=.9)+
#  geom_point(data=df1, aes(x=solar.time,y=DO.obs))
#plot1

##### DO Sensor 2 ######
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

## Create full datafram of timesteps
timestep <- df2$solar.time[2]-df2$solar.time[1]
fulltime2 <- data.frame(solar.time=seq.POSIXt(df2$solar.time[1], df2$solar.time[length(df2$solar.time)], by=timestep))%>%
  mutate(solar.time=round_date(solar.time,'15 minutes'))%>%
  left_join(df2a)%>%
  na_interpolation(option = 'linear', maxgap = Inf)

##### DO Sensor 4 ##### 
df4 <- dat%>%
  select(solar.time,DO4_mg.L,DO.sat,lvl_421_m,tempC_421,light,stn3_Q)
colnames(df4) <- c("solar.time","DO.obs","DO.sat","depth","temp.water","light","discharge")

df4 <- df4[complete.cases(df4),]
df4 <- df4%>%
  distinct()%>%
  arrange(solar.time)

# Fix timestamps and interpolate missing data (Station 4)
## Round timestamps to closest 15-minute
df4a <- df4%>%
  mutate("solar.time" = round_date(solar.time, '15 minutes'))

## Create full datafram of timesteps
timestep <- df4$solar.time[2]-df4$solar.time[1]
fulltime4 <- data.frame(solar.time=seq.POSIXt(df4$solar.time[1], df4$solar.time[length(df1$solar.time)], by=timestep))%>%
  mutate(solar.time=round_date(solar.time,'15 minutes'))%>%
  left_join(df4a)%>%
  na_interpolation(option = 'linear', maxgap = Inf)

# ***************** Baysean model parameters ********************** #

bayes_name <- mm_name(type='bayes', pool_K600='binned', err_obs_iid=TRUE, err_proc_iid=TRUE)
bayes_specs <- specs(bayes_name)

bayes_specs <- revise(bayes_specs, burnin_steps=100, saved_steps=200, n_cores=16, GPP_daily_mu=3, GPP_daily_sigma=2)

# Fit the models
t1 <- Sys.time()
mm1 <- metab(bayes_specs, data=fulltime1)
t2 <- Sys.time()
mm2 <- metab(bayes_specs, data=fulltime2)
t3 <- Sys.time()
mm4 <- metab(bayes_specs, data=fulltime4)
t4 <- Sys.time()


# Set the output folder
dir.create("Analysis/Stream_Metabolism/ModelOutputs/model_03312020_01/")
folder <- here::here("Analysis/Stream_Metabolism/ModelOutputs/model_03312020_01/")

# Write model parameters
writeLines(paste0("Station 1 started at: ",t1,"<br>",
                  "Station 2 started at: ",t2,"<br>",
                  "Station 4 started at: ",t3, " and finished at: ",t4,"<br><br>",
                  bayes_specs), paste0(folder,"specs.txt"))

# Write model outputs to text files
capture.output(mm1,file=paste0(folder,"/DO_1_Output.txt"))
capture.output(mm2,file=paste0(folder,"/DO_2_Output.txt"))
capture.output(mm4,file=paste0(folder,"/DO_4_Output.txt"))

# Predictions
pred1a <- predict_metab(mm1)
pred2 <- predict_metab(mm2)
pred4 <- predict_metab(mm4)

# Write Predictions to files
write.csv(pred1,paste0(folder,"/DO_1_Predictions.csv"))
write.csv(pred2,paste0(folder,"/DO_2_Predictions.csv"))
write.csv(pred4,paste0(folder,"/DO_4_Predictions.csv"))


## K600 Plots

# Station 1
mcmc <- get_mcmc(mm1)
png(filename=paste0(folder,"mcmc_stn1.png"))
rstan::traceplot(mcmc, pars='K600_daily', nrow=6)
dev.off()

# Station 2
mcmc2 <- get_mcmc(mm2)
png(filename=paste0(folder,"mcmc_stn2.png"))
rstan::traceplot(mcmc2, pars='K600_daily', nrow=6)
dev.off()

# Station 4
mcmc4 <- get_mcmc(mm4)
png(filename=paste0(folder,"mcmc_stn4.png"))
rstan::traceplot(mcmc4, pars='K600_daily', nrow=6)
dev.off()


# ER & GPP Plots
png(filename=paste0(folder,"metabolism_stn1.png"))
plot_metab_preds(mm1)
dev.off()

png(filename=paste0(folder,"metabolism_stn2.png"))
plot_metab_preds(mm2)
dev.off()

png(filename=paste0(folder,"metabolism_stn4.png"))
plot_metab_preds(mm4)
dev.off()

#msg <- get_params(mm1)



