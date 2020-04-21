library(dplyr)
library(ggplot2)
library(plotly)
library(lubridate)
library(here)

# STATION 1

stn1Files <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/"), pattern = "DO_1_Predictions",recursive = TRUE,full.names = TRUE)
stn1Stats <- list.files(c(here("Analysis/Stream_Metabolism/ModelOutputs/stn1_model_04162020_01"),
                          here("Analysis/Stream_Metabolism/ModelOutputs/stn1_model_04172020_01")), pattern = "specs",recursive = TRUE,full.names = TRUE)


df <- data.frame()
for(n in 1:length(stn1Files)){
  preds <- read.csv(stn1Files[n])
  specs <- read.csv(stn1Stats[n])
  newdf <- data.frame("dateTime"=preds$date,"GPP"=preds$GPP,"ER"=preds$ER,
                      "K600_init"=as.numeric(as.character(specs[31,3])),
                      "burnin"=as.numeric(as.character(stat[27,3])),
                      "Saved"=as.numeric(as.character(stat[28,3])))
  df <- rbind(df,newdf)
}

df$dateTime <- ymd(df$dateTime)

library(ggplot2)

ggplot(df)+
  geom_point(aes(x=dateTime,y=GPP, color = K600_init))



# STATION 2

stn2Files <- list.files(here::here("Analysis/Stream_Metabolism/ModelOutputs"), pattern = "DO_2_Predictions",recursive = TRUE,full.names = TRUE)
stn2Stats <- list.files(c(here::here("Analysis/Stream_Metabolism/ModelOutputs/stn2_model_04152020_01"),
                          here::here("Analysis/Stream_Metabolism/ModelOutputs/stn2_model_04172020_01")), pattern = "specs",recursive = TRUE,full.names = TRUE)


df2 <- data.frame()
for(n in 1:length(stn2Files)){
  preds <- read.csv(stn2Files[n])
  specs <- read.csv(stn2Stats[n])
  newdf <- data.frame("dateTime"=preds$date,"GPP"=preds$GPP,"ER"=preds$ER,
                      "K600_init"=as.numeric(as.character(specs[31,3])),
                      "burnin"=as.numeric(as.character(specs[27,3])),
                      "Saved"=as.numeric(as.character(specs[28,3])))
  df2 <- rbind(df2,newdf)
}

df2$dateTime <- ymd(df2$dateTime)


ggplot(df2)+
  geom_point(aes(x=dateTime,y=GPP, color = K600_init))+
  labs(title = "Station 2 GPP",
       x = "",
       y = "mol/m2/day")
