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


#savethis 

write.csv(c6time, here("c6anal/", "alldatac6times.csv"))


#basic graph of all four 

#set same x-scale for each 
x_min <- as.POSIXct("2019-07-11 11:45:00")
x_max <- as.POSIXct("2019-07-19 12:59:00")

largernumbers <- element_text(face = "bold", size = 20)

#do basic plot of each 
plot <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= CDOM_ppb), color= "#27223c")
#plot <- plot + scale_x_continuous(limits=c(x_min, x_max))
plot <- plot + theme(axis.text.y= largernumbers)
ggplotly(plot)

plot2 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= Turbidity_NTU), color="#d1362f")
#plot2 <- plot2 + scale_x_continuous(limits=c(x_min, x_max))
plot2 <- plot2 +theme(axis.text.y= largernumbers)

ggplotly(plot2)

plot3 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= Chlorophylla_ug.L), color="#2e604a")
#plot3 <- plot3 + scale_x_continuous(limits=c(x_min, x_max))
plot3 <- plot3 + theme(axis.text.y= largernumbers)

ggplotly(plot3)

plot4 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= Phycocyanin_ppb), color="#dbb165")
#plot4 <- plot4 + scale_x_continuous(limits=c(x_min, x_max))
plot4 <- plot4 + theme(axis.text.y= largernumbers)

ggplotly(plot4)


#put  them all together 
grid.newpage()
grid.draw(rbind(ggplotGrob(plot), ggplotGrob(plot2), ggplotGrob(plot3), ggplotGrob(plot4)))


pbetter2 <- ggplot(sumalltransects, aes(x= Sample, y= CorrectedAverage, color=day))+
  geom_point(size=8)+
  xlab('Collar') +
  ylab('Delta30_Avg') +
  ggtitle("EOS Delta30 i_CO2 Corrected Summary") +
  scale_color_manual(values=wes_palette("Zissou1", n=6, type = c("continuous")))+
  theme(legend.position = "right")
pbetter2