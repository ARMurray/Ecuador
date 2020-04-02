library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)
library(viridis)
library(grid)
library(gridExtra)

#load everything in 

sumaug13 <- read.csv(here("Picarro/EOSTransects/081319/sumaug13_30sec_corrected.csv"))
sumjuly17 <- read.csv(here("Picarro/EOSTransects/071619/sumjuly17_30sec_corrected.csv"))
sumjuly23 <- read.csv(here("Picarro/EOSTransects/072219/sumjuly23_30sec_corrected.csv"))
sumjuly30 <- read.csv(here("Picarro/EOSTransects/072919/sumjuly30_30sec_corrected.csv"))
sumaug02 <- read.csv(here("Picarro/EOSTransects/080119/sumaug02_30sec_corrected.csv"))
sumaug09 <- read.csv(here("Picarro/EOSTransects/080819/sumaug09_30sec_corrected_1aug09.csv"))

sumaug13$day <- as.character("Aug13")
sumjuly17$day <- as.character("July17")
sumjuly23$day <- as.character("July23")
sumjuly30$day <- as.character("July30")
sumaug02$day <- as.character("Aug02")
sumaug09$day <- as.character("Aug09")

sumalltransects <- rbind(sumaug13, sumjuly17, sumjuly23, sumjuly30, sumaug02, sumaug09)

#make a dataframe for each individual collar, find the collar avg and std deviation, and the coefficient of variation and relative standard deviation 
#save this 


col1 <- sumalltransects[ which(sumalltransects$Sample == "col1"), ]
col1 <- col1 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col1total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col1$CorrectedAverage), "StdDev_iCO2" = sd(col1$CorrectedAverage))
col1 <- rbind(col1, col1total)
col1$CV <- col1$StdDev_iCO2/col1$CorrectedAverage
col1$RelativeStdDev <- 100*(col1$StdDev_iCO2/abs(col1$CorrectedAverage))

write.csv(col1, here("Picarro/EOSTransects/", "col1statistics.csv"))

col2 <- sumalltransects[ which(sumalltransects$Sample == "col2"), ]

col2 <- col2 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col2total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col2$CorrectedAverage), "StdDev_iCO2" = sd(col2$CorrectedAverage))
col2 <- rbind(col2, col2total)
col2$CV <- col2$StdDev_iCO2/col2$CorrectedAverage
col2$RelativeStdDev <- 100*(col2$StdDev_iCO2/abs(col2$CorrectedAverage))

write.csv(col2, here("Picarro/EOSTransects/", "col2statistics.csv"))

col3 <- sumalltransects[ which(sumalltransects$Sample == "col3"), ]

col3 <- col3 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col3total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col3$CorrectedAverage), "StdDev_iCO2" = sd(col3$CorrectedAverage))
col3 <- rbind(col3, col3total)
col3$CV <- col3$StdDev_iCO2/col3$CorrectedAverage
col3$RelativeStdDev <- 100*(col3$StdDev_iCO2/abs(col3$CorrectedAverage))

write.csv(col3, here("Picarro/EOSTransects/", "col3statistics.csv"))

col4 <- sumalltransects[ which(sumalltransects$Sample == "col4"), ]

col4 <- col4 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col4total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col4$CorrectedAverage), "StdDev_iCO2" = sd(col4$CorrectedAverage))
col4 <- rbind(col4, col4total)
col4$CV <- col4$StdDev_iCO2/col4$CorrectedAverage
col4$RelativeStdDev <- 100*(col4$StdDev_iCO2/abs(col4$CorrectedAverage))

write.csv(col4, here("Picarro/EOSTransects/", "col4statistics.csv"))

col5 <- sumalltransects[ which(sumalltransects$Sample == "col5"), ]

col5 <- col5 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col5total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col5$CorrectedAverage), "StdDev_iCO2" = sd(col5$CorrectedAverage))
col5 <- rbind(col5, col5total)
col5$CV <- col5$StdDev_iCO2/col5$CorrectedAverage
col5$RelativeStdDev <- 100*(col5$StdDev_iCO2/abs(col5$CorrectedAverage))

write.csv(col5, here("Picarro/EOSTransects/", "col5statistics.csv"))

col6 <- sumalltransects[ which(sumalltransects$Sample == "col6"), ]

