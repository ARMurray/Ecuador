library(plotly)
library(here)
library(lubridate)
library(tidyr)
library(dplyr)

##Run "StreamPulse_Rcode_2020-11-30" first
#GPP units: g O2 m^-2 d^-1
#convert to ER

######Sum CO2 and convert to gCO2 per day 
Other_Data <-read.csv(here::here("data_4_analysis/All_Stream_Data_2020-05-14.csv"),
                      header = TRUE)
Other_Data <- Other_Data[which(Other_Data$Inj.x == "No" ),]
Other_Data <- subset(Other_Data, select=c(DateTime, Flux_1_cleaned, V1_CO2_mgC.L, V3_CO2_mgC.L))
colnames(Other_Data) <- c("Date_Time","Flux_1_cleaned","CO2_gm3_1","CO2_gm3_3") #note - mg per L is same as g per m3
Other_Data$Date_asfactor <- as.Date(Other_Data$Date_Time)

CO2_gm3 <- Other_Data %>% 
  drop_na(CO2_gm3_3) %>%
  group_by(Date_asfactor) %>% 
  summarize(
    CO2_gm3_1_DailyAve = mean(CO2_gm3_1),
    CO2_gm3_3_DailyAve = mean(CO2_gm3_3))


Flux_CO2 <- Other_Data %>% 
  drop_na(Flux_1_cleaned) %>%
  group_by(Date_asfactor) %>% 
  summarize(
    FluxCO2_umolm2_s1_DailyAve = mean(Flux_1_cleaned))
Flux_CO2$FluxCO2_gCO2m2_d1_DailyAve <- 
  Flux_CO2$FluxCO2_umolm2_s1_DailyAve * 1e-6 * 44 * 86400


######LaVirgin Air Temp####
LaVirgin$Date_asfactor <- as.Date(LaVirgin$Date_Time)
LaVirgin_AirTemp_ave <- LaVirgin %>% 
  group_by(Date_asfactor) %>% 
  summarize(
    AirTemp_DailyAve = mean(Air_Temp_LaVirgin))

LaVirgin_AirTemp_rollingAve <- LaVirgin_AirTemp_ave %>%
  dplyr::mutate(AirTemp_02da = zoo::rollmean(AirTemp_DailyAve, k = 2, fill = NA),
                AirTemp_03da = zoo::rollmean(AirTemp_DailyAve, k = 3, fill = NA),
                AirTemp_05da = zoo::rollmean(AirTemp_DailyAve, k = 5, fill = NA),
                AirTemp_07da = zoo::rollmean(AirTemp_DailyAve, k = 7, fill = NA),
                AirTemp_15da = zoo::rollmean(AirTemp_DailyAve, k = 15, fill = NA)) %>% 
  dplyr::ungroup()

LaVirgin_AirTemp_rollingAve <- LaVirgin_AirTemp_rollingAve %>%
  mutate(AirTemp_DailyAve_previousDay=lag(AirTemp_DailyAve))


########Precipitation######
LaVirgin_sum_rollingAve <- LaVirgin_sum %>%
  dplyr::mutate(precipt_03da = zoo::rollmean(Sum_precipt, k = 3, fill = NA),
                precipt_05da = zoo::rollmean(Sum_precipt, k = 5, fill = NA),
                precipt_07da = zoo::rollmean(Sum_precipt, k = 7, fill = NA),
                precipt_15da = zoo::rollmean(Sum_precipt, k = 15, fill = NA),
                precipt_30da = zoo::rollmean(Sum_precipt, k = 30, fill = NA)) %>% 
  dplyr::ungroup()
LaVirgin_sum_rollingAve <- LaVirgin_sum_rollingAve %>%
  mutate(precipt_03da_previousDay=lag(precipt_03da))

LaVirgin_sum_rollingAve$Date_asfactor <- as.Date(LaVirgin_sum_rollingAve$Date)


##### Water Chemistry ######
WaterChem_DOC <- read.csv(here::here("FieldData/WaterChem/DOC.csv"))
colnames(WaterChem_DOC) <- c("SampleID", "date","DOC_mgL","TDN_mgL","PO4_mgL","NO3N_mgL")
WaterChem_DOC$date <- mdy(WaterChem_DOC$date)
WaterChem_DOC$Date_asfactor <- as.Date(WaterChem_DOC$date)
WaterChem_DOC <- WaterChem_DOC %>% filter(SampleID == "Station1")

