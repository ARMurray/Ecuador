library(plotly)
library(here)
library(lubridate)

stn2_predictions <- read.csv(here::here("Analysis/Kriddie/DO_2_Predictions_202011170031.csv"))
stn2_predictions$date <- mdy(stn2_predictions$date)

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

#################
fig <- plot_ly(stn1_All, x = ~Date_Time, y = ~DO_mgl, name = 'Dissolved Oxygen mgL', 
               type = 'scatter', mode = 'lines')
fig2 <- plot_ly(Stn1_Data_2020_01_19, x = ~Date_Time, y = ~WL_m, name = 'water level', 
        type = 'scatter', mode = 'lines')
