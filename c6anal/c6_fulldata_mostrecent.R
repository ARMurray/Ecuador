library(here)
library(ggplot2)
library(dplyr)
library(viridis)
library(plotly)
library(grid)
library(gridExtra)

### load the giant stream file 

allstream <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))


# Let's move it to only the times the c6 was on

c6time <- allstream[c(3841:6705),]

c6time$DateTime <- as.POSIXct(c6time$DateTime, tryFormats=c("%m/%d/%Y %H:%M"))
#savethis 

write.csv(c6time, here("c6anal/", "alldatac6times.csv"))

c6time <- read.csv(here("c6anal/alldatac6times.csv"))
c6time$DateTime <- as.POSIXct(c6time$DateTime, tryFormats=c("%Y-%m-%d %H:%M:%OS"))

#make a table that excludes the co2 injection entirely 

c6time1 <- c6time[which(c6time$DateTime < "2019-07-16 14:15:00"), ] 
c6time2 <- c6time[which(c6time$DateTime > "2019-07-16 20:00:00"), ] 
c6time <- rbind(c6time1, c6time2)


#basic graph of all four 

#set same x-scale for each 
x_min <- as.POSIXct("2019-07-11 11:45:00")
x_max <- as.POSIXct("2019-07-19 12:59:00")

largernumbers <- element_text(face = "bold", size = 10)
largernumbers3 <- element_text(face = "bold", size = 12)
largernumbers2 <- element_text(size = 8)
largertitle <- element_text(size = 12)

testtitle <- element_text(expression("Flux"~"["~"umol/"~m^2~s^-1~"]"),face ="bold",size=10)
testtitle

#let's make the boxplots for the 2 injections that happened during the c6 time 


CDOMinjpoly2 <- data.frame(x = c(as.POSIXct("2019-07-16 14:15:00"),
                             as.POSIXct("2019-07-16 20:00:00"),
                             as.POSIXct("2019-07-16 20:00:00"),
                             as.POSIXct("2019-07-16 14:15:00")),y=c(15,15,50,50))

turbinjpoly2 <- data.frame(x = c(as.POSIXct("2019-07-16 14:15:00"),
                                 as.POSIXct("2019-07-16 20:00:00"),
                                 as.POSIXct("2019-07-16 20:00:00"),
                                 as.POSIXct("2019-07-16 14:15:00")),y=c(0,0,3000,3000))

chloinjpoly2 <- data.frame(x = c(as.POSIXct("2019-07-16 14:15:00"),
                                 as.POSIXct("2019-07-16 20:00:00"),
                                 as.POSIXct("2019-07-16 20:00:00"),
                                 as.POSIXct("2019-07-16 14:15:00")),y=c(0,0,5,5))

phycoinjpoly2 <- data.frame(x = c(as.POSIXct("2019-07-16 14:15:00"),
                                 as.POSIXct("2019-07-16 20:00:00"),
                                 as.POSIXct("2019-07-16 20:00:00"),
                                 as.POSIXct("2019-07-16 14:15:00")),y=c(0,0,1500,1500))

c2injpoly2 <- data.frame(x = c(as.POSIXct("2019-07-16 14:15:00"),
                                  as.POSIXct("2019-07-16 20:00:00"),
                                  as.POSIXct("2019-07-16 20:00:00"),
                                  as.POSIXct("2019-07-16 14:15:00")),y=c(1000,1000,5000,5000))

fluxinjpoly2 <- data.frame(x = c(as.POSIXct("2019-07-16 14:15:00"),
                               as.POSIXct("2019-07-16 20:00:00"),
                               as.POSIXct("2019-07-16 20:00:00"),
                               as.POSIXct("2019-07-16 14:15:00")),y=c(0,0,4,4))
disinjpoly2 <- data.frame(x = c(as.POSIXct("2019-07-16 14:15:00"),
                                 as.POSIXct("2019-07-16 20:00:00"),
                                 as.POSIXct("2019-07-16 20:00:00"),
                                 as.POSIXct("2019-07-16 14:15:00")),y=c(0,0,325,325))
#do basic plot of each 
plot <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= CDOM_ppb), color= "#27223c")+
  labs(y="CDOM (ppb)", x="")
plot <- plot+ theme(axis.text.y= largernumbers, 
                     axis.title.y= largernumbers2, title = largertitle, 
                     axis.text.x=element_blank(),
                    plot.margin=unit(c(-.25,1,-.25,1), "cm"))
plot
#ggplotly(plot)

plot2 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= Turbidity_NTU), color="#d1362f")+
  labs(y="Turbidity (NTU)", x="")
