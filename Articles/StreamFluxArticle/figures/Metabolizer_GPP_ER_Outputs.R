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

dfMean <- df%>%
  group_by(dateTime)%>%
  mutate(meanGPP = mean(GPP),
         meanER = mean(ER))%>%
  select(dateTime, meanGPP, meanER)%>%
  distinct()

# GPP
gpp1 <- ggplot(df)+
  geom_line(aes(x=dateTime,y=GPP, group = ID),color = "black",alpha = 0.2)+
  geom_line(data = dfMean, aes(x = dateTime, y = meanGPP), color = "red", size = .4)+
  labs(x = "", y = bquote('GPP ['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 1 GPP")+
  geom_text(aes(x=ymd("20190910"), y = -.8, label = paste0("N = ",length(stn1Files))), size = 6)+
  ylim(ymin = -1, ymax = 2)+
  geom_hline(yintercept = 0)+
  labs(fill = "Mean Daily Bernie")
gpp1

# ER
er1 <- ggplot(df)+
  geom_line(aes(x=dateTime,y=ER, group = ID),color = "black", alpha = 0.2)+
  geom_line(data = dfMean, aes(x = dateTime, y = meanER), color = "red", size = .4)+
  labs(x = "", y = bquote('ER ['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 1 ER")+
  geom_text(aes(x=ymd("20190910"), y = -10, label = paste0("N = ",length(stn1Files))), size = 6)+
  ylim(ymin = -15, ymax = 2)+
  geom_hline(yintercept = 0)
er1

#############
# STATION 2 #
#############

stn2Files <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn2_outputs_JAN_k60"), pattern = "Predictions_",recursive = TRUE,full.names = TRUE)
stn2Names <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn2_outputs_JAN_k60"), pattern = "Predictions_",recursive = TRUE,full.names = FALSE)

stn2Stats <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn2_outputs_JAN_k60"), pattern = "Specs_",recursive = TRUE,full.names = TRUE)


df2 <- data.frame()
for(n in 1:length(stn2Files)){
  preds <- read.csv(stn2Files[n])
  specs <- read.csv(stn2Stats[n])
  newdf <- data.frame("dateTime"=preds$date,"GPP"=preds$GPP,"ER"=preds$ER,
                      "K600_init"=as.numeric(as.character(specs[31,3])),
                      "burnin"=as.numeric(as.character(specs[27,3])),
                      "Saved"=as.numeric(as.character(specs[28,3])),
                      "ID" = substr(stn2Names[n],18,29))
  df2 <- rbind(df2,newdf)
}

df2$dateTime <- ymd(df2$dateTime)

df2Mean <- df2%>%
  group_by(dateTime)%>%
  mutate(meanGPP = mean(GPP),
         meanER = mean(ER))%>%
  select(dateTime, meanGPP, meanER)%>%
  distinct()

# GPP
gpp2 <- ggplot(df2)+
  geom_line(aes(x=dateTime,y=GPP, group = ID),color = "black",alpha = 0.2)+
  geom_line(data = df2Mean, aes(x = dateTime, y = meanGPP, color = "Mean Predicted"),color = 'red', size = .4)+
  labs(x = "", y = bquote('GPP ['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 2 GPP")+
  geom_text(aes(x=ymd("20190910"), y = -.8, label = paste0("N = ",length(stn2Files))), size = 6)+
  ylim(ymin = -1, ymax = 2)+
  geom_hline(yintercept = 0)+
  labs(fill = "Mean Daily Bernie")
gpp2

# ER
er2 <- ggplot(df2)+
  geom_line(aes(x=dateTime,y=ER, group = ID),color = "black", alpha = 0.2)+
  geom_line(data = df2Mean, aes(x = dateTime, y = meanER, color = "Mean Predicted"),color = 'red', size = .4)+
  labs(x = "", y = bquote('ER ['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 2 ER")+
  geom_text(aes(x=ymd("20190910"), y = -10, label = paste0("N = ",length(stn2Files))), size = 6)+
  ylim(ymin = -15, ymax = 2)+
  geom_hline(yintercept = 0)
er2

#############
# STATION 4 #
#############

stn4Files <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn4_outputs_JAN_k60"), pattern = "Predictions_",recursive = TRUE,full.names = TRUE)
stn4Names <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn4_outputs_JAN_k60"), pattern = "Predictions_",recursive = TRUE,full.names = FALSE)

stn4Stats <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn4_outputs_JAN_k60"), pattern = "Specs_",recursive = TRUE,full.names = TRUE)


df4 <- data.frame()
for(n in 1:length(stn4Files)){
  preds <- read.csv(stn4Files[n])
  specs <- read.csv(stn4Stats[n])
  newdf <- data.frame("dateTime"=preds$date,"GPP"=preds$GPP,"ER"=preds$ER,
                      "K600_init"=as.numeric(as.character(specs[31,3])),
                      "burnin"=as.numeric(as.character(specs[27,3])),
                      "Saved"=as.numeric(as.character(specs[28,3])),
                      "ID" = substr(stn4Names[n],18,29))
  df4 <- rbind(df4,newdf)
}

df4$dateTime <- ymd(df4$dateTime)

df4Mean <- df4%>%
  group_by(dateTime)%>%
  mutate(meanGPP = mean(GPP),
         meanER = mean(ER))%>%
  select(dateTime, meanGPP, meanER)%>%
  distinct()

# GPP
gpp4 <- ggplot(df4)+
  geom_line(aes(x=dateTime,y=GPP, group = ID),color = "black",alpha = 0.2)+
  geom_line(data = df4Mean, aes(x = dateTime, y = meanGPP, color = "Mean Predicted"),color = 'red', size = .4)+
  labs(x = "", y = bquote('GPP ['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 4 GPP")+
  geom_text(aes(x=ymd("20190910"), y = -.8, label = paste0("N = ",length(stn4Files))), size = 6)+
  ylim(ymin = -1, ymax = 2)+
  geom_hline(yintercept = 0)+
  labs(fill = "Mean Daily Bernie")
gpp4

# ER
er4 <- ggplot(df4)+
  geom_line(aes(x=dateTime,y=ER, group = ID, color = "Iterations"),color = "black", alpha = 0.2)+
  geom_line(data = df4Mean, aes(x = dateTime, y = meanER, color = "Mean Predicted"),color = 'red', size = .4)+
  labs(x = "", y = bquote('ER ['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 4 ER")+
  geom_text(aes(x=ymd("20190910"), y = -10, label = paste0("N = ",length(stn4Files))), size = 6)+
  ylim(ymin = -15, ymax = 2)+
  geom_hline(yintercept = 0)
er4


plot_grid(gpp1,gpp2,gpp4,
          er1,er2,er4, nrow = 2)

