library(plotly)

attr(All_Data$Date_Time,"tzone") <- "Etc/GMT-5"

fig1 <- plot_ly(data = All_Data, 
                x = ~Date_Time, y = ~WL_m)

fig2 <- plot_ly(data = Stn1_Data_2019_08_14, 
                x = ~Date_Time, y = ~Air_Temp_c
              )

fig3 <- plot_ly(data = WL_stn1, x = ~Date_Time, y = ~WL_m)

fig4 <- plot_ly(data = DO_stn1, x = ~Date_Time, y = ~DO_Temp)

############

fig <- plot_ly(All_Data, x = ~Date_Time, y = ~WL_Temp, name = 'WaterTemp_WLlogger', type = 'scatter', mode = 'lines')
fig <- fig %>% add_trace(y = ~Air_Temp_c, name = 'AirTemp', mode = 'lines+markers')
fig <- fig %>% add_trace(y = ~WL_m, name = 'waterlevel', mode = 'markers')

fig
