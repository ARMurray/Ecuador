library(plotly)
library(here)
library(lubridate)
library(tidyr)
library(dplyr)

##Run "StreamPulse_Rcode_2020-11-30" first
#GPP units: g O2 m^-2 d^-1

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
stn2_predictions <- read.csv(here::here("Analysis/Kriddie/DO_2_Predictions_202011170031.csv"))
stn2_predictions$date <- mdy(stn2_predictions$date)

stn1_predictions_summary <- read.csv(here::here("Analysis/Stream_Metabolism/ModelOutputs/stn1_summary.csv"))
stn1_predictions_Init46.06 <- stn1_predctions_summary %>% filter(K600_init == 46.06)
stn1_predctions_Init46.06$Date_asfactor <- as.Date(stn1_predctions_Init46.06$dateTime)

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
stn1_2019_08_14_summary <- full_join(stn1_2019_08_14_chla, stn1_predctions_Init46.06, by="Date_asfactor")
stn1_2019_08_14_summary <- full_join(stn1_2019_08_14_summary, WaterChem_DOC, by="Date_asfactor")
stn1_2019_08_14_summary <- full_join(stn1_2019_08_14_summary, stn1_2019_08_14_Q, by="Date_asfactor")
stn1_2019_08_14_summary <- left_join(stn1_2019_08_14_summary, LaVirgin_sum_rollingAve, by="Date_asfactor")
stn1_2019_08_14_summary <- left_join(stn1_2019_08_14_summary, LaVirgin_AirTemp_rollingAve, by="Date_asfactor")

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

stn1_All$WL_m_log <- log10(stn1_All$WL_m*100)
fig1 <- plot_ly(stn1_All, x = ~Date_Time, y = ~DO_mgl, name = 'Dissolved Oxygen mgL', 
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


fig_all <- subplot(fig3, fig1, #fig2, 
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

fig <- plot_ly(Stn2_Data_2019_08_14, x = ~Date_Time, y = ~DO_Temp, name = 'WL_m', 
               type = 'scatter', mode = 'lines')

fig5 <- plot_ly(stn1_2019_08_14_summary, x = ~Date_asfactor, y = ~GPP, name = 'GPP', 
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

#GPP vs precipt15
plot_ly(stn1_2019_08_14_summary, x = ~precipt_15da, y = ~GPP, name = 'DO_mgl', 
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

