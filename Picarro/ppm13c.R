library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)
library(viridis)
library(grid)
library(gridExtra)
library(viridis)

largernumbers <- element_text(face = "bold", size = 14)
largernumbers2 <- element_text(face = "bold", size = 12)



#we are trying to do a comparison for ppm vs. d13C for all sites where we have data

#first let's load in the ppm data 

ppm <- read.csv(here("FieldData/Vaisala/Synoptics2.csv"))

ppm <- ppm %>%
  select(Distance, Syn1_071819, Syn4_073119, Syn5_080619, Syn6_081219)

#truncate some numbers 

ppm$Distance <- round(ppm$Distance, digits = 1)

ppm <- ppm[c(1,5,8,11,14,18,21,24,30,36),]

colnames(ppm)[1] <- "DistSyn"
ppm0718 <- ppm %>%
  select(DistSyn, Syn1_071819)

colnames(ppm0718)[2] <- "Syn"

ppm0731 <- ppm %>%
  select(DistSyn, Syn4_073119)

colnames(ppm0731)[2] <- "Syn"

ppm0806 <- ppm %>%
  select(DistSyn, Syn5_080619)

colnames(ppm0806)[2] <- "Syn"

ppm0806 <- ppm0806[1:9,]

ppm0812 <- ppm %>%
  select(DistSyn, Syn6_081219)

colnames(ppm0812)[2] <- "Syn"


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


#July 18
july18small <- july18 %>%
  select(Distance,CorrectedAverage)

july18all <- cbind(ppm0718, july18small)

july18all <- july18all %>%
  select(DistSyn, Syn, CorrectedAverage)

#july31

july31small <- july31 %>%
  select(Distance,CorrectedAverage)

july31all <- cbind(ppm0731, july31small)

july31all <- july31all %>%
  select(DistSyn, Syn, CorrectedAverage)

#aug 06 

aug06small <- aug06 %>%
  select(Distance,CorrectedAverage)

aug06all <- cbind(ppm0806, aug06small)

aug06all <- aug06all %>%
  select(DistSyn, Syn, CorrectedAverage)

#aug12 

aug12small <- aug12 %>%
  select(Distance,CorrectedAverage)

aug12all <- cbind(ppm0812, aug12small)

aug12all <- aug12all %>%
  select(DistSyn, Syn, CorrectedAverage)





ppmdelta <- rbind(july18all, july31all, aug06all, aug12all)

write.csv(ppmdelta, here("Picarro/ppmdelta.csv"))

ppmC <- ggplot(ppmdelta)+
  geom_point(ppmdelta, mapping=aes(x=Syn, y=CorrectedAverage, color=DistSyn), size=3)+
  labs(x=expression(bold(paste("pCO"^{2}, "[ppm]"))), y=expression(bold(paste(delta^{13}, "C", "F"[AQ], "[%]"))), color="Outlet Dist. [m]")+
  scale_color_viridis(option = "B", discrete = FALSE)+
  ggtitle("PPM vs. Delta 13 C")+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.text.x = largernumbers2, axis.title.x=largernumbers,
        axis.text.y=largernumbers2, axis.title.y=largernumbers,plot.title = element_text(margin = margin(t= 10, b = -20), face="bold",
                                                                                         ))

ppmC



    


