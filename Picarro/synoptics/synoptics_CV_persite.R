#install.packages("tmaptools")
#install.packages("ggplot2")
#install.packages("here")
#install.packages("dplyr")
#install.packages("plotly")
#install.packages("wesanderson")

library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)
library(viridis)
library(grid)
library(gridExtra)


#read in data for every day 

july18 <- read.csv(here("Picarro/synoptics/071819/sumjuly19_30sec_corrected.csv"))
july31 <- read.csv(here("Picarro/synoptics/073119/sumaug02_30sec_corrected.csv"))
aug06 <- read.csv(here("Picarro/synoptics/080619/sumaug09_30sec_corrected.csv"))
aug12 <- read.csv(here("Picarro/synoptics/081219/sumaug13_30sec_corrected.csv"))

#add day column 
july18$Day <- as.character("July18")
july18$Sample <- as.character(july18$Sample)
july18$Sample[10] <- "syn35"
july31$Day <- as.character("July31")
aug06$Day <- as.character("Aug06")
aug12$Day <- as.character("Aug12")

#put it all together 

sumsynoptics <- rbind(july18, july31, aug06, aug12)

#save this 

write.csv(sumsynoptics, here("Picarro/synoptics/", "sumsynoptics_corrected.csv"))

#select per collar find the syn avg and std deviation, and the coefficient of variation and relative standard deviation 
#save this 

#syn1
syn1 <- sumsynoptics[ which(sumsynoptics$Sample == "syn1"), ]

syn1 <- syn1 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
syn1total <- data.frame("Sample"= "Totalsyn1", "Day" = "total", "CorrectedAverage" = mean(syn1$CorrectedAverage), "StdDev_iCO2" = sd(syn1$CorrectedAverage))
syn1all <- rbind(syn1, syn1total)
syn1all$CV <- syn1all$StdDev_iCO2/syn1all$CorrectedAverage
syn1all$RelativeStdDev <- 100*(syn1all$StdDev_iCO2/abs(syn1all$CorrectedAverage))

write.csv(syn1all, here("Picarro/synoptics/", "syn1CV_statistics.csv"))

#syn5
syn5 <- sumsynoptics[ which(sumsynoptics$Sample == "syn5"), ]

syn5 <- syn5 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
syn5total <- data.frame("Sample"= "Totalsyn5", "Day" = "total", "CorrectedAverage" = mean(syn5$CorrectedAverage), "StdDev_iCO2" = sd(syn5$CorrectedAverage))
syn5all <- rbind(syn5, syn5total)
syn5all$CV <- syn5all$StdDev_iCO2/syn5all$CorrectedAverage
syn5all$RelativeStdDev <- 100*(syn5all$StdDev_iCO2/abs(syn5all$CorrectedAverage))

write.csv(syn5all, here("Picarro/synoptics/", "syn5CV_statistics.csv"))


#syn8 
syn8 <- sumsynoptics[ which(sumsynoptics$Sample == "syn8"), ]

syn8 <- syn8 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
syn8total <- data.frame("Sample"= "Totalsyn8", "Day" = "total", "CorrectedAverage" = mean(syn8$CorrectedAverage), "StdDev_iCO2" = sd(syn8$CorrectedAverage))
syn8all <- rbind(syn8, syn8total)
syn8all$CV <- syn8all$StdDev_iCO2/syn8all$CorrectedAverage
syn8all$RelativeStdDev <- 100*(syn8all$StdDev_iCO2/abs(syn8all$CorrectedAverage))

write.csv(syn8all, here("Picarro/synoptics/", "syn8CV_statistics.csv"))

#syn11

syn11 <- sumsynoptics[ which(sumsynoptics$Sample == "syn11"), ]

syn11 <- syn11 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
syn11total <- data.frame("Sample"= "Totalsyn11", "Day" = "total", "CorrectedAverage" = mean(syn11$CorrectedAverage), "StdDev_iCO2" = sd(syn11$CorrectedAverage))
syn11all <- rbind(syn11, syn11total)
syn11all$CV <- syn11all$StdDev_iCO2/syn11all$CorrectedAverage
syn11all$RelativeStdDev <- 100*(syn11all$StdDev_iCO2/abs(syn11all$CorrectedAverage))

write.csv(syn11all, here("Picarro/synoptics/", "syn11CV_statistics.csv"))

#syn14

syn14 <- sumsynoptics[ which(sumsynoptics$Sample == "syn14"), ]

