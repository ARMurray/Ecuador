library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)
library('knitr')

date<- "08142019"


# eos2 data
eos2 <- read.csv(here("FieldData/EosFD/eos2_08142019.csv"),fileEncoding="latin1")
eos2$Year <- paste0("20",eos2$Year)
eos2$dateTime <- as.POSIXct(as.character(paste0(eos2$Month,"/",eos2$Day,"/",eos2$Year," ",eos2$Time)), format = "%m/%d/%Y %H:%M:%OS")
eos2 <- eos2%>%
  select(dateTime,Flux,Temperature..C.,CO2.Soil..ppm..,
         CO2.Soil.STD..ppm.,CO2.ATM..ppm.,CO2.ATM.STD..ppm.,Mode)
colnames(eos2) <- c("DateTime_2","Flux_eos2","Temp_C_eos2","CO2_Soil_ppm_eos2","CO2_Soil_STD_ppm_eos2",
                    "CO2_ATM_ppm_eos2","CO2_ATM_STD_ppm_eos2","Mode_eos2")


#keep only the times from 19:15 8/5 to 11:15 8/6
eos2 <- eos2[c(2970:3162), ]

#make sure flux is reading as a number 
eos2$CO2_Soil_ppm_eos2 <-as.numeric(as.character(eos2$CO2_Soil_ppm_eos2))

#get some averages for this to compare 
eos2avg <- mean(eos2$Flux_eos2)
eos2min <- min(eos2$Flux_eos2)
eos2max <- max(eos2$Flux_eos2)
eos2std_dev <- sd(eos2$Flux_eos2)

eos2avg
eos2min
eos2max
eos2std_dev


#let's get the eos1 data
eos1 <- read.csv(here("FieldData/EosFD/eos1_08132019.1.csv"),fileEncoding="latin1")
eos1$Year <- paste0("20",eos1$Year)
eos1$dateTime <- as.POSIXct(as.character(paste0(eos1$Month,"/",eos1$Day,"/",eos1$Year," ",eos1$Time)), format = "%m/%d/%Y %H:%M:%OS")
eos1 <- eos1%>%
  select(dateTime,Flux,Temperature..C.,CO2.Soil..ppm.,
         CO2.Soil.STD..ppm.,CO2.ATM..ppm.,CO2.ATM.STD..ppm.,Mode)
colnames(eos1) <- c("DateTime_1","Flux_eos1","Temp_C_eos1","CO2_Soil_ppm_eos1","CO2_Soil_STD_ppm_eos1",
                    "CO2_ATM_ppm_eos1","CO2_ATM_STD_ppm_eos1","Mode_eos1")


#keep only the times from 19:15 8/5 to 11:15 8/6
eos1 <- eos1[c(342:534), ]

#make sure flux is reading as a number 
eos2$Temp_C_eos2<-as.numeric(as.character(eos2$Temp_C_eos2))

#get some averages for this to compare 
eos1avg <- mean(eos1$Flux_eos1)
eos1min <- min(eos1$Flux_eos1)
eos1max <- max(eos1$Flux_eos1)
eos1std_dev <- sd(eos1$Flux_eos1)

eos1avg
eos1min
eos1max
eos1std_dev

#make sure flux is reading as a number 
eos1$CO2_Soil_ppm_eos1 <-as.numeric(as.character(eos1$CO2_Soil_ppm_eos1))

#combine eos1 and 2

total <- cbind(eos1, eos2)

total <- total%>%
  select(DateTime_1, CO2_Soil_ppm_eos1, CO2_Soil_ppm_eos2)

#plot <- ggplot(total)+
  geom_line(aes(x= DateTime_1, y= Flux_eos1)) +
  labs(x = "Time", y = "Flux")
plot
  
co2_comp = ggplot() + 
  geom_point(data = total, aes(x = DateTime_1, y = CO2_Soil_ppm_eos1), color = "blue") +
  geom_point(data = total, aes(x = DateTime_1, y = CO2_Soil_ppm_eos2), color = "red") +
  xlab('Time') +
  ylab('CO2') +
  ggtitle('CO2 Comparison') 
plot


print(co2_comp)
