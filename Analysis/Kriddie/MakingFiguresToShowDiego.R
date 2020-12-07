library(plotly)
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

fig <- plot_ly(stn3_All, x = ~Date_Time, y = ~DO_mgl, name = 'DO_mgl', 
               type = 'scatter', mode = 'lines')
fig <- fig %>% add_trace(y = ~DO_Temp, name = 'WaterTemp_DO', mode = 'lines')
#fig <- fig %>% add_trace(y = ~Air_Temp_c, name = 'AirTemp', mode = 'lines+markers')
#fig <- fig %>% add_trace(y = ~WL_m, name = 'waterlevel', mode = 'markers')

fig


fig2 <- plot_ly(stn3_All, x = ~Date_Time, y = ~DO_mgl, name = 'DO_mgl', 
               type = 'scatter', mode = 'lines')
fig <- fig %>% add_trace(y = ~DO_Temp, name = 'WaterTemp_DO', mode = 'lines')
#fig <- fig %>% add_trace(y = ~Air_Temp_c, name = 'AirTemp', mode = 'lines+markers')
#fig <- fig %>% add_trace(y = ~WL_m, name = 'waterlevel', mode = 'markers')

fig

fig2 <- plot_ly(LaVirgin_sum, x = ~Date, y = ~Sum_precipt, type = 'bar', name = 'precipitation')

fig_all <- subplot(fig, fig2, nrows = 2, shareX = TRUE)