col6 <- col6 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col6total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col6$CorrectedAverage), "StdDev_iCO2" = sd(col6$CorrectedAverage))
col6 <- rbind(col6, col6total)
col6$CV <- col6$StdDev_iCO2/col6$CorrectedAverage
col6$RelativeStdDev <- 100*(col6$StdDev_iCO2/abs(col6$CorrectedAverage))

write.csv(col6, here("Picarro/EOSTransects/", "col6statistics.csv"))

col7 <- sumalltransects[ which(sumalltransects$Sample == "col7"), ]

col7 <- col7 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col7total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col7$CorrectedAverage), "StdDev_iCO2" = sd(col7$CorrectedAverage))
col7 <- rbind(col7, col7total)
col7$CV <- col7$StdDev_iCO2/col7$CorrectedAverage
col7$RelativeStdDev <- 100*(col7$StdDev_iCO2/abs(col7$CorrectedAverage))

write.csv(col7, here("Picarro/EOSTransects/", "col7statistics.csv"))

col8 <- sumalltransects[ which(sumalltransects$Sample == "col8"), ]

col8 <- col8 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col8total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col8$CorrectedAverage), "StdDev_iCO2" = sd(col8$CorrectedAverage))
col8 <- rbind(col8, col8total)
col8$CV <- col8$StdDev_iCO2/col8$CorrectedAverage
col8$RelativeStdDev <- 100*(col8$StdDev_iCO2/abs(col8$CorrectedAverage))

write.csv(col8, here("Picarro/EOSTransects/", "col8statistics.csv"))


#ok now let's make a table that just has the totals for every collar 

col1total <- col1[ which(col1$Sample == "Total"), ]
col1total$Sample <- as.character("col1")
col2total <- col2[ which(col2$Sample == "Total"), ]
col2total$Sample <- as.character("col2")
col3total <- col3[ which(col3$Sample == "Total"), ]
col3total$Sample <- as.character("col3")
col4total <- col4[ which(col4$Sample == "Total"), ]
col4total$Sample <- as.character("col4")
col5total <- col5[ which(col5$Sample == "Total"), ]
col5total$Sample <- as.character("col5")
col6total <- col6[ which(col6$Sample == "Total"), ]
col6total$Sample <- as.character("col6")
col7total <- col7[ which(col7$Sample == "Total"), ]
col7total$Sample <- as.character("col7")
col8total <- col8[ which(col8$Sample == "Total"), ]
col8total$Sample <- as.character("col8")

allcollarCV <- rbind(col1total, col2total ,col3total, col4total, col5total, col6total, col7total, col8total)

write.csv(allcollarCV, here("Picarro/EOSTransects/" , "allcollarstatistics.csv"))


#alright the easy thing to do from here is the per collar, so let's start that
#the datafram col# is the one we need 
#alright first we need to take the total off of each 
col1 <- col1[c(1:6),]
col2 <- col2[c(1:6),]
col3 <- col3[c(1:6),]
col4 <- col4[c(1:6),]
col5 <- col5[c(1:6),]
col6 <- col6[c(1:6),]
col7 <- col7[c(1:6),]
col8 <- col8[c(1:5),]


#plotting time 

#make a legend function