plot2 <- plot2+ theme(axis.text.y= largernumbers, 
                      axis.title.y= largernumbers2, title = largertitle, 
                      axis.text.x=element_blank(),
                      plot.margin=unit(c(-.25,1,-.25,1), "cm"))
#ggplotly(plot2)

plot3 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= Chlorophylla_ug.L), color="#2e604a")+
  labs(y="Chlorophyll A (ug/l)", x="")
plot3 <- plot3 + theme(axis.text.y= largernumbers, axis.text.x = largernumbers3, axis.title.x = largernumbers,
                       axis.title.y= largernumbers2, 
                       title = largertitle, 
                       plot.margin=unit(c(-.25,1,1,1), "cm"))


#ggplotly(plot3)


#put  them all together 
#grid.newpage()
#grid.draw(rbind(ggplotGrob(plot), ggplotGrob(plot2), ggplotGrob(plot3)))



#ok now let's try to add rainfall to this 


plot5 <- ggplot(c6time)+
  geom_bar(aes(x= DateTime, y = ppt_mm), color = "#1dace8", stat="identity")+
  labs(y="Precip (mm)", x="")+
  ylim(.0001, .8)
plot5 <- plot5+ theme(axis.text.y= largernumbers, 
                      axis.title.y= largernumbers2, title = largertitle, 
                      axis.text.x=element_blank(),
                      plot.margin=unit(c(1,1,-.25,1), "cm"))
plot5 <- plot5 + scale_y_reverse()
#ggplotly(plot5)
plot5

#let's put them all together

#first 5 min rainfall 

#grid.newpage()
#grid.draw(rbind(ggplotGrob(plot5),ggplotGrob(plot), ggplotGrob(plot2), ggplotGrob(plot3)))


#co2 data

plot7 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y = V1), color = "#cecd7b")+
  labs(y=expression(CO["2"]~(ppm)), x="")+
  ylim(900, 5000)
plot7 <-plot7+ theme(axis.text.y= largernumbers, 
                     axis.title.y= largernumbers2, title = largertitle, 
                     axis.text.x=element_blank(),
                     plot.margin=unit(c(-.25,1,-.25,1), "cm"))
plot7
#ggplotly(plot7)


#grid.newpage()
#grid.draw(rbind(ggplotGrob(plot7),ggplotGrob(plot), ggplotGrob(plot2), ggplotGrob(plot3)))  


#now let's do flux 
plot9 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y = Flux_1), color = "#e6a2c5")+
  labs(x="", y=expression(Flux~('umol'/~m^2~s^-1)))
  
plot9 <- plot9+ theme(axis.text.y= largernumbers, 
                      axis.title.y= largernumbers2, title = largertitle, 
                      axis.text.x=element_blank(),
                      plot.margin=unit(c(-.25,1,-.25,1), "cm"))
plot9
ggplotly(plot9)

#grid.newpage()
#grid.draw(rbind(ggplotGrob(plot9),ggplotGrob(plot), ggplotGrob(plot2), ggplotGrob(plot3), ggplotGrob(plot4)))  

# now let's add discharge 


plot11 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y = stn1_Q), color = "#76a08a")+
  labs(x="", y=expression(Discharge~(L~s^-1)))
  plot11 <- plot11+ theme(axis.text.y= largernumbers, 
                          axis.title.y= largernumbers2, title = largertitle, 
                          axis.text.x=element_blank(),
                          plot.margin=unit(c(-.25,1,-.25,1), "cm"))

plot11
ggplotly(plot11)


plot12 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= DO1_mg.L), color= "#27223c")+
  labs(y="DO mg/L", x="")
plot12 <- plot12+ theme(axis.text.y= largernumbers, 
                    axis.text.x=element_blank(),
                    plot.margin=unit(c(-.25,1,-.25,1), "cm"))

plot12


plot13 <- ggplot(allstream)+
  geom_point(aes(x= DateTime, y= EC4_uS), color= "#27223c")+
  ggtitle("EC Station 1")+
  labs(y="EC uS", x="")

#ggplotly(plot)


#Stacked panel with the following in this order 
# 5 min invereted precip, discharge, CDOM, chlorophyll, turbidity, flux, station 1 co2 


#Unit in brackets on y axis 
#Larger labels on x and y 

grid.newpage()
grid.draw(rbind(ggplotGrob(plot5),ggplotGrob(plot11), ggplotGrob(plot7), ggplotGrob(plot9),
                ggplotGrob(plot), ggplotGrob(plot2), ggplotGrob(plot12), ggplotGrob(plot3)))  

grid.newpage()
grid.draw(rbind(ggplotGrob(plot5),ggplotGrob(plot11)))


