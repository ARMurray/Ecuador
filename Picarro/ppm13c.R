library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)
library(viridis)
library(grid)
library(gridExtra)

#we are trying to do a comparison for ppm vs. d13C for all sites where we have data

#first let's load in the ppm data 

ppm <- read.csv(here("FieldData/Vaisala/Synoptics2.csv"))

ppm <- ppm %>%
  select(Distance, Syn1_071819, Syn4_073119, Syn5_080619, Syn6_081219)

#truncate some numbers 

ppm$Distance <- round(ppm$Distance, digits = 1)

ppm <- ppm[c(1,5,8,11,14,18,21,24,30,36),]


#ok now let's pull in c13 synoptic data

july18 <- read.csv(here("Picarro/synoptics/071819/july18CV_statistics.csv"))
july18 <- july18[-c(11),]

july31 <- read.csv(here("Picarro/synoptics/073119/july31CV_statistics.csv"))
july31 <- july31[-c(11),]

aug06 <- read.csv(here("Picarro/synoptics/080619/aug06CV_statistics.csv"))
aug06 <- aug06[-c(10),]

aug12 <- read.csv(here("Picarro/synoptics/081219/aug12CV_statistics.csv"))
aug12 <- aug12[-c(11),]

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


july18 <- cbind(july18, dis)
july31 <- cbind(july31,dis)
aug06 <- cbind(aug06, dis2)
aug12 <- cbind(aug12,dis)


july18 <- july18 %>%
  select(Distance, Sample,Day,CorrectedAverage,StdDev_iCO2,CV,RelativeStdDev)

july31 <- july31 %>%
  select(Distance, Sample,Day,CorrectedAverage,StdDev_iCO2,CV,RelativeStdDev)

aug06 <- aug06 %>%
  select(Distance, Sample,Day,CorrectedAverage,StdDev_iCO2,CV,RelativeStdDev)

aug12 <- aug12 %>%
  select(Distance, Sample,Day,CorrectedAverage,StdDev_iCO2,CV,RelativeStdDev)


allsynop <- rbind(july18,july31,aug06,aug12)

write.csv(allsynop, here("Picarro/synoptics/allsynoptics_diego.csv"))

test <- cbind(ppm, july18)

ppmjul18 <- ppm %>%
  select(Distance, Syn1_071819)

july18small <- july18 %>%
  select(Distance, Sample, Day, CorrectedAverage)
    
    
testagain <- cbind(ppmjul18, july18small)    
    
    
plot1 <- ggplot(testagain)+
  geom_point(testagain, mapping=aes(x=Syn1_071819, y=CorrectedAverage))+
  labs(x="PPM", y="delta13")+
  ggtitle("July18")


plot1