get_legend<-function(myggplot){
  tmp <- ggplot_gtable(ggplot_build(myggplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}

largernumbers <- element_text(face = "bold", size = 14)
largernumbers2 <- element_text(face = "bold", size = 12)



#collar 1 
plot1 <- ggplot(col1, aes(x= day, y= CorrectedAverage, color=day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_manual(values = wes_palette("Zissou1", 6, type = "continuous"))+
  ggtitle("Collar 1")+
  labs(x="day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  scale_x_discrete(limits = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"),
                   labels = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"))+
  theme(legend.position = "none",
        axis.title.y=element_blank(),
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        panel.background = element_rect(fill = "#f2977c"),
        plot.title = element_text(margin = margin(t= 10, b = -20)))+
  ylim(-18.2,-9)

plot1



#collar 2 
plot2 <- ggplot(col2, aes(x= day, y= CorrectedAverage, color=day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_manual(values = wes_palette("Zissou1", 6, type = "continuous"))+
  ggtitle("Collar 2")+
  labs(x="day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  scale_x_discrete(limits = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"),
                   labels = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"))+
  theme(legend.position = "none",
        axis.title.y=element_blank(),
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        panel.background = element_rect(fill = "#faab86"),
        plot.title = element_text(margin = margin(t= 10, b = -20)))+
  ylim(-18.2,-9)
plot2



#collar 3
plot3 <- ggplot(col3, aes(x= day, y= CorrectedAverage, color=day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_manual(values = wes_palette("Zissou1", 6, type = "continuous"))+
  ggtitle("Collar 3")+
  labs(x="day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  scale_x_discrete(limits = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"),
                   labels = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"))+
  theme(legend.position = "none",
        axis.title.y=element_blank(),
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        panel.background = element_rect(fill = "#b6d6db"),
        plot.title = element_text(margin = margin(t= 10, b = -20)))+
  ylim(-18.2,-9)
plot3


#collar 4
plot4 <- ggplot(col4, aes(x= day, y= CorrectedAverage, color=day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_manual(values = wes_palette("Zissou1", 6, type = "continuous"))+
  ggtitle("Collar 4")+
  labs(x="day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  scale_x_discrete(limits = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"),
                   labels = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"))+
  theme(legend.position = "none",
        axis.title.y=element_blank(),
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        panel.background = element_rect(fill = "#7bccdb"),
        plot.title = element_text(margin = margin(t= 10, b = -20)))+
  ylim(-18.2,-9)

plot4

#collar 5
plot5 <- ggplot(col5, aes(x= day, y= CorrectedAverage, color=day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_manual(values = wes_palette("Zissou1", 6, type = "continuous"))+
  ggtitle("Collar 5")+
  labs(x="day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  scale_x_discrete(limits = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"),
                   labels = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"))+
  theme(legend.position = "none",
        axis.title.y=element_blank(),
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        panel.background = element_rect(fill = "#7bccdb"),
        plot.title = element_text(margin = margin(t= 10, b = -20)))+
  ylim(-18.2,-9)
plot5

#collar 6 
plot6 <- ggplot(col6, aes(x= day, y= CorrectedAverage, color=day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_manual(values = wes_palette("Zissou1", 6, type = "continuous"))+
  ggtitle("Collar 6")+
  labs(x="day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  scale_x_discrete(limits = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"),
                   labels = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"))+
  theme(legend.position = "none",
        axis.title.y=element_blank(),
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        panel.background = element_rect(fill = "#b6d6db"),
        plot.title = element_text(margin = margin(t= 10, b = -20)))+
  ylim(-18.2,-9)
plot6

#collar 7
plot7 <- ggplot(col7, aes(x= day, y= CorrectedAverage, color=day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_manual(values = wes_palette("Zissou1", 6, type = "continuous"))+
  ggtitle("Collar 7")+
  labs(x="day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  scale_x_discrete(limits = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"),
                   labels = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"))+
  theme(legend.position = "none",
        axis.title.y=element_blank(),
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        panel.background = element_rect(fill = "#faab86"),
        plot.title = element_text(margin = margin(t= 10, b = -20)))+
  ylim(-18.2,-9)
plot7

#collar 8 
plot8 <- ggplot(col8, aes(x= day, y= CorrectedAverage, color=day)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_manual(values=c("#2d88a4", "#58a2b5", "#b0bb4e", "#e69200", "#ef0000"))+
  ggtitle("Collar 8")+
  labs(x="day", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  scale_x_discrete(limits = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"),
                   labels = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"))+
  theme(legend.position = "none",
        axis.title.y=element_blank(),
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        panel.background = element_rect(fill = "#f2977c"),
        plot.title = element_text(margin = margin(t= 10, b = -20)))+
  ylim(-18.2,-9)
plot8


#orange - #de7f00, #e69200
#red #ef0000
#darker blue #2d88a4
#light blue #58a2b5
#green #b0bb4e


#initial try of them going together 

grid.arrange(arrangeGrob(plot8,plot7,plot6,plot5,plot1,plot2,plot3,plot4, nrow=2),
             ncol=2, widths = c(2.8, .4))

grid.arrange(arrangeGrob(plot8,plot7,plot6,plot5,plot1,plot2,plot3,plot4))

grid.newpage()
grid.draw(rbind(plot8,plot7,plot6,plot5,plot1,plot2,plot3,plot4))
 
# need to do dry --> wet color scheme col 5 most blue. col 1 and 8 most dry 


#ok, here's what we want now, we want collars 8,7,1,2 on the same plot 
#this is unsaturated 


plot7.2 <- ggplot(col7, mapping=aes(x= day, y= CorrectedAverage)) + 
  geom_pointrange(col7, mapping=aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=.7, color="#6e8b3d", shape=1)


plot7.2 <- plot7.2 + geom_point(col8, mapping=aes(x= day, y= CorrectedAverage)) + 
  geom_pointrange(col8, mapping=aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=.7, color="#6e8b3d", shape=4)

plotdry <- plot7.2 + geom_point(col1, mapping=aes(x= day, y= CorrectedAverage)) + 
  geom_pointrange(col1, mapping =aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=.7, color = "#6e8b3d", shape=6) 


plotdry  

plotdry <- plotdry + geom_point(col2, mapping=aes(x= day, y= CorrectedAverage)) + 
  geom_pointrange(col2, mapping=aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=.7, color ="#6e8b3d", shape=9) 
  
  
  
plotdry <- plotdry + ggtitle("Unsaturated")+
  labs(x="Day", y=expression(bold(paste(delta^{13}, "C", "F"[AQ], "[%]"))))+
  scale_x_discrete(limits = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"),
                   labels = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"))+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.text.x = largernumbers2, axis.title.x=element_blank(),
        axis.text.y=largernumbers2, axis.title.y=element_blank(), plot.title = element_text(margin = margin(t= 10, b = -20), face="bold"))


        
plotdry <- plotdry +  ylim(-18.2,-9)
        
plotdry

#saturated 
#we need plots 3,4,5,6

largernumbers <- element_text(face = "bold", size = 10)


plotwet <- ggplot(col3, mapping=aes(x= day, y= CorrectedAverage)) + 
  geom_pointrange(col3, mapping=aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=.7, color="#a1ce5a", shape=16)


plotwet <- plotwet + geom_point(col4, mapping=aes(x= day, y= CorrectedAverage)) + 
  geom_pointrange(col4, mapping=aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=.7, color="#a1ce5a", shape=15)


#plotwet <- plotwet + geom_point(col5, mapping=aes(x= day, y= CorrectedAverage)) + 
 # geom_pointrange(col5, mapping=aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=.7, color="#a1ce5a", shape=17)
  
plotwet <- plotwet + geom_point(col6, mapping=aes(x= day, y= CorrectedAverage)) + 
  geom_pointrange(col6, mapping=aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=.7, color="#a1ce5a", shape=18)
  

plotwet

plotwet <- plotwet + ggtitle("Saturated")+
  labs(x="Day", y=expression(bold(paste(delta^{13}, "C", "F"[AQ], "[%]"))))+
  scale_x_discrete(limits = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"),
                   labels = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"))+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.text.x = largernumbers2, axis.title.x=element_blank(),
        axis.text.y=largernumbers2, axis.title.y=element_blank(),plot.title = element_text(margin = margin(t= 10, b = -20), face="bold"))


plotwet <- plotwet +  ylim(-18.2,-9)
plotwet




grid.arrange(arrangeGrob(plotdry, plotwet, nrow=2), ncol = 1)
             


unsat <- unsat[order(unsat$Sample),]

plotwet2 <- ggplot(unsat, mapping=aes(x= day, y= CorrectedAverage)) + 
  geom_pointrange(unsat, mapping=aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), group=unsat$Sample, size=.7, color="#a1ce5a", 
                  shape=unsat$Sample)+scale_shape_manual(values=c(16,15,18))
plotwet2


plotwet2 <- plotwet2 + ggtitle("Saturated")+
  labs(x="Day", y=expression(bold(paste(delta^{13}, "C", "F"[AQ], "[%]"))))+
  scale_x_discrete(limits = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"),
                   labels = c("July17", "July23", "July30", "Aug02", 
                              "Aug09", "Aug13"))+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.text.x = largernumbers2, axis.title.x=element_blank(),
        axis.text.y=largernumbers2, axis.title.y=element_blank(),plot.title = element_text(margin = margin(t= 10, b = -20), face="bold"))+
 


plotwet2 <- plotwet2 +  ylim(-18.2,-9)
plotwet2







#getting .csv for diego to run tests 

allcollar <- rbind(col1,col2,col3,col4,col6,col7,col8)

allcollar <- allcollar[order(allcollar$day),]

write.csv(allcollar, here("Picarro/EOSTransects/" , "allcollarfordiego.csv"))

#now let's make a data from with just the unsaturated and saturated average for each day 

#table of unsaturated 

unsat <- rbind(col1,col2,col7,col8)
unsat <- unsat[order(unsat$day),]

sat <- rbind(col3,col4,col6)
sat <- sat[order(sat$day),]

Aug02 <- data.frame("Sample"= "unsaturated", "day"="Aug02", "Average"= 
                         mean(unsat$CorrectedAverage
                              [which(unsat$day == "Aug02")]), "Std_Dev" =  sd(unsat$CorrectedAverage
                                                                              [which(unsat$day == "Aug02")]))
Aug02$Sample <- as.character(Aug02$Sample)
Aug02 <- rbind(Aug02,list("saturated","Aug02",mean(sat$CorrectedAverage
                                                   [which(sat$day == "Aug02")]), sd(sat$CorrectedAverage
                                                                                    [which(sat$day == "Aug02")])))


Aug09 <- data.frame("Sample"= "unsaturated", "day"="Aug09", "Average"= 
                      mean(unsat$CorrectedAverage
                           [which(unsat$day == "Aug09")]), "Std_Dev" =  sd(unsat$CorrectedAverage
                                                                           [which(unsat$day == "Aug09")]))
Aug09$Sample <- as.character(Aug09$Sample)
Aug09 <- rbind(Aug09,list("saturated","Aug09",mean(sat$CorrectedAverage
                                                   [which(sat$day == "Aug09")]), sd(sat$CorrectedAverage
                                                                                    [which(sat$day == "Aug09")])))
Aug13 <- data.frame("Sample"= "unsaturated", "day"="Aug13", "Average"= 
                      mean(unsat$CorrectedAverage
                           [which(unsat$day == "Aug13")]), "Std_Dev" =  sd(unsat$CorrectedAverage
                                                                           [which(unsat$day == "Aug13")]))
Aug13$Sample <- as.character(Aug13$Sample)
Aug13 <- rbind(Aug13,list("saturated","Aug13",mean(sat$CorrectedAverage
                                                   [which(sat$day == "Aug13")]), sd(sat$CorrectedAverage
                                                                                    [which(sat$day == "Aug13")])))

July17 <- data.frame("Sample"= "unsaturated", "day"="July17", "Average"= 
                      mean(unsat$CorrectedAverage
                           [which(unsat$day == "July17")]), "Std_Dev" =  sd(unsat$CorrectedAverage
                                                                           [which(unsat$day == "July17")]))
July17$Sample <- as.character(July17$Sample)
July17 <- rbind(July17,list("saturated","July17",mean(sat$CorrectedAverage
                                                   [which(sat$day == "July17")]), sd(sat$CorrectedAverage
                                                                                    [which(sat$day == "July17")])))



July23 <- data.frame("Sample"= "unsaturated", "day"="July23", "Average"= 
                      mean(unsat$CorrectedAverage
                           [which(unsat$day == "July23")]), "Std_Dev" =  sd(unsat$CorrectedAverage
                                                                           [which(unsat$day == "July23")]))
July23$Sample <- as.character(July23$Sample)
July23 <- rbind(July23,list("saturated","July23",mean(sat$CorrectedAverage
                                                   [which(sat$day == "July23")]), sd(sat$CorrectedAverage
                                                                                    [which(sat$day == "July23")])))

July30 <- data.frame("Sample"= "unsaturated", "day"="July30", "Average"= 
                      mean(unsat$CorrectedAverage
                           [which(unsat$day == "July30")]), "Std_Dev" =  sd(unsat$CorrectedAverage
                                                                           [which(unsat$day == "July30")]))
July30$Sample <- as.character(July30$Sample)
July30 <- rbind(July30,list("saturated","July30",mean(sat$CorrectedAverage
                                                   [which(sat$day == "July30")]), sd(sat$CorrectedAverage
                                                                                    [which(sat$day == "July30")])))

satunsatsummary <- rbind(July17, July23, July30,Aug02,Aug09,Aug13)

write.csv(satunsatsummary, here("Picarro/EOSTransects/" , "satunsatsummary_perday.csv"))









