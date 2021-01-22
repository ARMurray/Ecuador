library(tidyverse)
library(lubridate)
library(ggpubr)
library(here)
library(imputeTS)
library(cowplot)

#############
# STATION 1 #
#############


stn1Files <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn1_outputs_JAN_k60"), pattern = "Predictions_",recursive = TRUE,full.names = TRUE)
stn1Names <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn1_outputs_JAN_k60"), pattern = "Predictions_",recursive = TRUE,full.names = FALSE)

stn1Stats <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn1_outputs_JAN_k60"), pattern = "Specs_",recursive = TRUE,full.names = TRUE)


df <- data.frame()
for(n in 1:length(stn1Files)){
  preds <- read.csv(stn1Files[n])
  specs <- read.csv(stn1Stats[n])
  newdf <- data.frame("dateTime"=preds$date,"GPP"=preds$GPP,"ER"=preds$ER,
                      "K600_init"=as.numeric(as.character(specs[31,3])),
                      "burnin"=as.numeric(as.character(specs[27,3])),
                      "Saved"=as.numeric(as.character(specs[28,3])),
                      "ID" = substr(stn1Names[n],18,29))
  df <- rbind(df,newdf)
}

df$dateTime <- ymd(df$dateTime)


# GPP
gpp1a <- ggplot(df)+
  geom_line(aes(x=dateTime,y=GPP, group = ID),color = "black",alpha = 0.2)+
  labs(x = "", y = bquote('GPP ['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 1 GPP")+
  geom_text(aes(x=ymd("20190810"), y = -.5, label = paste0("N = ",length(stn1Files))), size = 8)+
  ylim(ymin = -1, ymax = 2)+
  geom_hline(yintercept = 0)
gpp1a

# ER
er1a <- ggplot(df)+
  geom_line(aes(x=dateTime,y=ER, group = ID),color = "black", alpha = 0.2)+
  labs(x = "", y = bquote('ER ['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 1 ER")+
  geom_text(aes(x=ymd("20190810"), y = -5.5, label = paste0("N = ",length(stn1Files))), size = 8)+
  ylim(ymin = -15, ymax = 2)+
  geom_hline(yintercept = 0)
er1a
