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


#make a legend function

get_legend<-function(myggplot){
  tmp <- ggplot_gtable(ggplot_build(myggplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}

dis35 <- 0 

dis29 <- 37.4 

dis23 <- 75.9 

dis20 <- 94.1 

waterfalldis <- 124.2 

dis14 <- 143.7 

dis11 <- 170.0 

dis8 <- 194.9 

dis5 <- 217.6 

dis1<- 245.2 


dis <- data.frame(Distance = c(dis1, dis5, dis8, dis11, dis14, waterfalldis, dis20, dis23, dis29, dis35)) 

rownames(dis) <- c("syn1", "syn5", "syn8", "syn11", "syn14", "synBW", "syn20", "syn23", "syn29", "syn34") 

dis2 <- data.frame(Distance = c(dis1, dis5, dis8, dis11, dis14, waterfalldis, dis20, dis23, dis29))

rownames(dis2) <- c("syn1", "syn5", "syn8", "syn11", "syn14", "synBW", "syn20", "syn23", "syn29") 

#read in data for every day 

july18 <- read.csv(here("Picarro/synoptics/071819/sumjuly19_30sec_corrected.csv"))
july31 <- read.csv(here("Picarro/synoptics/073119/sumaug02_30sec_corrected.csv"))
aug06 <- read.csv(here("Picarro/synoptics/080619/sumaug09_30sec_corrected.csv"))
aug12 <- read.csv(here("Picarro/synoptics/081219/sumaug13_30sec_corrected.csv"))

#add day column 
july18$Day <- as.character("July18")
july31$Day <- as.character("July31")
aug06$Day <- as.character("Aug06")
aug12$Day <- as.character("Aug12")

#put it all together 

sumsynoptics <- rbind(july18, july31, aug06, aug12)

#save this 

#write.csv(sumsynoptics, here("Picarro/synoptics/", "sumsynoptics_corrected.csv"))

#select just what we need,  find the syn avg and std deviation, and the coefficient of variation and relative standard deviation 
#save this 

july18 <- july18 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
july18total <- data.frame("Sample"= "Total", "Day" = "total", "CorrectedAverage" = mean(july18$CorrectedAverage), "StdDev_iCO2" = sd(july18$CorrectedAverage))
july18all <- rbind(july18, july18total)
july18all$CV <- july18all$StdDev_iCO2/july18all$CorrectedAverage
july18all$RelativeStdDev <- 100*(july18all$StdDev_iCO2/abs(july18all$CorrectedAverage))

#write.csv(july18all, here("Picarro/synoptics/071819", "july18CV_statistics.csv"))

test <- read.csv(here("Picarro/synoptics/sumsynoptics_corrected.csv"))

july31 <- july31 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
july31total <- data.frame("Sample"= "Total", "Day" = "total", "CorrectedAverage" = mean(july31$CorrectedAverage), "StdDev_iCO2" = sd(july31$CorrectedAverage))
july31all <- rbind(july31, july31total)
july31all$CV <- july31all$StdDev_iCO2/july31all$CorrectedAverage
july31all$RelativeStdDev <- 100*(july31all$StdDev_iCO2/abs(july31all$CorrectedAverage))

#write.csv(july31all, here("Picarro/synoptics/073119", "july31CV_statistics.csv"))


aug06 <- aug06 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
aug06total <- data.frame("Sample"= "Total", "Day" = "total", "CorrectedAverage" = mean(aug06$CorrectedAverage), "StdDev_iCO2" = sd(aug06$CorrectedAverage))
aug06all <- rbind(aug06, aug06total)
aug06all$CV <- aug06all$StdDev_iCO2/aug06all$CorrectedAverage
aug06all$RelativeStdDev <- 100*(aug06all$StdDev_iCO2/abs(aug06all$CorrectedAverage))

#write.csv(aug06all, here("Picarro/synoptics/080619", "aug06CV_statistics.csv"))

aug12 <- aug12 %>%
  select(Sample, Day, CorrectedAverage, StdDev_iCO2)
aug12total <- data.frame("Sample"= "Total", "Day" = "total", "CorrectedAverage" = mean(aug12$CorrectedAverage), "StdDev_iCO2" = sd(aug12$CorrectedAverage))
aug12all <- rbind(aug12, aug12total)
aug12all$CV <- aug12all$StdDev_iCO2/aug12all$CorrectedAverage
aug12all$RelativeStdDev <- 100*(aug12all$StdDev_iCO2/abs(aug12all$CorrectedAverage))

#write.csv(aug12all, here("Picarro/synoptics/081219", "aug12CV_statistics.csv"))

#alright now let's combine these all together 

allsynCV <- rbind(july18all, july31all, aug06all, aug12all)

check <- read.csv(here("Picarro/synoptics/allsynCV_statscorrected.csv"))

max(check$CorrectedAverage)
min(check$CorrectedAverage)

#save this 

#write.csv(allsynCV, here("Picarro/synoptics", "allsynCV_statscorrected.csv"))

#ok now let's do plots per day with the error bars using the corrected distance 


waterfallpoly <- data.frame(x = c(as.numeric("122"),
                                  as.numeric("124"),
                                  as.numeric("124"),
                                  as.numeric("122")),y=c(-16,-16,-12,-12))

july18all <- july18all[c(1:10),]
july18all <- cbind(july18all, dis)

#version with waterfall 
plot <- ggplot(july18all, aes(x= Distance, y= CorrectedAverage)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=.5,  color="#CC7987") +
  #scale_color_viridis(option = "B", discrete = TRUE)+
  ggtitle("July 18th")+
  labs(x="Distance from Wetland [m]", y=expression(bold(paste(delta^{13}, "C", "F"[AQ], "[%]"))))+
  theme_bw() + 
  theme(legend.position = "right", axis.text.y = element_text(size=12, face="bold"), axis.text.x= element_blank(), 
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)))+
  ylim(-17,-10.5)+
  xlim(0,250)
  #geom_polygon(data = waterfallpoly,aes(x=x,y=y),fill="#1dace8", alpha = .5)