#attempting to combine plot 5 and plot 11

testplot <- c6time %>% ggplot()+
  geom_bar(aes(x= DateTime, y = ppt_mm), color = "#1dace8", stat="identity")+
  labs(y="Precip (mm)", x="")+
  ylim(.0001, .8)
testplot <- testplot +  
  geom_point(aes(x= DateTime, y = stn1_Q * .8/.06), color = "#76a08a")
testplot 

min(c6time$stn1_Q)

testplot3 <- testplot + scale_y_continuous(
  name = expression(bold("Precip [mm]")), 
  sec.axis = sec_axis(~ . *.06/.8,name = expression(bold("Discharge"~"["~m^3~s^-1~"]"))),
  limits = c(0, .8))+
  theme(axis.title.y=element_text(face="bold"))


testplot3 <- testplot3 + theme_bw() + 
  theme(axis.title.x=element_blank(),axis.text.x = largernumbers,axis.text.y= largernumbers,
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())
testplot3

 

grid.newpage()
grid.draw(rbind(ggplotGrob(testplot3), ggplotGrob(plot7), ggplotGrob(plot9),
                ggplotGrob(plot), ggplotGrob(plot2), ggplotGrob(plot12), ggplotGrob(plot3)))  

#combine co2 and flux 

combo <- c6time %>% ggplot()+
  geom_point(aes(x= DateTime, y = Flux_1), color = "#1C366B")+
  ylim(0, 4.1)
combo <- combo + 
  geom_point(aes(x= DateTime, y = V1 * 4.1/4200), color = "#cecd7b")
combo 

combo2 <- combo + scale_y_continuous(
  name = expression(bold("Evasion"~"[""umol/"~m^2"s"~])), 
  sec.axis = sec_axis(~ . * 4200 / 4.1 , name = expression(bold("pCO"["2"]~"[ppm]"))), 
  limits = c(0, 4.1))
 

combo2 <- combo2 + theme_bw() + 
  theme(axis.title.x=element_blank(),axis.text.x = largernumbers,axis.text.y= largernumbers,
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())

combo2

grid.newpage()
grid.draw(rbind(ggplotGrob(testplot3), ggplotGrob(combo2),
                ggplotGrob(plot), ggplotGrob(plot2), ggplotGrob(plot12), ggplotGrob(plot3)))


#combine turbidity and CDOM 

#turbidity = plot2 
#CDOM = plot
#ok learned from above need to do the one that starts at 0 first, so need to do turbidity first 
#max of turbidity is 3000
#max of CDOM is 50 


cute <- c6time %>% ggplot()+
  geom_point(aes(x= DateTime, y= Turbidity_NTU), color="#d1362f")+
  ylim(0, 3000)
cute <- cute + 
  geom_point(aes(x= DateTime, y= CDOM_ppb * 3000/50), color= "#27223c")
cute


cute2 <- cute + scale_y_continuous(
  name = expression(bold("Turbidity [NTU]")), 
  sec.axis = sec_axis(~ . * 50 / 3000 , name = expression(bold("CDOM [ppb]"))), 
  limits = c(0, 3000))

cute2
cute2 <- cute2 + theme_bw() + 
  theme(axis.title.x=element_blank(),axis.text.x = largernumbers,axis.text.y= largernumbers,
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())


cute2
  
grid.newpage()
grid.draw(rbind(ggplotGrob(testplot3), ggplotGrob(combo2),
                ggplotGrob(cute2), ggplotGrob(plot12), ggplotGrob(plot3)))


#combine DO and chlorophyll 
#ok so need to try to do DO and then chlorophyll
#DO = plot 12
#chloro = plot3
# DO max = 7.5 
#chloro max 4.5

bob <- c6time %>% ggplot()+
  geom_point(aes(x= DateTime, y= DO1_mg.L), color= "#FFA500")+
  ylim(0, 7.5)
bob <- bob + 
  geom_point(aes(x= DateTime, y= Chlorophylla_ug.L * 7.5/4.5), color="#2e604a")
bob

bob2 <- bob + scale_y_continuous(
  name = expression(bold("DO [mg/L]")), 
  sec.axis = sec_axis(~ . * 4.5 / 7.5 , name = expression(bold("Chlorophyll A [ug/l]"))), 
  limits = c(0, 7.5))

bob2

bob2 <- bob2 + theme_bw() + 
  theme(axis.title.x=element_blank(),axis.text.x = largernumbers,axis.text.y= largernumbers,
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())

bob2

grid.newpage()
grid.draw(rbind(ggplotGrob(testplot3), ggplotGrob(combo2),
                ggplotGrob(cute2), ggplotGrob(bob2)))




