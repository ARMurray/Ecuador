library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)
library(scales)

July18<-read.csv(here("Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method07_18.csv"))%>%
  select(Position,K600.Avg...m.day.)%>%
  mutate("Date" = "July 18")
July25<-read.csv(here("Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method7_25.csv"))%>%
  select(Position,K600.Avg...m.day.)%>%
  mutate("Date" = "July 25")
July31<-read.csv(here("Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method7_31.csv"))%>%
  select(Position,K600.Avg...m.day.)%>%
  mutate("Date" = "July 31")
Aug6<-read.csv(here("Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method 08_06.csv"))%>%
  select(Station,K600.Avg...m.Day.)%>%
  mutate("Date" = "August 6")
Aug12<-read.csv(here("Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method08_12.csv"))%>%
  select(Syn,K600.Mid)%>%
  mutate("Date" = "August 12")

dists <- read.csv(here("Outputs/Gas Transfer Velocity/Raymond Method/Raymond Paper Method07_18.csv"))%>%
  select(Position,Dist...m.)
colnames(dists) <- c("Position","Distance")

colnames(July18) <- c("Position","K600","Date")
colnames(July25) <- c("Position","K600","Date")
colnames(July31) <- c("Position","K600","Date")
colnames(Aug6) <- c("Position","K600","Date")
colnames(Aug12) <- c("Position","K600","Date")

allK600 <- rbind(July18,July25,July31,Aug6,Aug12)%>%
  left_join(dists)

plot <- ggplot(allK600)+
  geom_point(aes(x=Distance, y=K600, colour=Date))



### OLD CODE BELOW THIS LINE ###
K600Total<-cbind(July18,July25$K600.Avg...m.day.,July31$K600.Avg...m.day.,Aug6$K600.Avg...m.Day.,Aug12$K600.Mid)
Distance<-K600Total$Dist...m.
July18K<-K600Total$K600.Avg...m.day.
July25K<-K600Total$`July25$K600.Avg...m.day.`
July31K<-K600Total$`July31$K600.Avg...m.day.`
Aug6K<-K600Total$`Aug6$K600.Avg...m.Day.`
Aug12K<-K600Total$`Aug12$K600.Mid`

Plot<-ggplot(K600Total,aes(x=Distance,y=July18K,colour="Red"))+
               geom_point(colour="Red",shape=19,size=2)+
               geom_point(data =K600Total,aes(x=Distance,y=K600Total$`July25$K600.Avg...m.day.`,colour="Orange",shape=19,size=2))+
               geom_point(data =K600Total,aes(x=Distance,y=July31K,colour="Yellow",shape=19,size=2))+
               geom_point(data =K600Total,aes(x=Distance,y=Aug6K,colour="Green",shape=19,size=2))+
               geom_point(data =K600Total,aes(x=Distance,y=Aug12K,colour="Blue",shape=19,size=2))
            
Plot        