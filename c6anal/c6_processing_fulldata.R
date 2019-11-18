library(here)
library(ggplot2)
library(dplyr)
library(viridis)
library(plotly)

install.packages("grid")

### load the giant stream file 

allstream <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))



# Let's move it to only the times the c6 was on

c6time <- allstream[c(3022:6705),]


#savethis 

write.csv(c6time, here("c6anal/", "alldatac6times.csv"))


#basic graph of all four 

plot <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= CDOM_ppb), color="blue")
ggplotly(plot)

plot2 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= Turbidity_NTU), color="red")
ggplotly(plot2)

plot3 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= Chlorophylla_ug.L), color="green")
ggplotly(plot3)

plot4 <- ggplot(c6time)+
  geom_point(aes(x= DateTime, y= Phycocyanin_ppb), color="purple")
ggplotly(plot4)



pbetter2 <- ggplot(sumalltransects, aes(x= Sample, y= CorrectedAverage, color=day))+
  geom_point(size=8)+
  xlab('Collar') +
  ylab('Delta30_Avg') +
  ggtitle("EOS Delta30 i_CO2 Corrected Summary") +
  scale_color_manual(values=wes_palette("Zissou1", n=6, type = c("continuous")))+
  theme(legend.position = "right")
pbetter2