####Stream Metaboliser predictions####
#######Calculate NEP and convert to gCO2 per day
stn2_predictions <- read.csv(here::here("Analysis/Kriddie/DO_2_Predictions_202011170031.csv"))
stn2_predictions$date <- mdy(stn2_predictions$date)
stn2_predictions$NEP <- stn2_predictions$GPP + stn2_predictions$ER
stn2_predictions$NEP_gCO2m2 <- abs(stn2_predictions$NEP * 44/16)


stn1_predictions_summary <- read.csv(here::here("Analysis/Stream_Metabolism/ModelOutputs/stn1_summary.csv"))
stn1_predictions_Init46.06 <- stn1_predictions_summary %>% filter(K600_init == 46.06)
stn1_predictions_Init46.06$Date_asfactor <- as.Date(stn1_predictions_Init46.06$dateTime)
stn1_predictions_Init46.06$NEP <- stn1_predictions_Init46.06$GPP + stn1_predictions_Init46.06$ER
stn1_predictions_Init46.06$NEP_gCO2m2 <- abs(stn1_predictions_Init46.06$NEP * 22/16)

#####Station 1 data####
Stn1_Data_2019_08_14$Date_asfactor <- as.Date(Stn1_Data_2019_08_14$Date_Time)
stn1_2019_08_14_chla <- Stn1_Data_2019_08_14 %>%
  filter(Chlorophylla_ug.L > 1.5)  %>%
  group_by(Date_asfactor) %>%
  summarize(mean_Chla = mean(Chlorophylla_ug.L),
            #mean_turbidity = mean(Turbidity_NTU),
            #mean_Q = mean(Q_m3L),
            #mean_CDOM = mean(CDOM_ppb)
            )
stn1_2019_08_14_Turb <- Stn1_Data_2019_08_14 %>%
  group_by(Date_asfactor) %>%
  summarize(mean_turbidity = mean(Turbidity_NTU)
  )

stn1_2019_08_14_CDOM <- Stn1_Data_2019_08_14 %>%
  group_by(Date_asfactor) %>%
  summarize(mean_CDOM = mean(CDOM_ppb)
  )
stn1_2019_08_14_Q <- Stn1_Data_2019_08_14 %>%
  group_by(Date_asfactor) %>%
  summarize(Q_DailySum = sum(Q_m3L)
  )

#####Join Data####
stn1_2019_08_14_summary <- full_join(stn1_2019_08_14_chla, stn1_predictions_Init46.06, by="Date_asfactor")
stn1_2019_08_14_summary <- full_join(stn1_2019_08_14_summary, WaterChem_DOC, by="Date_asfactor")
#stn1_2019_08_14_summary <- full_join(stn1_2019_08_14_summary, stn1_2019_08_14_Q, by="Date_asfactor")
stn1_2019_08_14_summary <- left_join(stn1_2019_08_14_summary, LaVirgin_sum_rollingAve, by="Date_asfactor")
stn1_2019_08_14_summary <- left_join(stn1_2019_08_14_summary, LaVirgin_AirTemp_rollingAve, by="Date_asfactor")
stn1_2019_08_14_summary <- full_join(CO2_gm3, stn1_2019_08_14_summary, by="Date_asfactor")
stn1_2019_08_14_summary <- full_join(Flux_CO2, stn1_2019_08_14_summary, by="Date_asfactor")

########


All_Data <- All_Data[order(as.Date(All_Data$Date_Time)),] 

attr(All_Data$Date_Time,"tzone") <- "Etc/GMT-5"

fig1 <- plot_ly(data = All_Data, 
                x = ~Date_Time, y = ~WL_m)

fig2 <- plot_ly(data = stn3_All, 
                x = ~Date_Time, y = ~EC_us
              )

fig3 <- plot_ly(data = WL_stn1, x = ~Date_Time, y = ~WL_m)

fig4 <- plot_ly(data = DO_stn1, x = ~Date_Time, y = ~DO_Temp)

############

Stn1_Data_2020_01_19$WL_m_log <- log10(Stn1_Data_2020_01_19$WL_m*100)
fig2 <- plot_ly(Stn1_Data_2020_01_19, x = ~Date_Time, y = ~WL_m, name = 'Water Level meters', 
               type = 'scatter', mode = 'lines')
fig1 <- fig1 %>% add_trace(y = ~WL_m_log, name = 'water level unitless', mode = 'lines')
#fig <- fig %>% add_trace(y = ~Air_Temp_c, name = 'AirTemp', mode = 'lines+markers')
#fig <- fig %>% add_trace(y = ~WL_m, name = 'waterlevel', mode = 'markers')

fig1