syn14 <- syn14 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
syn14total <- data.frame("Sample"= "Totalsyn14", "Day" = "total", "CorrectedAverage" = mean(syn14$CorrectedAverage), "StdDev_iCO2" = sd(syn14$CorrectedAverage))
syn14all <- rbind(syn14, syn14total)
syn14all$CV <- syn14all$StdDev_iCO2/syn14all$CorrectedAverage
syn14all$RelativeStdDev <- 100*(syn14all$StdDev_iCO2/abs(syn14all$CorrectedAverage))

write.csv(syn14all, here("Picarro/synoptics/", "syn14CV_statistics.csv"))

#synBW

synBW <- sumsynoptics[ which(sumsynoptics$Sample == "synBW"), ]

synBW <- synBW %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
synBWtotal <- data.frame("Sample"= "TotalsynBW", "Day" = "total", "CorrectedAverage" = mean(synBW$CorrectedAverage), "StdDev_iCO2" = sd(synBW$CorrectedAverage))
synBWall <- rbind(synBW, synBWtotal)
synBWall$CV <- synBWall$StdDev_iCO2/synBWall$CorrectedAverage
synBWall$RelativeStdDev <- 100*(synBWall$StdDev_iCO2/abs(synBWall$CorrectedAverage))

write.csv(synBWall, here("Picarro/synoptics/", "synBWCV_statistics.csv"))


#syn20

syn20 <- sumsynoptics[ which(sumsynoptics$Sample == "syn20"), ]

syn20 <- syn20 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
syn20total <- data.frame("Sample"= "Totalsyn20", "Day" = "total", "CorrectedAverage" = mean(syn20$CorrectedAverage), "StdDev_iCO2" = sd(syn20$CorrectedAverage))
syn20all <- rbind(syn20, syn20total)
syn20all$CV <- syn20all$StdDev_iCO2/syn20all$CorrectedAverage
syn20all$RelativeStdDev <- 100*(syn20all$StdDev_iCO2/abs(syn20all$CorrectedAverage))

write.csv(syn20all, here("Picarro/synoptics/", "syn20CV_statistics.csv"))

#syn23

syn23 <- sumsynoptics[ which(sumsynoptics$Sample == "syn23"), ]

syn23 <- syn23 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
syn23total <- data.frame("Sample"= "Totalsyn23", "Day" = "total", "CorrectedAverage" = mean(syn23$CorrectedAverage), "StdDev_iCO2" = sd(syn23$CorrectedAverage))
syn23all <- rbind(syn23, syn23total)
syn23all$CV <- syn23all$StdDev_iCO2/syn23all$CorrectedAverage
syn23all$RelativeStdDev <- 100*(syn23all$StdDev_iCO2/abs(syn23all$CorrectedAverage))

write.csv(syn23all, here("Picarro/synoptics/", "syn23CV_statistics.csv"))

#syn29

syn29 <- sumsynoptics[ which(sumsynoptics$Sample == "syn29"), ]

syn29 <- syn29 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
syn29total <- data.frame("Sample"= "Totalsyn29", "Day" = "total", "CorrectedAverage" = mean(syn29$CorrectedAverage), "StdDev_iCO2" = sd(syn29$CorrectedAverage))
syn29all <- rbind(syn29, syn29total)
syn29all$CV <- syn29all$StdDev_iCO2/syn29all$CorrectedAverage
syn29all$RelativeStdDev <- 100*(syn29all$StdDev_iCO2/abs(syn29all$CorrectedAverage))

write.csv(syn29all, here("Picarro/synoptics/", "syn29CV_statistics.csv"))

#syn35

syn35 <- sumsynoptics[ which(sumsynoptics$Sample == "syn35"), ]

syn35 <- syn35 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
syn35total <- data.frame("Sample"= "Totalsyn35", "Day" = "total", "CorrectedAverage" = mean(syn35$CorrectedAverage), "StdDev_iCO2" = sd(syn35$CorrectedAverage))
syn35all <- rbind(syn35, syn35total)
syn35all$CV <- syn35all$StdDev_iCO2/syn35all$CorrectedAverage
syn35all$RelativeStdDev <- 100*(syn35all$StdDev_iCO2/abs(syn35all$CorrectedAverage))

write.csv(syn35all, here("Picarro/synoptics/", "syn35CV_statistics.csv"))

#only totals 

syntotals <- rbind(syn1total, syn5total, syn8total, syn11total, syn14total, synBWtotal, syn20total, syn23total, syn29total, syn35total)

#save all data

allsyn <- rbind(syn1all, syn5all, syn8all, syn11all, syn14all, synBWall, syn20all, syn23all, syn29all, syn35all)

