library(plotly)
library(here)
library(lubridate)
library(tidyr)
library(dplyr)

WaterChem_DOC <- read.csv(here::here("FieldData/WaterChem/DOC.csv"))
colnames(WaterChem_DOC) <- c("SampleID", "date","DOC_mgL","TDN_mgL","PO4_mgL","NO3N_mgL")
WaterChem_DOC$date <- mdy(WaterChem_DOC$date)
WaterChem_DOC$Date_asfactor <- as.Date(WaterChem_DOC$date)

stn2_predictions <- read.csv(here::here("Analysis/Kriddie/DO_2_Predictions_202011170031.csv"))
stn2_predictions$date <- mdy(stn2_predictions$date)

stn1_predictions_summary <- read.csv(here::here("Analysis/Stream_Metabolism/ModelOutputs/stn1_summary.csv"))
stn1_predictions_Init46.06 <- stn1_predctions_summary %>% filter(K600_init == 46.06)
stn1_predctions_Init46.06$Date_asfactor <- as.Date(stn1_predctions_Init46.06$dateTime)

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



stn1_2019_08_14_summary <- full_join(stn1_2019_08_14_chla, stn1_predctions_Init46.06, by="Date_asfactor")
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

fig <- plot_ly(Stn1_Data_2019_08_14, x = ~Date_Time, y = ~DO_mgl, name = 'DO_mgl', 
               type = 'scatter', mode = 'lines')
fig2 <- fig %>% add_trace(y = ~Turbidity_NTU, name = 'Turbidity_NTU', mode = 'markers')
fig3 <- fig %>% add_trace(y = ~Chlorophylla_ug.L, name = 'Chlorophylla_ug.L', mode = 'lines+markers')
fig4 <- fig3 %>% add_trace(y = ~CDOM_ppb, name = 'CDOM', mode = 'markers')
fig5 <- fig %>% add_trace(y = ~CO2_ppm_1, name = 'CO2', mode = 'markers')



fig_all <- subplot(fig3, fig, fig2, 
                   nrows = 3, shareX = TRUE)


####These are kinda interesting

plot_ly(stn1_2019_08_14_summary, x = ~ER, y = ~GPP, name = 'DO_mgl', 
        type = 'scatter', mode = 'markers')
plot_ly(stn1_2019_08_14_summary, x = ~mean_Chla, y = ~GPP, name = 'DO_mgl', 
        type = 'scatter', mode = 'markers')

