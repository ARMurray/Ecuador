## Daily Discharge
dailyQ <- filt13%>%
  select(day, stn3_Q)%>%
  group_by(day)%>%
  mutate(dailyQ = mean(stn3_Q, na.rm = TRUE))%>%
  ungroup()%>%
  select(day,dailyQ)%>%
  distinct()%>%
  rename("date"="day")%>%
  mutate(date = as.POSIXct(date))%>%
  mutate(Discharge = ifelse( dailyQ <20, "< 20",
                             ifelse(dailyQ > 20 & dailyQ <45, "< 45",
                                    ifelse(dailyQ > 45 & dailyQ <90, "< 90",
                                           ifelse(dailyQ > 90 & dailyQ < Inf, "< 250", NA)))))
  


up <- up%>%
  left_join(dailyQ, by="date")%>%
  na.omit()

down <- down%>%
  left_join(dailyQ, by="date")%>%
  na.omit()


## Plot
legendtitle <- list(yref='paper',xref="paper",y=.65,x=1.3, text="<b>Process</b>",showarrow=F)
note <- list(yref='paper',xref="paper",y=.2,x=1.45, text="<i>*Respiration is<br>shown as<br>absolute value.</i>",showarrow=F)


uplot <- up%>%
  plot_ly(x = ~date, y = ~abs(Val)/1000000)%>%
  add_markers(color = ~Var,
              colors = ~setNames(color, var),  size=50, legendgroup = ~Var)%>%
  layout(
    title = "Daily Evasion & Metabolism (Upstream)",
    xaxis = list(type = "date",
                 showticklabels = TRUE,
                 tickangle = 0,
                 tickfont = xaxisFont,
                 tickformat = "%b %d",
                 exponentformat = "E"),
    yaxis = list(title = "mol/m<sup>2</sup>d<sup>-1</sup>", type = "",titlefont = labelFont,
                 showticklabels = TRUE,
                 tickangle = 0,
                 tickfont = yaxisFont),
    showlegend=F,
    legend = list(x=1, y=.5)
  )

# Downstream
dplot <- down%>%
  plot_ly(x = ~date, y = ~abs(Val)/1000000)%>%
  add_markers(color = ~Var,
              colors = ~setNames(color, var),  size=50, legendgroup = ~Var, showlegend = F)%>%
  layout(
    title = "Daily Evasion & Metabolism",
    xaxis = list(type="date",
                 showticklabels = TRUE,
                 tickangle = 0,
                 tickfont = xaxisFont,
                 tickformat = "%b %d",
                 exponentformat = "E"),
    yaxis = list(title = "", type = "",titlefont = labelFont,
                 showticklabels = FALSE,
                 tickangle = 0,
                 tickfont = yaxisFont),
    annotations = list(legendtitle,note),
    legend = list(x=1, y=.5)
  )

subplot(uplot,dplot, titleY = TRUE, titleX = TRUE, shareY = TRUE)