plot

#w/o waterfall
plot2 <- ggplot(july18all, aes(x= Distance, y= CorrectedAverage, color=Sample)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_viridis(option = "B", discrete = TRUE)+
  ggtitle("July 18th")+
  labs(x="Distance from Wetland (m)", y="Delta_i")+
  theme(legend.position = "none",
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)),
        axis.title.y=element_blank())+
  xlim(0,250)+
  ylim(-18,-10)
  
plot2



july31all <- july31all[c(1:10),]
july31all <- cbind(july31all, dis)

#version with waterfall 
plot3 <- ggplot(july31all, aes(x= Distance, y= CorrectedAverage)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=.5, color="blue") +
  #scale_color_viridis(option = "B", discrete = TRUE)+
  ggtitle("July 31th")+
  labs(x="Distance from Wetland [m]", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  theme_bw() + 
  theme(legend.position = "right", axis.text.y = element_text(size=12, face="bold"), axis.text.x= element_blank(), 
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)))+
  ylim(-17,-10.5)+
  xlim(0,250)
  #geom_polygon(data = waterfallpoly,aes(x=x,y=y),fill="#1dace8", alpha = .5)
plot3

#w/o waterfall
plot4 <- ggplot(july31all, aes(x= Distance, y= CorrectedAverage, color=Sample)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_viridis(option = "B", discrete = TRUE)+
  ggtitle("July 31th")+
  labs(x="Distance from Wetland (m)", y="Delta_i")+
  theme(legend.position = "none",
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)),
        axis.title.y=element_blank())+
  xlim(0,250)+
  ylim(-18,-10)

plot4


aug06all <- aug06all[c(1:9),]
aug06all <- cbind(aug06all, dis2)

#version with waterfall 
plot5 <- ggplot(aug06all, aes(x= Distance, y= CorrectedAverage)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=.5, color = '#D55E00') +
  #scale_color_viridis(option = "B", discrete = TRUE)+
  ggtitle("August 6th")+
  labs(x="Distance from Wetland [m]", y=expression(bold(paste(delta^{13}, "C", "F"[AQ], "[%]"))))+
  theme_bw() + 
  theme(legend.position = "right", axis.text.y = element_text(size=12,face="bold"), axis.text.x= element_blank(), 
        axis.title.x=element_blank(),
        axis.title.y= element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)))+
  ylim(-17,-10.5)+
  xlim(0,250)
  #geom_polygon(data = waterfallpoly,aes(x=x,y=y),fill="#1dace8", alpha = .5)+

