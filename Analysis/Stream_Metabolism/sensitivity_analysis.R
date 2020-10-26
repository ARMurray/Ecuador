library(tidyverse)
library(lubridate)
library(ggpubr)
library(here)
library(imputeTS)
library(cowplot)

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
#write.csv(df, here("Analysis/Stream_Metabolism/ModelOutputs/stn1_summary.csv"))
#write.csv(df2, here("Analysis/Stream_Metabolism/ModelOutputs/stn2_summary.csv"))
#write.csv(df4, here("Analysis/Stream_Metabolism/ModelOutputs/stn4_summary.csv"))


# TRY ADDING DISCHARGE


stream <- read.csv("data_4_analysis/All_Stream_Data.csv")

q <- stream%>%
  select(DateTime, stn1_Q)%>%
  drop_na()%>%
  mutate(day = lubridate::date(DateTime))%>%
  group_by(day)%>%
  mutate(meanQ = mean(stn1_Q))%>%
  ungroup()%>%
  select(day,meanQ)%>%
  distinct()


# Create points for daily measured Flux
flux <- stream%>%
  filter(Inj.x == "No")%>%
  select(DateTime,Flux_1)%>%
  drop_na()%>%
  mutate(DateTime = lubridate::ymd_hms(DateTime))

## Impute missing values for every second of every day and then sum to get total flux each day.
timestep <- hms("01:02:01")-hms("01:02:00")
dailyFlux <- data.frame(time=seq.POSIXt(flux$DateTime[1], flux$DateTime[length(flux$DateTime)], by=timestep))%>%
  left_join(flux, by = c("time"="DateTime"))%>%
  na_interpolation(option = 'linear', maxgap = Inf)%>%
  mutate(date = lubridate::date(time))%>%
  group_by(date)%>%
  mutate(dielFluxUmol = sum(Flux_1))%>%
  ungroup()%>%
  select(date,dielFluxUmol)%>%
  distinct()%>%
  mutate(gCO2day = dielFluxUmol* (44.01/1000000))   ## Convert to mass

### Add in precipitation to the figures
ppt <- read.csv(here("data_4_analysis/ppt.csv"))%>%
  mutate(DateTime = lubridate::ymd(DateTime))

temp <- read.csv(here("data_4_analysis/airTemp_5min.csv"))%>%
  mutate(DateTime = lubridate::mdy_hm(DateTime),
         Day = lubridate::date(DateTime))%>%
  group_by(Day)%>%
  mutate(Daily_High = max(airTemp_c))%>%
  ungroup()%>%
  select(Day, Daily_High)%>%
  distinct()

## COMBINED PLOTS

# RELATED VARIABLES
var <- ggplot()+
  geom_line(data = q, aes(x = day, y =meanQ), col = "purple", size=1)+
  geom_line(data = temp, aes(x=Day,y=Daily_High/150), col = "#eb4034", linetype = "dashed",size=1)+
  geom_segment(data = ppt, aes(x=DateTime,xend = DateTime, y = .075-(ppt_mm/700), yend = .075, group = DateTime), col = "#42aec9", size = 3, alpha = .7)+
  geom_hline(yintercept = 0)+
  xlim(xmin = lubridate::ymd("2019-07-12"), xmax = lubridate::ymd("2019-08-15"))+
  scale_y_continuous(sec.axis = sec_axis( trans=~.*150, name="Max Daily Temp [C]"))+
  labs(x = "", y = bquote('Discharge ['*m^-3~s^-1*']'), title = "")
  

var  
  

# GPP with ppt
gppdf <- rbind(df,df2)

gpp <- ggplot()+
  geom_line(data = df, aes(x= dateTime, y=GPP, group = ID),alpha = 0.1,size = 2, col = '#e0b43a')+
  geom_line(data = df2, aes(x= dateTime, y=GPP, group = ID),alpha = 0.1,size = 2, col = '#64ab5b')+
  labs(x = "", y = bquote('GPP ['*g~ O[2]~ m^-2~d^-1*']'), title = "Gross Primary Productivity")+
  geom_hline(yintercept = 0)+
  xlim(xmin = lubridate::ymd("2019-07-12"), xmax = lubridate::ymd("2019-08-15"))+
  ylim(ymin = 0, ymax = 7)

#gpp


# ER
er <- ggplot()+
  geom_line(data = df, aes(x= dateTime, y=ER, group = ID),alpha = 0.1,size = 2, col = '#e0b43a')+
  geom_line(data = df2, aes(x= dateTime, y=ER, group = ID),alpha = 0.1,size = 2, col = '#64ab5b')+
  labs(x = "", y = bquote('ER ['*g~ O[2]~ m^-2~d^-1*']'), title = "Respiration")+
  geom_hline(yintercept = 0)+
  xlim(xmin = lubridate::ymd("2019-07-12"), xmax = lubridate::ymd("2019-08-15"))+
  ylim(ymin = -7, ymax=0)

ggarrange(var,gpp,er, nrow = 3)



# Combined GPP and ER
both <- ggplot()+
  geom_line(data = df, aes(x= dateTime, y=GPP*(-1), group = ID),alpha = 0.1,size = 2, col = '#e0b43a')+
  geom_line(data = df2, aes(x= dateTime, y=GPP*(-1), group = ID),alpha = 0.1,size = 2, col = '#64ab5b')+
  geom_line(data = df, aes(x= dateTime, y=ER*(-1), group = ID),alpha = 0.1,size = 2, col = '#e0b43a')+
  geom_line(data = df2, aes(x= dateTime, y=ER*(-1), group = ID),alpha = 0.1,size = 2, col = '#64ab5b')+
  #geom_path(data = dailyFlux, aes(x = date, y = gCO2day),size = 2, col = "#3483eb")+
  labs(x = "", y = bquote(''*g~ CO[2]~ m^-2~d^-1*''), title = "")+
  geom_hline(yintercept = 0)+
  geom_text(aes(x=ymd("20190722"), y = 2, label = paste0("Ecosystem Respiration")), size = 5)+
  geom_text(aes(x=ymd("20190724"), y = -2.5, label = paste0("Gross Primary Productivity")), size = 5)+
  #geom_text(aes(x=ymd("20190804"), y = 8.5, label = paste0("Evasion")), size = 5)+
  xlim(xmin = lubridate::ymd("2019-07-12"), xmax = lubridate::ymd("2019-08-15"))+
  ylim(ymin = -4, ymax = 11)
both

ggarrange(var,both,nrow=2)

cowplot::plot_grid(var,both,nrow = 2, align = "h")

library(grid)
grid.newpage()
grid.draw(rbind(ggplotGrob(var), ggplotGrob(both), size = "first"))
