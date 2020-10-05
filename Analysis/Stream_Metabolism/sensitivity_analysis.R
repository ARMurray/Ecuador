library(dplyr)
library(ggplot2)
library(plotly)
library(lubridate)
library(ggpubr)
library(here)

#############
# STATION 1 #
#############


stn1Files <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn1_outputs"), pattern = "Predictions",recursive = TRUE,full.names = TRUE)
stn1Stats <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn1_outputs"), pattern = "Specs",recursive = TRUE,full.names = TRUE)


df <- data.frame()
for(n in 1:length(stn1Files)){
  preds <- read.csv(stn1Files[n])
  specs <- read.csv(stn1Stats[n])
  newdf <- data.frame("dateTime"=preds$date,"GPP"=preds$GPP,"ER"=preds$ER,
                      "K600_init"=as.numeric(as.character(specs[31,3])),
                      "burnin"=as.numeric(as.character(specs[27,3])),
                      "Saved"=as.numeric(as.character(specs[28,3])),
                      "ID" = substr(stn1Files[n],109,120))
  df <- rbind(df,newdf)
}

df$dateTime <- ymd(df$dateTime)


# GPP
gpp1 <- ggplot(df)+
  geom_line(aes(x=dateTime,y=GPP, group = ID),alpha = 0.1)+
  labs(x = "", y = bquote('GPP ['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 1 GPP")+
  geom_text(aes(x=ymd("20190810"), y = -.5, label = paste0("N = ",length(stn1Files))), size = 8)+
  ylim(ymin = -1, ymax = 2)+
  geom_hline(yintercept = 0)

# ER
er1 <- ggplot(df)+
  geom_line(aes(x=dateTime,y=ER, group = ID),alpha = 0.1)+
  labs(x = "", y = bquote('ER ['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 1 ER")+
  geom_text(aes(x=ymd("20190810"), y = -5.5, label = paste0("N = ",length(stn1Files))), size = 8)+
  ylim(ymin = -7, ymax = 2)+
  geom_hline(yintercept = 0)


#############
# STATION 2 #
#############

stn2Files <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn2_outputs"), pattern = "Predictions",recursive = TRUE,full.names = TRUE)
stn2Stats <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn2_outputs"), pattern = "Specs",recursive = TRUE,full.names = TRUE)


df2 <- data.frame()
for(n in 1:length(stn2Files)){
  preds <- read.csv(stn2Files[n])
  specs <- read.csv(stn2Stats[n])
  newdf <- data.frame("dateTime"=preds$date,"GPP"=preds$GPP,"ER"=preds$ER,
                      "K600_init"=as.numeric(as.character(specs[31,3])),
                      "burnin"=as.numeric(as.character(specs[27,3])),
                      "Saved"=as.numeric(as.character(specs[28,3])),
                      "ID" = substr(stn2Files[n],109,120))
  df2 <- rbind(df2,newdf)
}

df2$dateTime <- ymd(df2$dateTime)


# GPP
gpp2 <- ggplot(df2)+
  geom_line(aes(x=dateTime,y=GPP, group = ID),alpha = 0.1)+
  labs(x = "", y = bquote('GPP ['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 2 GPP")+
  geom_text(aes(x=ymd("20190810"), y = -.5, label = paste0("N = ",length(stn2Files))), size = 8)+
  ylim(ymin = -1, ymax = 2)+
  geom_hline(yintercept = 0)

# ER
er2 <- ggplot(df2)+
  geom_line(aes(x=dateTime,y=ER, group = ID),alpha = 0.1)+
  labs(x = "", y = bquote('ER ['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 2 ER")+
  geom_text(aes(x=ymd("20190810"), y = -5.5, label = paste0("N = ",length(stn2Files))), size = 8)+
  ylim(ymin = -7, ymax = 2)+
  geom_hline(yintercept = 0)


#############
# STATION 4 #
#############

stn4Files <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn4_outputs"), pattern = "Predictions",recursive = TRUE,full.names = TRUE)
stn4Stats <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn4_outputs"), pattern = "Specs",recursive = TRUE,full.names = TRUE)


df4 <- data.frame()
for(n in 1:length(stn4Files)){
  preds <- read.csv(stn4Files[n])
  specs <- read.csv(stn4Stats[n])
  newdf <- data.frame("dateTime"=preds$date,"GPP"=preds$GPP,"ER"=preds$ER,
                      "K600_init"=as.numeric(as.character(specs[31,3])),
                      "burnin"=as.numeric(as.character(specs[27,3])),
                      "Saved"=as.numeric(as.character(specs[28,3])),
                      "ID" = substr(stn4Files[n],109,120))
  df4 <- rbind(df4,newdf)
}

df4$dateTime <- ymd(df4$dateTime)


# GPP
gpp4 <- ggplot(df4)+
  geom_line(aes(x=dateTime,y=GPP, group = ID),alpha = 0.1)+
  labs(x = "", y = bquote('GPP ['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 4 GPP")+
  geom_text(aes(x=ymd("20190810"), y = -.5, label = paste0("N = ",length(stn4Files))), size = 8)+
  ylim(ymin = -1, ymax = 2)+
  geom_hline(yintercept = 0)

# ER
er4 <- ggplot(df4)+
  geom_line(aes(x=dateTime,y=ER, group = ID),alpha = 0.1)+
  labs(x = "", y = bquote('ER ['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 4 ER")+
  geom_text(aes(x=ymd("20190810"), y = -5.5, label = paste0("N = ",length(stn4Files))), size = 8)+
  ylim(ymin = -7, ymax = 2)+
  geom_hline(yintercept = 0)


fig <- ggarrange(gpp1,gpp2,gpp4,er1,er2,er4)

afig <- annotate_figure(fig, bottom = text_grob("Outputs from Strem Metabolizer, with randomized values for initial K600 (range: 0.5-400), burn-in steps (range 100-400), and saved steps (200-600)", color = "blue",
                                                hjust = 0, x = .1, face = "italic", size = 12))


#tiff(here("Analysis/Stream_Metabolism/ModelAnalysis/allStations_GPP_ER.tiff"), width = 14, height = 6, units = 'in', res = 300)
afig # Make plot
dev.off()

# Write files
write.csv(df, here("Analysis/Stream_Metabolism/ModelOutputs/stn1_summary.csv"))
write.csv(df2, here("Analysis/Stream_Metabolism/ModelOutputs/stn2_summary.csv"))
write.csv(df4, here("Analysis/Stream_Metabolism/ModelOutputs/stn4_summary.csv"))
