library(here)
library(ggplot2)
library(dplyr)
library(viridis)
library(plotly)
library(grid)

### load the giant stream file 

allstream <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))



# Let's move it to only the times the c6 was on

c6time <- allstream[c(3022:6705),]

c6time$DateTime <- as.POSIXct(c6time$DateTime)
#savethis 

write.csv(c6time, here("c6anal/", "alldatac6times.csv"))


#basic graph of all four 

#set same x-scale for each 
x_min <- as.POSIXct("2019-07-11 11:45:00")
x_max <- as.POSIXct("2019-07-19 12:59:00")

largernumbers <- element_text(face = "bold", size = 14)

#do basic plot of each 
plot <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= CDOM_ppb), color= "#27223c", size=5)+
  ggtitle("Colored Dissolved Organic Matter")
plot <- plot + theme(axis.text.y= largernumbers)
ggplotly(plot)

plot2 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= Turbidity_NTU), color="#d1362f")+
  ggtitle("Turbidity")
plot2 <- plot2 +theme(axis.text.y= largernumbers, plot.title =largernumbers)

ggplotly(plot2)

plot3 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= Chlorophylla_ug.L), color="#2e604a")+
  ggtitle("Chlorophyll A")
plot3 <- plot3 + theme(axis.text.y= largernumbers)

ggplotly(plot3)

plot4 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= Phycocyanin_ppb), color="#dbb165")+
  ggtitle("Phycocyanin")
plot4 <- plot4 + theme(axis.text.y= largernumbers)

ggplotly(plot4)


#put  them all together 
grid.newpage()
grid.draw(rbind(ggplotGrob(plot), ggplotGrob(plot2), ggplotGrob(plot3), ggplotGrob(plot4)))



#ok now let's try to add rainfall to this 


plot5 <- ggplot(c6time)+
  geom_bar(aes(x= DateTime, y = ppt_mm), color = "#1dace8", stat="identity")+
  ggtitle("Five Minute Precipitation")
plot5 <- plot5 + theme(axis.text.y= largernumbers)
ggplotly(plot5)


plot6 <- ggplot(c6time)+
  geom_bar(aes(x= DateTime, y = ppt24Tot), color = "#1dace8", stat="identity")+
  ggtitle("Previous 24 Hours of Precipitation")
plot6 <- plot6 + theme(axis.text.y= largernumbers)
ggplotly(plot6)


#let's put them all together

#first 5 min rainfall 

grid.newpage()
grid.draw(rbind(ggplotGrob(plot5),ggplotGrob(plot), ggplotGrob(plot2), ggplotGrob(plot3), ggplotGrob(plot4)))



#then 24 hour rainfall

grid.newpage()
grid.draw(rbind(ggplotGrob(plot6),ggplotGrob(plot), ggplotGrob(plot2), ggplotGrob(plot3), ggplotGrob(plot4)))           


# Alright now let's try to roll in c02 data 

x_min <- as.POSIXct("2019-07-12 13:00:00")
x_max <- as.POSIXct("2019-07-12 16:00:00")

#plot7 <- ggplot(c6time)+
 # geom_rect(aes(xmin= as.POSIXct(x_min), xmax= as.POSIXct(x_max), ymin=0, ymax=4500), fill ="#a35e60")+
  #geom_point(aes(x= DateTime, y = V1), color = "#cecd7b")+
 # geom_point(aes(x= DateTime, y = V2), color = "#1dace8")+
 # ggtitle("Station 1 and 2 CO2")
#plot7 <- plot7 + theme(axis.text.y= largernumbers)
#ggplotly(plot7)

injpoly <- data.frame(x = c(as.POSIXct("06:15", format = "%H:%M"),as.POSIXct("18:21", format = "%H:%M"),as.POSIXct("18:21", format = "%H:%M"),as.POSIXct("06:15", format = "%H:%M")),y=c(-3200,-3200,-100,-100))


plot7 <- ggplot(c6time)+
  geom_polygon(data = injpoly,aes(x=x,y=y),fill="#f2e198")+
  geom_point(aes(x= DateTime, y = V1), color = "#cecd7b")+
  geom_point(aes(x= DateTime, y = V2), color = "#1dace8")+
  ggtitle("Station 1 and 2 CO2")
plot7 <- plot7 + theme(axis.text.y= largernumbers)
plot7


#plot8 <- ggplot(c6time)+
 # geom_point(aes(x= DateTime, y = V2), color = "#cecd7b")+
  #ggtitle("Station 2 CO2")
#plot8 <- plot8 + theme(axis.text.y= largernumbers)
#ggplotly(plot8)

grid.newpage()
grid.draw(rbind(ggplotGrob(plot7),ggplotGrob(plot), ggplotGrob(plot2), ggplotGrob(plot3), ggplotGrob(plot4)))  


#now let's do flux 
plot9 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y = Flux_1), color = "#e6a2c5")+
  ggtitle("Flux Between Station 1 and 2")
plot9 <- plot9+ theme(axis.text.y= largernumbers)
ggplotly(plot9)

grid.newpage()
grid.draw(rbind(ggplotGrob(plot9),ggplotGrob(plot), ggplotGrob(plot2), ggplotGrob(plot3), ggplotGrob(plot4)))  