fig <- plot_ly(stn2_All, x = ~Date_Time, y = ~DO_mgl, name = 'DO_mgl', 
               type = 'scatter', mode = 'lines')
#fig <- fig %>% add_trace(y = ~DO_Temp, name = 'WaterTemp_DO', mode = 'lines')
#fig <- fig %>% add_trace(y = ~Air_Temp_c, name = 'AirTemp', mode = 'lines+markers')
#fig <- fig %>% add_trace(y = ~WL_m, name = 'waterlevel', mode = 'markers')

fig

fig2 <- plot_ly(LaVirgin_sum, x = ~Date, y = ~Sum_precipt, type = 'bar', name = 'precipitation')

fig3 <- plot_ly(stn2_predictions, x = ~date, y= ~GPP, name = 'GPP', 
                type = 'scatter',mode = 'lines')
fig3 <- fig3 %>% add_trace(y = ~ER, name = 'ER', mode = 'markers + lines')


fig_all <- subplot(fig1, fig2, #fig2, 
                   nrows = 2, shareX = TRUE)

################# Plot Summer Data
fig <- plot_ly(Stn1_Data_2019_08_14, x = ~Date_Time, y = ~WL_m, name = 'WL_m', 
               type = 'scatter', mode = 'lines')
fig2 <- fig %>% add_trace(y = ~Turbidity_NTU, name = 'Turbidity_NTU', mode = 'markers')
fig3 <- fig %>% add_trace(y = ~Chlorophylla_ug.L, name = 'Chlorophylla_ug.L', mode = 'lines+markers')
fig4 <- fig3 %>% add_trace(y = ~CDOM_ppb, name = 'CDOM', mode = 'markers')
fig5 <- fig %>% add_trace(y = ~CO2_ppm_1, name = 'CO2', mode = 'markers')



fig_all <- subplot(fig3, fig, fig2, 
                   nrows = 3, shareX = TRUE)


#Staging ground

fig <- plot_ly(stn1_2019_08_14_summary, x = ~Date_asfactor, y = ~FluxCO2_gCO2m2_d1_DailyAve, name = 'CO2 flux gCO2 per m2 per day', 
               type = 'scatter', mode = 'lines')

fig5 <- plot_ly(stn1_2019_08_14_summary, x = ~Date_asfactor, y = ~NEP_gCO2m2, name = 'NEP gCO2 per m2 per day', 
        type = 'scatter', mode = 'markers + lines')

fig_all <- subplot(fig, fig5, 
                   nrows = 2, shareX = TRUE)

stn1_2019_08_14_summary$precipt_03da_previousDay
plot_ly(stn1_2019_08_14_summary, x = ~precipt_03da_previousDay, y = ~GPP, name = 'DO_mgl', 
        type = 'scatter', mode = 'markers')
########################################
####These plots are kinda interesting
########################################

#GPP vs ER
plot_ly(stn1_2019_08_14_summary, x = ~ER, y = ~GPP, name = 'DO_mgl', 
        type = 'scatter', mode = 'markers')

#comparing flux with NEP

fig <- plot_ly(stn1_2019_08_14_summary, x = ~Date_asfactor, y = ~FluxCO2_gCO2m2_d1_DailyAve, name = 'CO2 flux gCO2 per m2 per day', 
               type = 'scatter', mode = 'lines')
fig1 <- fig %>% add_trace(y = ~NEP_gCO2m2, name = 'NEP gCO2 per m2 per day', mode = 'lines')
fig1

#GPP vs precipt15
plot_ly(stn1_2019_08_14_summary, x = ~precipt_15da, y = ~NEP_gCO2m2, 
        type = 'scatter', mode = 'markers')

#GPP vs Precipt03 previous day
plot_ly(stn1_2019_08_14_summary, x = ~precipt_03da_previousDay, y = ~GPP, name = 'DO_mgl', 
        type = 'scatter', mode = 'markers')

#ER vs DOC
plot_ly(stn1_2019_08_14_summary, x = ~ER, y = ~DOC_mgL, #name = 'DO_mgl', 
        type = 'scatter', mode = 'markers')

#GPP vs TDN
plot_ly(stn1_2019_08_14_summary, x = ~GPP, y = ~TDN_mgL, #name = 'DO_mgl', 
        type = 'scatter', mode = 'markers')


#GPP vs chla
#this needs some cleaning
plot_ly(stn1_2019_08_14_summary, x = ~mean_Chla, y = ~GPP, name = 'DO_mgl', 
        type = 'scatter', mode = 'markers')

