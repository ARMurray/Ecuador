library(here)
library(dplyr)
library(ggplot2)
library(plotly)
library(ggpubr)
library(grid)
library(gridExtra)

VD1 <- read.csv(here("Vaisala_Maribel/V1_V2_071219.csv"))
VD1$Time <- format(as.POSIXct(VD1$`DateTime`, "%m/%d/%Y %H:%M", tz = ""), format = "%H:%M")
VD1$Date <- format(as.Date(VD1$`DateTime`,"%m/%d/%Y"), format = "%d/%m/%Y")


plot2 <- ggplot(VD1) +
  geom_point(aes(x= V1, y= V2, group= DateTime), size = 2)+
  labs(x=expression(bold(pCO["2"]~"[ppm]")), y = expression(bold(pCO["2"]~"[ppm]"))) +
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"),
        plot.title = element_text(margin = margin(t= 10,b=-20)))+
  geom_abline(intercept = 0) +
  ggtitle("20m Separation")+
    theme(plot.title = element_text(face="bold"))+
  xlim(550, 3500) +
  ylim(550, 3500) +
  theme(panel.border = element_rect(fill=NA, colour = "black", size=1.5))

plot2


VD2 <- read.csv(here::here("Vaisala_Maribel/V1_V3_071219.csv"))
VD2$Time <- format(as.POSIXct(VD2$`DateTime`, "%m/%d/%Y %H:%M", tz = ""), format = "%H:%M")
VD2$Date <- format(as.Date(VD2$`DateTime`,"%m/%d/%Y"), format = "%d/%m/%Y")

plot3 <- ggplot(VD2) +
  geom_point(aes(x= V1, y= V3, group= DateTime), size = 2)+
  labs(x=expression(bold(pCO["2"]~"[ppm]")), y = expression(bold(pCO["2"]~"[ppm]"))) +
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"),
        plot.title = element_text(margin = margin(t= 10,b=-20)))+
  geom_abline(intercept = 0) +
  ggtitle("50m Separation")+
  theme(plot.title = element_text(face="bold"))+
  xlim(550, 3500) +
  ylim(550, 3500) +
  theme(panel.border = element_rect(fill=NA, colour = "black", size=1.5))

plot3

VD3 <- read.csv(here::here("Vaisala_Maribel/V1_V4_071219.csv"))
VD2$Time <- format(as.POSIXct(VD2$`DateTime`, "%m/%d/%Y %H:%M", tz = ""), format = "%H:%M")
VD2$Date <- format(as.Date(VD2$`DateTime`,"%m/%d/%Y"), format = "%d/%m/%Y")

plot4 <- ggplot(VD3) +
  geom_point(aes(x= V1, y= V4, group= DateTime), size = 2)+
  labs(x=expression(bold(pCO["2"]~"[ppm]")), y = expression(bold(pCO["2"]~"[ppm]"))) +
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"),
        plot.title = element_text(margin = margin(t= 10,b=-20)))+
  geom_abline(intercept = 0) +
  ggtitle("134m Separation")+
  theme(plot.title = element_text(face="bold")) +
  xlim(550, 3500) +
  ylim(550, 3500) +
  theme(panel.border = element_rect(fill=NA, colour = "black", size=1.5))
plot4

grid.arrange(arrangeGrob(plot2,plot3,plot4, ncol = 3),ncol=2, widths=c(10,.1), nrow=2)