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

largernumbers <- element_text(face = "bold", size = 14)
largernumbers2 <- element_text(face = "bold", size = 12)


#combine 

allcollar <- rbind(col1,col2,col3,col4,col6,col7,col8)
allcollar <- allcollar[order(allcollar$Sample),]

unsat <- rbind(col1,col2,col3,col4)
unsat <- unsat[order(unsat$Sample),]

sat <- rbind(col6,col7,col8)
sat <- sat[order(sat$Sample),]

#unsaturated plot 


plotdry2 <- ggplot(unsat, mapping=aes(x= day, y= CorrectedAverage)) + 
  geom_pointrange(unsat, mapping=aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), group=unsat$Sample, size=.7, color="#6e8b3d", 
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
  geom_pointrange(sat, mapping=aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), group=sat$Sample, size=.7, color="#a1ce5a", 
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
