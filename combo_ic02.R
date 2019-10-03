library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)
library(viridis)

sumaug13 <- read.csv(here("Picarro/EOSTransects/081319/sumaug13.csv"))
sumjuly17 <- read.csv(here("Picarro/EOSTransects/071619/sumjuly17.csv"))
sumjuly23 <- read.csv(here("Picarro/EOSTransects/072219/sumjuly23.csv"))
sumjuly30 <- read.csv(here("Picarro/EOSTransects/072919/sumjuly30.csv"))
sumaug02 <- read.csv(here("Picarro/EOSTransects/080119/sumaug02.csv"))
sumaug09 <- read.csv(here("Picarro/EOSTransects/080819/sumaug09.csv"))

sumaug13$day <- as.character("Aug13")
sumjuly17$day <- as.character("July17")
sumjuly23$day <- as.character("July23")
sumjuly30$day <- as.character("July30")
sumaug02$day <- as.character("Aug02")
sumaug09$day <- as.character("Aug09")

sumalltransects <- rbind(sumaug13, sumjuly17, sumjuly23, sumjuly30, sumaug02, sumaug09)

#Do an final plot of Delta_i 
plot <- ggplot(sumaug13)+
  geom_point(aes(x= Sample, y= Avg_iCO2)) +
  labs(x = "Collar", y = "Delta_Avg") +
  ggtitle("EOS Transect Pulls") 

#try doing it all together instead 

pbetter2 <- ggplot(sumalltransects, aes(x= Sample, y= Avg_iCO2, color=day))+
  geom_point(size=4)+
  xlab('Collar') +
  ylab('Delta_Avg') +
  ggtitle("EOS Delta i_Co2 Summary") +
  scale_color_manual(values=wes_palette("Zissou1", n=6, type = c("continuous")))+
  theme(legend.position = "right")
pbetter2


#longer way 

p <- ggplot() + 
  geom_point(data = sumaug13, aes(x = Sample, y = Avg_iCO2), color='day') +
  geom_point(data = sumjuly17, aes(x = Sample, y = Avg_iCO2), c) +
  geom_point(data = sumjuly23, aes(x = Sample, y = Avg_iCO2)) +
  geom_point(data = sumjuly30, aes(x = Sample, y = Avg_iCO2)) +
  geom_point(data = sumaug02, aes(x = Sample, y = Avg_iCO2)) +
  geom_point(data = sumaug09, aes(x = Sample, y = Avg_iCO2)) +
  xlab('Collar') +
  ylab('Delta_Avg') +
   ggtitle("EOS Delta i_Co2 Summary") +
   scale_color_viridis(discrete = TRUE, option = "D")+
   theme(legend.position = "right")
p


plot
ggplotly()