write.csv(allsyn, here("Picarro/synoptics", "eachsyn_persite_corrected.csv"))
#save this 

write.csv(syntotals, here("Picarro/synoptics", "allsyn_persiteCV_statscorrected.csv"))

#ok now let's do plots per day with the error bars 

largernumbers <- element_text(face = "bold", size = 12)
largernumbers2 <- element_text(face = "bold", size = 10)

syn1all <- syn1all[c(1:4),]
syn1all$Day[1] <- "1July18"
syn1all$Day[2] <- "2July31"
syn1all$Day[3] <- "3Aug06"
syn1all$Day[4] <- "4Aug12"
plot1 <- ggplot(syn1all, aes(x= Day, y= CorrectedAverage, color=Day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_viridis(option = "D", discrete = TRUE)+
  ggtitle("Syn 1")+
  labs(x="Day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  theme(legend.position = "right", 
        panel.background = element_rect(fill = "#EDCB64"),
        title = largernumbers,
        axis.title.y=element_blank(),
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)),
        plot.margin=unit(c(0,-.25,1,0), "cm"))+
  ylim(-17.5,-10)
plot1 <- plot1 + theme(legend.position = "none")
plot1



syn5all <- syn5all[c(1:4),]
syn5all$Day[1] <- "1July18"
syn5all$Day[2] <- "2July31"
syn5all$Day[3] <- "3Aug06"
syn5all$Day[4] <- "4Aug12"
plot2 <- ggplot(syn5all, aes(x= Day, y= CorrectedAverage, color=Day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_viridis(option = "D", discrete = TRUE)+
  ggtitle("Syn 5")+
  labs(x="Day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  theme(legend.position = "right", 
        panel.background = element_rect(fill = "#EDCB64"),
        axis.title.y=element_blank(),
        title = largernumbers,
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)),
        plot.margin=unit(c(0,-.25,1,0), "cm"))+
  ylim(-17.5,-10)
plot2 <- plot2 + theme(legend.position = "none")
plot2

syn8all <- syn8all[c(1:4),]
syn8all$Day[1] <- "1July18"
syn8all$Day[2] <- "2July31"
syn8all$Day[3] <- "3Aug06"
syn8all$Day[4] <- "4Aug12"
plot3 <- ggplot(syn8all, aes(x= Day, y= CorrectedAverage, color=Day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_viridis(option = "D", discrete = TRUE)+
  ggtitle("Syn 8")+
  labs(x="Day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  theme(legend.position = "right", 
        panel.background = element_rect(fill = "#EDCB64"),
        title = largernumbers,
        axis.title.y=element_blank(),
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)),
        plot.margin=unit(c(0,-.25,1,0), "cm"))+
  ylim(-17.5,-10)
plot3 <- plot3 + theme(legend.position = "none")
plot3


syn11all <- syn11all[c(1:4),]
syn11all$Day[1] <- "1July18"
syn11all$Day[2] <- "2July31"
syn11all$Day[3] <- "3Aug06"
syn11all$Day[4] <- "4Aug12"
plot4 <- ggplot(syn11all, aes(x= Day, y= CorrectedAverage, color=Day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_viridis(option = "D", discrete = TRUE)+
  ggtitle("Syn 11")+
  labs(x="Day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  theme(legend.position = "right", 
        panel.background = element_rect(fill = "#EDCB64"),
        title = largernumbers,
        axis.title.y=element_blank(),
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)),
        plot.margin=unit(c(0,-.25,1,0), "cm"))+
  ylim(-17.5,-10)
plot4 <- plot4 + theme(legend.position = "none")
plot4


syn14all <- syn14all[c(1:4),]
syn14all$Day[1] <- "1July18"
syn14all$Day[2] <- "2July31"
syn14all$Day[3] <- "3Aug06"
syn14all$Day[4] <- "4Aug12"
plot5 <- ggplot(syn14all, aes(x= Day, y= CorrectedAverage, color=Day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_viridis(option = "D", discrete = TRUE)+
  ggtitle("Syn 14")+
  labs(x="Day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  theme(legend.position = "right", 
        panel.background = element_rect(fill = "#EDCB64"),
        title = largernumbers,
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)),
        plot.margin=unit(c(0,-.25,1,0), "cm"))+
  ylim(-17.5,-10)
plot5 <- plot5 + theme(legend.position = "none")
plot5

