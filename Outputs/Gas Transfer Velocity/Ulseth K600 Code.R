library(tidyverse)
library(ggplot2)
library(dplyr)
library(pracma)
library(plotly)
library(scales)

#Opening Ulseth Supplementary
Ulseth<-read.csv("C)
:/Users/nehemiah/Desktop/Ecuador/Outputs/Gas Transfer Velocity/Ulseth Supplementary Info.csv")

K600vsVPlot<-ggplot(Ulseth)+
  geom_point(aes(x = Ulseth$Vms,y = Ulseth$k600, colour = data))+
  scale_colour_manual(values = c("#59c76a","#6b9aae","#39c7e3","#c238c7","#c72e78","#dedb37"))+
  scale_x_continuous(name="Velocity(m/s)")+
  scale_y_continuous(name="K600(m/Day)")+
  scale_y_continuous(trans = log10_trans(),
                     breaks = trans_breaks("log10", function(x) 10^x),
                     labels = trans_format("log10", math_format(10^.x)))+
  scale_x_continuous(trans=log10_trans(),
                     breaks = trans_breaks("log10", function(y) 10^y))
                     labels = trans_format("log10", math_format(10^.y)))
  
K600vsVPlot

##Plotting as Log Y- Axis
LogK600<-K600vsVPlot+
      scale_y_continuous(Trans= log10_trans())
LogK600
ggplotly(K600vsVPlot)

K600vsSlopePlot<-ggplot(Ulseth)+geom_point(aes(Ulseth$slope,Ulseth$k600))
K600vsSlopePlot
