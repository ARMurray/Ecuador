library(tidyverse)
library(plotly)
library(lubridate)
library(ggpubr)
library(here)

#############
# STATION 1 #
#############


stn1Files <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn1_outputs"), pattern = "Predictions",recursive = TRUE,full.names = TRUE)[1:500]
stn1Stats <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn1_outputs"), pattern = "Specs",recursive = TRUE,full.names = TRUE)[1:500]


df <- data.frame()
for(n in 1:length(stn1Files)){
  preds <- read.csv(stn1Files[n])
  specs <- read.csv(stn1Stats[n])
  newdf <- data.frame("dateTime"=preds$date,"GPP"=preds$GPP,"ER"=preds$ER,
                      "K600_init"=as.numeric(as.character(specs[31,3])),
                      "burnin"=as.numeric(as.character(specs[27,3])),
                      "Saved"=as.numeric(as.character(specs[28,3])),
                      "ID" = substr(stn1Files[n],98,109))
  df <- rbind(df,newdf)
}

df$dateTime <- ymd(df$dateTime)

df1 <- df%>%
  select(dateTime,GPP,ER,ID)%>%
  pivot_longer(cols = c("GPP","ER"), names_to = "type")%>%
  mutate(group = paste0(type,ID))


# Station 1
p1 <- ggplot(df1)+
  geom_line(aes(x=dateTime,y=value, group = group, color = type),alpha = 0.1)+
  labs(x = "", y = bquote('['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 1")+
  geom_hline(yintercept = 0)+
  scale_color_manual(values = c("#4287f5","#00cc33"))+
  guides(color = guide_legend(override.aes = list(size = 5, alpha = 1)))+
  theme(legend.title = element_blank(),
        plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  ylim(-7,2.5)


#############
# STATION 2 #
#############

stn2Files <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn2_outputs"), pattern = "Predictions",recursive = TRUE,full.names = TRUE)[1:500]
stn2Stats <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn2_outputs"), pattern = "Specs",recursive = TRUE,full.names = TRUE)[1:500]


df2 <- data.frame()
for(n in 1:length(stn2Files)){
  preds <- read.csv(stn2Files[n])
  specs <- read.csv(stn2Stats[n])
  newdf <- data.frame("dateTime"=preds$date,"GPP"=preds$GPP,"ER"=preds$ER,
                      "K600_init"=as.numeric(as.character(specs[31,3])),
                      "burnin"=as.numeric(as.character(specs[27,3])),
                      "Saved"=as.numeric(as.character(specs[28,3])),
                      "ID" = substr(stn2Files[n],98,109))
  df2 <- rbind(df2,newdf)
}

df2$dateTime <- ymd(df2$dateTime)

df2 <- df2%>%
  select(dateTime,GPP,ER,ID)%>%
  pivot_longer(cols = c("GPP","ER"), names_to = "type")%>%
  mutate(group = paste0(type,ID))

p2 <- ggplot(df2)+
  geom_line(aes(x=dateTime,y=value, group = group, color = type),alpha = 0.1)+
  labs(x = "", y = bquote('['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 2")+
  geom_hline(yintercept = 0)+
  scale_color_manual(values = c("#4287f5","#00cc33"))+
  guides(color = guide_legend(override.aes = list(size = 5, alpha = 1)))+
  theme(legend.title = element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  ylim(-7,2.5)

#############
# STATION 4 #
#############

stn4Files <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn4_outputs"), pattern = "Predictions",recursive = TRUE,full.names = TRUE)[1:500]
stn4Stats <- list.files(here("Analysis/Stream_Metabolism/ModelOutputs/stn4_outputs"), pattern = "Specs",recursive = TRUE,full.names = TRUE)[1:500]


df4 <- data.frame()
for(n in 1:length(stn4Files)){
  preds <- read.csv(stn4Files[n])
  specs <- read.csv(stn4Stats[n])
  newdf <- data.frame("dateTime"=preds$date,"GPP"=preds$GPP,"ER"=preds$ER,
                      "K600_init"=as.numeric(as.character(specs[31,3])),
                      "burnin"=as.numeric(as.character(specs[27,3])),
                      "Saved"=as.numeric(as.character(specs[28,3])),
                      "ID" = substr(stn4Files[n],98,109))
  df4 <- rbind(df4,newdf)
}

df4$dateTime <- ymd(df4$dateTime)

df4 <- df4%>%
  select(dateTime,GPP,ER,ID)%>%
  pivot_longer(cols = c("GPP","ER"), names_to = "type")%>%
  mutate(group = paste0(type,ID))

p4 <- ggplot(df4)+
  geom_line(aes(x=dateTime,y=value, group = group, color = type),alpha = 0.1)+
  labs(x = "", y = bquote('['*g~ O[2]~ m^-2~d^-1*']'), title = "Station 4")+
  geom_hline(yintercept = 0)+
  scale_color_manual(values = c("#4287f5","#00cc33"))+
  guides(color = guide_legend(override.aes = list(size = 5, alpha = 1)))+
  theme(legend.title = element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  ylim(-7,2.5)


fig <- ggarrange(p1,p2,p4,nrow = 1, common.legend = TRUE)
fig

#afig <- annotate_figure(fig, bottom = text_grob("Outputs from Strem Metabolizer, with randomized values for initial K600 (range: 0.5-400), burn-in steps (range 100-400), and saved steps (200-600)", color = "blue",
#                                                hjust = 0, x = .1, face = "italic", size = 12))


#cowplot::plot_grid(p1,p2,p4, align = "v", nrow = 1, rel_heights = c(0.25, 0.75))
#egg::ggarrange(gpp1, er1, heights = c(0.5, 0.5))

tiff(here("Articles/StreamFluxArticle/figures/metabolism.tiff"), width = 7, height = 6, units = 'in', res = 600)
fig # Make plot
dev.off()

