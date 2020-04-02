library(plotly)
library(dplyr)
library(lubridate)
library(here)

outputs <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs"),pattern = "Predictions.csv", recursive = TRUE, full.names = TRUE)

outputs

df <- data.frame()
for(n in 1:length(outputs)){
  file <- read.csv(outputs[n])
  model <- substr(outputs[n],85,95)
  station <- paste0("Station ", substr(outputs[n],100,100))
  newdf <- data.frame("date"=file$date, "GPP" = file$GPP, "ER" = file$ER, "Model" = model, "Station" = station)
  df <- rbind(df,newdf)
}

# Convert dates from factors to dates
df <- df%>%
  mutate("date"=ymd(date))

# Plot

#GPP
df%>%
  group_by(Model)%>%
  plot_ly(x=~date,y=~GPP,color = ~Model, linetype = ~Station,
          hoverinfo = "text",
          text = ~paste(Station,"<br>",
                        "GPP: ", round(GPP,3),"<br>",
                        "Date: ",date))%>%
  add_lines()%>%
  layout(title = 'GPP Model Runs',
         xaxis = list(title = ''),
         yaxis = list (title = 'GPP'))

#ER
df%>%
  group_by(Model)%>%
  plot_ly(x=~date,y=~ER,color = ~Model, linetype = ~Station,
          hoverinfo = "text",
          text = ~paste(Station,"<br>",
                        "ER: ", round(ER,3),"<br>",
                        "Date: ",date))%>%
  add_lines()%>%
  layout(title = 'ER Model Runs',
         xaxis = list(title = ''),
         yaxis = list (title = 'ER'))