synBWall <- synBWall[c(1:4),]
synBWall$Day[1] <- "1July18"
synBWall$Day[2] <- "2July31"
synBWall$Day[3] <- "3Aug06"
synBWall$Day[4] <- "4Aug12"
plot6 <- ggplot(synBWall, aes(x= Day, y= CorrectedAverage, color=Day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_viridis(option = "D", discrete = TRUE)+
  ggtitle("Syn BW")+
  labs(x="Day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  theme(legend.position = "right", 
        panel.background = element_rect(fill = "#DAECED"),
        title = largernumbers,
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)),
        plot.margin=unit(c(1,-.25,-.25,0), "cm"),
        axis.title.x=element_blank(),
        axis.text.x=element_blank())+
  ylim(-17.5,-10)
plot6 <- plot6 + theme(legend.position = "none")
plot6


syn20all <- syn20all[c(1:4),]
syn20all$Day[1] <- "1July18"
syn20all$Day[2] <- "2July31"
syn20all$Day[3] <- "3Aug06"
syn20all$Day[4] <- "4Aug12"
plot7 <- ggplot(syn20all, aes(x= Day, y= CorrectedAverage, color=Day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_viridis(option = "D", discrete = TRUE)+
  ggtitle("Syn 20")+
  labs(x="Day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  theme(legend.position = "right", 
        panel.background = element_rect(fill = "#CECD7B"),
        title = largernumbers,
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)),
        plot.margin=unit(c(1,-.25,-.25,0), "cm"),
        axis.title.x=element_blank(),
        axis.text.x=element_blank())+
  ylim(-17.5,-10)
plot7 <- plot7 + theme(legend.position = "none")
plot7

syn23all <- syn23all[c(1:4),]
syn23all$Day[1] <- "1July18"
syn23all$Day[2] <- "2July31"
syn23all$Day[3] <- "3Aug06"
syn23all$Day[4] <- "4Aug12"
plot8 <- ggplot(syn23all, aes(x= Day, y= CorrectedAverage, color=Day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_viridis(option = "D", discrete = TRUE)+
  ggtitle("Syn 23")+
  labs(x="Day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  theme(legend.position = "right", 
        panel.background = element_rect(fill = "#CECD7B"),
        title = largernumbers,
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)),
        plot.margin=unit(c(1,-.25,-.25,0), "cm"),
        axis.title.x=element_blank(),
        axis.text.x=element_blank())+
  ylim(-17.5,-10)
plot8 <- plot8 + theme(legend.position = "none")
plot8

syn29all <- syn29all[c(1:4),]
syn29all$Day[1] <- "1July18"
syn29all$Day[2] <- "2July31"
syn29all$Day[3] <- "3Aug06"
syn29all$Day[4] <- "4Aug12"
plot9 <- ggplot(syn29all, aes(x= Day, y= CorrectedAverage, color=Day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_viridis(option = "D", discrete = TRUE)+
  ggtitle("Syn 29")+
  labs(x="Day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  theme(legend.position = "right", 
        panel.background = element_rect(fill = "#CECD7B"),
        title = largernumbers,
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)),
        plot.margin=unit(c(1,-.25,-.25,0), "cm"),
        axis.title.x=element_blank(),
        axis.text.x=element_blank())+
  ylim(-17.5,-10)
plot9 <- plot9 + theme(legend.position = "none")
plot9

syn35all <- syn35all[c(1:4),]
syn35all$Day[1] <- "1July18"
syn35all$Day[2] <- "2July31"
syn35all$Day[3] <- "3Aug06"
syn35all$Day[4] <- "4Aug12"



plot10 <- ggplot(syn35all, aes(x= Day, y= CorrectedAverage, color=Day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_viridis(option = "D", discrete = TRUE)+
  ggtitle("Syn 35")+
  labs(x="Day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  theme(legend.position = "right", 
        panel.background = element_rect(fill = "#CECD7B"),
        title = largernumbers,
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)),   
        plot.margin=unit(c(1,-.25,-.25,0), "cm"),
        axis.title.x=element_blank(),
        axis.text.x=element_blank())+
  ylim(-17.5,-10)
plot10 <- plot10 + theme(legend.position = "none")
plot10

grid.newpage()
grid.arrange(plot10, plot9, plot8, plot7, plot6, plot5, plot4, plot3, plot2, plot1, nrow=2)
#grid.draw(rbind(ggplotGrob(plot1),ggplotGrob(plot2), ggplotGrob(plot3), ggplotGrob(plot4),ggplotGrob(plot5),ggplotGrob(plot6),ggplotGrob(plot7),ggplotGrob(plot8),ggplotGrob(plot9), ggplotGrob(plot10))) 

