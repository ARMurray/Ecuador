#cleaner code for final figure 7 
library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)
library(viridis)
library(grid)
library(gridExtra)


#read in the data 

col1 <- read.csv(here("Picarro/EOSTransects/col1statistics.csv"))
col2 <- read.csv(here("Picarro/EOSTransects/col2statistics.csv"))
col3 <- read.csv(here("Picarro/EOSTransects/col3statistics.csv"))
col4 <- read.csv(here("Picarro/EOSTransects/col4statistics.csv"))
col5 <- read.csv(here("Picarro/EOSTransects/col5statistics.csv"))
col6 <- read.csv(here("Picarro/EOSTransects/col6statistics.csv"))
col7 <- read.csv(here("Picarro/EOSTransects/col7statistics.csv"))
col8 <- read.csv(here("Picarro/EOSTransects/col8statistics.csv"))

#get just the data we want 

col1 <- col1[c(1:6),]
col2 <- col2[c(1:6),]
col3 <- col3[c(1:6),]
col4 <- col4[c(1:6),]
col5 <- col5[c(1:6),]
col6 <- col6[c(1:6),]
col7 <- col7[c(1:6),]
col8 <- col8[c(1:5),]

#aes

largernumbers <- element_text(face = "bold", size = 18)
largernumbers2 <- element_text(face = "bold", size = 14)


#combine 

allcollar <- rbind(col1,col2,col3,col4,col6,col7,col8)
allcollar <- allcollar[order(allcollar$Sample),]

unsat <- rbind(col1,col2,col3,col4)
unsat <- unsat[order(unsat$Sample),]

sat <- rbind(col6,col7,col8)
sat <- sat[order(sat$Sample),]


#fix for diego new figure 7 (May 3rd)

unsat <- rbind(col1,col2,col3,col4)
unsat <- unsat[order(unsat$day),]

#ok so now we need to isolate per day for unsaturated 

unaug02 <- unsat[c(1:4),]
unaug09 <- unsat[c(5:8),]
unaug13 <- unsat[c(9:12),]
unjuly17 <- unsat[c(13:16),]
unjuly23 <- unsat[c(17:20),]
unjuly30 <- unsat[c(21:24),]


#now we need to calculate mean and std. deviation 

unaug02all <- data.frame("Type"= "unsat", "Day"="aug02",
                          "CorrectedAverage" = mean(unaug02$CorrectedAverage), 
                          "StdDev_iCO2" = sd(unaug02$CorrectedAverage))

unaug09all <- data.frame("Type"= "unsat", "Day"="aug09",
                          "CorrectedAverage" = mean(unaug09$CorrectedAverage), 
                          "StdDev_iCO2" = sd(unaug09$CorrectedAverage))

unaug13all <- data.frame("Type"= "unsat", "Day"="aug13",
                          "CorrectedAverage" = mean(unaug13$CorrectedAverage), 
                          "StdDev_iCO2" = sd(unaug13$CorrectedAverage))


unjuly17all <- data.frame("Type"= "unsat", "Day"="July17",
                        "CorrectedAverage" = mean(unjuly17$CorrectedAverage), 
                        "StdDev_iCO2" = sd(unjuly17$CorrectedAverage))

unjuly23all <- data.frame("Type"= "unsat", "Day"="july23",
                          "CorrectedAverage" = mean(unjuly23$CorrectedAverage), 
                          "StdDev_iCO2" = sd(unjuly23$CorrectedAverage))

unjuly30all <- data.frame("Type"= "unsat", "Day"="july30",
                          "CorrectedAverage" = mean(unjuly30$CorrectedAverage), 
                          "StdDev_iCO2" = sd(unjuly30$CorrectedAverage))


#combine all the unsaturated averages 

newunsat <- rbind(unjuly17all, unjuly23all, unjuly30all, unaug02all, unaug09all, unaug13all)



#ok now let's do the same thing for saturated 

sat <- sat[order(sat$day),]


#ok so now we need to isolate per day for saturated 

sataug02 <- sat[c(1:3),]
sataug09 <- sat[c(4:6),]
sataug13 <- sat[c(7:9),]
satjuly17 <- sat[c(10:11),]
satjuly23 <- sat[c(12:14),]
satjuly30 <- sat[c(15:17),]

#now we need to calculate mean and std. deviation 

sataug02all <- data.frame("Type"= "sat", "Day"="aug02",
                         "CorrectedAverage" = mean(sataug02$CorrectedAverage), 
                         "StdDev_iCO2" = sd(sataug02$CorrectedAverage))

sataug09all <- data.frame("Type"= "sat", "Day"="aug09",
                         "CorrectedAverage" = mean(sataug09$CorrectedAverage), 
                         "StdDev_iCO2" = sd(sataug09$CorrectedAverage))

sataug13all <- data.frame("Type"= "sat", "Day"="aug13",
                         "CorrectedAverage" = mean(sataug13$CorrectedAverage), 
                         "StdDev_iCO2" = sd(sataug13$CorrectedAverage))


