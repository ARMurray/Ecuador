library(here)
library(ggplot2)
library(dplyr)

inj_0726 <- read.csv(here("FieldData/Vaisala/inj_0726.csv"),
                     blank.lines.skip = TRUE, header = TRUE))


inj_0726$VB1<- (inj_0726$VB1 * 10000)-5
inj_0726$VB2<- (inj_0726$VB2 * 10)-30
inj_0726$VB3<- (inj_0726$VB3 * 10000)+17.5
inj_0726$VB4<- (inj_0726$VB4 * 10000)+17.5

plot2<- ggplot(inj_0726, aes(x = Time))+
    geom_point(aes(y = VB1, colour = "Vaisala 1"))+
      scale_color_manual(values=c("#1A5807", "#F3C519", "#1B48A9", "#63ABF9"))+
    geom_point(aes(y = VB2, colour = "Vaisala 2"))+
    geom_point(aes(y = VB3, colour = "Vaisala 3"))+
    geom_point(aes(y = VB4, colour = "Vaisala 4"))+
    labs(title = "Injection #4 - July 26", x = "Time", y = "CO2 PPM", colour = "Sensor")

plot2