plot5

#w/o waterfall
plot6 <- ggplot(aug06all, aes(x= Distance, y= CorrectedAverage, color=Sample)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_viridis(option = "B", discrete = TRUE)+
  ggtitle("August 6th")+
  labs(x="Distance from Wetland (m)", y="Delta_i")+
  theme(legend.position = "none",
        axis.text.x =element_blank(),
        axis.title.x=element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)),
        axis.title.y=element_blank())+
  xlim(0,250)+
  ylim(-18,-10)

plot6


aug12all <- aug12all[c(1:10),]
aug12all <- cbind(aug12all, dis)

#version with waterfall 
plot7 <- ggplot(aug12all, aes(x= Distance, y= CorrectedAverage)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=.5, color= '#009E73') +
  #scale_color_viridis(option = "B", discrete = TRUE)+
  ggtitle("August 12th")+
  labs(x="Distance from Wetland [m]", y=expression(paste(delta^{13}, "C", "F"[AQ], "[%]")))+
  theme_bw() + 
  theme(legend.position = "right", axis.text.y = element_text(size=12, face="bold"), axis.text.x= element_text(size=12, face = "bold"),
        axis.title.x= (element_text(face="bold", size=14)),
        axis.title.y = element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        plot.title = element_text(margin = margin(t= 10, b = -20)))+
  ylim(-17,-10.5)+
  xlim(0,250)
  #geom_polygon(data = waterfallpoly,aes(x=x,y=y),fill="#1dace8", alpha = .5)
plot7

largernumbers <- element_text(size = 14)

#w/o waterfall
plot8 <- ggplot(aug12all, aes(x= Distance, y= CorrectedAverage, color=Sample)) + 
  geom_pointrange(aes(ymin= (CorrectedAverage-StdDev_iCO2), ymax=CorrectedAverage+StdDev_iCO2), size=2) +
  scale_color_viridis(option = "B", discrete = TRUE)+
  ggtitle("August 12th")+
  labs(x="Distance from Wetland (m)", y="Delta_i")+
  theme(legend.position = "none",
        plot.title = element_text(margin = margin(t= 10, b = -20)),
        axis.title.y=element_blank(),
        axis.title.x=largernumbers)+
  xlim(0,250)+
  ylim(-18,-10)

plot8

legend <- get_legend(plot8)

#grid.newpage()
#grid.draw(rbind(ggplotGrob(plot2),ggplotGrob(plot4), ggplotGrob(plot6), ggplotGrob(plot8))) 

#grid.arrange(plot2, plot4, plot6, plot8, legend, nrow=4, ncol=2)

#grid.arrange(arrangeGrob(plot2, plot4, plot6, plot8, nrow=4), legend, ncol = 2, 
             widths = c(2.8, .4))


#grid.arrange(arrangeGrob(plot2, plot4, plot6, plot8, nrow=4), ncol = 2, 
             widths = c(2.8, .4))

label <- as.expression(expression(bold(paste(delta^{13}, "C", "F"[AQ], "[%]"))))

grid.arrange(arrangeGrob(plot, plot3, plot5, plot7, nrow=4),
             left=bquote(paste(delta^{13}, "C", "F"[AQ], "[%]")))

grid.newpage()
grid.arrange(rbind(ggplotGrob(plot), ggplotGrob(plot3),
                ggplotGrob(plot5), ggplotGrob(plot7)), left="test")


grid.arrange(arrangeGrob(rbind(ggplotGrob(plot), ggplotGrob(plot3),
                   ggplotGrob(plot5), ggplotGrob(plot7))), ncol=2, widths= c(3,.1))





#save
g <- arrangeGrob(rbind(ggplotGrob(plot), ggplotGrob(plot3),
                       ggplotGrob(plot5), ggplotGrob(plot7)), ncol=2, widths= c(3,.1)) #generates g
ggsave(here(file="figure6.pdf"), g, width=30, height=20, units="cm", dpi=200) #saves g




plot
plot3
plot5
plot7