satjuly17all <- data.frame("Type"= "sat", "Day"="July17",
                          "CorrectedAverage" = mean(satjuly17$CorrectedAverage), 
                          "StdDev_iCO2" = sd(satjuly17$CorrectedAverage))

satjuly23all <- data.frame("Type"= "sat", "Day"="july23",
                          "CorrectedAverage" = mean(satjuly23$CorrectedAverage), 
                          "StdDev_iCO2" = sd(satjuly23$CorrectedAverage))

satjuly30all <- data.frame("Type"= "sat", "Day"="july30",
                          "CorrectedAverage" = mean(satjuly30$CorrectedAverage), 
                          "StdDev_iCO2" = sd(satjuly30$CorrectedAverage))


#combine all the saturated averages 

newsat <- rbind(satjuly17all, satjuly23all, satjuly30all, sataug02all, sataug09all, sataug13all)


#now combine both 

newtotals <- rbind(newunsat, newsat)


#New Total Plot 

plottotal <- ggplot(newtotals, aes(Day, CorrectedAverage)) +
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), 
                                         ymax=(CorrectedAverage+StdDev_iCO2), shape=Type, color=Type), size = 1) +
  scale_shape_manual(values= c(0,15))+
  scale_color_manual(values= c("#a1ce5a", "#6e8b3d"))+
  theme(legend.position = "right")+
  theme(legend.title=element_blank())
                  
plottotal

plottotal <- plottotal + 
    labs(x="Day",  y=expression(bold(paste(delta^{13}, "C"[s], "[‰]"))))+
    scale_x_discrete(limits = c("July17", "july23", "july30", "aug02", 
                                "aug09", "aug13"),
                     labels = c("July17", "July23", "July30", "Aug02", 
                                "Aug09", "Aug13"))+
    theme_bw()+
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.text.x = largernumbers2, axis.title.x= largernumbers,
          axis.text.y=largernumbers2, axis.title.y= element_blank())
  
  plottotal <- plottotal +  ylim(-18.2,-9)
  plottotal
  
  
#Save this new total plot 
  
#save
g <- grid.arrange(arrangeGrob(ggplotGrob(plotdry2), ggplotGrob(plotwet2)), nrow=1, ncol = 2, widths=c(3,.1)) #generates g
  ggsave(here(file="figure7newsize.pdf"), plottotal, width=15, height=10, units="cm", dpi=200) #saves g
  
g
  
  
  
  
  

#unsaturated plot 


plotdry2 <- ggplot(unsat, mapping=aes(x= day, y= CorrectedAverage)) + 
  geom_pointrange(unsat, mapping=aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), 
                  group=unsat$Sample, size=.7,
                  color="#6e8b3d", 
                  shape=unsat$Sample)+scale_shape_manual(values=c(1,4,6,9)) 

plotdry2 <- plotdry2 + ggtitle("Unsaturated")+
  labs(x="Day",  y=expression(bold(paste(delta^{13}, "C"[s], "[‰]"))))+
  scale_x_discrete(limits = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"),
                   labels = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"))+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.text.x = largernumbers2, axis.title.x=element_blank(),
        axis.text.y=largernumbers2, axis.title.y=element_blank(),plot.title = element_text(margin = margin(t= 10, b = -20), face="bold"))

plotdry2 <- plotdry2 +  ylim(-18.2,-9)
plotdry2


#saturated plot 

plotwet2 <- ggplot(sat, mapping=aes(x= day, y= CorrectedAverage)) + 
  geom_pointrange(sat, mapping=aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), 
                  group=sat$Sample, size=.7, color="#a1ce5a", 
                  shape=sat$Sample)+scale_shape_manual(values=c(16,15,18)) 

plotwet2 <- plotwet2 + ggtitle("Saturated")+
  labs(x="Day", y=expression(bold(paste(delta^{13}, "C"[s], "[‰]"))))+
  scale_x_discrete(limits = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"),
                   labels = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"))+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.text.x = largernumbers2, axis.title.x=largernumbers,
        axis.text.y=largernumbers2, axis.title.y=element_blank(), plot.title = element_text(margin = margin(t= 10, b = -20), face="bold"))

plotwet2 <- plotwet2 +  ylim(-18.2,-9)
plotwet2

grid.arrange(arrangeGrob(rbind(ggplotGrob(plot), ggplotGrob(plot3),
                               ggplotGrob(plot5), ggplotGrob(plot7))), ncol=2, widths= c(3,.1))

g <- grid.arrange(arrangeGrob(ggplotGrob(plotdry2), ggplotGrob(plotwet2)), nrow=1, ncol = 2, widths=c(3,.1))


#titley <- expression(bold(paste(delta^{13}, "C"[s], "[‰]")))



#save
g <- grid.arrange(arrangeGrob(ggplotGrob(plotdry2), ggplotGrob(plotwet2)), nrow=1, ncol = 2, widths=c(3,.1)) #generates g
ggsave(here(file="figure7.pdf"), g, width=30, height=20, units="cm", dpi=200) #saves g

g
