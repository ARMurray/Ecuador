
library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)
library('knitr')
library(ggpubr)
library("ggpubr")
library(imputeTS)
library(tidyverse)
library(lubridate)

f1 <- read.csv(here("Flux_718.csv"))
f2 <- read.csv(here("Flux_725.csv"))
f3 <- read.csv(here("Flux_731.csv"))
f4 <- read.csv(here("Flux_86.csv"))
f5 <- read.csv(here("Flux_812.csv"))

syn1 <- data.frame(c(mean(f1[1:4,]$Flux), mean(f2[1:4,]$Flux), mean(f3[1:4,]$Flux), mean(f4[1:4,]$Flux), mean(f5[1:4,]$Flux)))
colnames(syn1) <- "flux1"
row.names(syn1) <- c("Jul 18", "Jul 25", "Jul 31", "Aug 6", "Aug 12")
syn1m <- mean(syn1$flux1) * 2160000 * .000001
syn1sd <- sd(syn1$flux1) * 2160000 * .000001

syn5 <- data.frame(c(mean(f1[5:8,]$Flux), mean(f2[5:8,]$Flux), mean(f3[5:8,]$Flux), mean(f4[5:8,]$Flux), mean(f5[5:8,]$Flux)))
colnames(syn5) <- "flux5"
row.names(syn5) <- c("Jul 18", "Jul 25", "Jul 31", "Aug 6", "Aug 12")
syn5m <- mean(syn5$flux5) * 2160000 * .000001
syn5sd <- sd(syn5$flux5) * 2160000 * .000001

syn8 <- data.frame(c(mean(f1[9:11,]$Flux), NA,  mean(f3[9:12,]$Flux), mean(f4[9:12,]$Flux), mean(f5[9:12,]$Flux)))
colnames(syn8) <- "flux8"
row.names(syn8) <- c("Jul 18", "Jul 25", "Jul 31", "Aug 6", "Aug 12")
syn8m <- mean(syn8$flux8, na.rm=TRUE) * 2160000 * .000001
syn8sd <- sd(syn8$flux8, na.rm=TRUE) * 2160000 * .000001
                  
syn11 <- data.frame(c(mean(f1[12:15,]$Flux), mean(f2[9:11,]$Flux), mean(f3[13:16,]$Flux), mean(f4[13:16,]$Flux), mean(f5[13:16,]$Flux)))
colnames(syn11) <- "flux11"
row.names(syn11) <- c("Jul 18", "Jul 25", "Jul 31", "Aug 6", "Aug 12")
syn11m <- mean(syn11$flux11) * 2160000 * .000001
syn11sd <- sd(syn11$flux11) * 2160000 * .000001

syn14 <- data.frame(c(mean(f1[16:19,]$Flux), mean(f2[12:15,]$Flux), mean(f3[17:20,]$Flux), mean(f4[17:20,]$Flux), mean(f5[17:20,]$Flux)))
colnames(syn14) <- "flux14"
row.names(syn14) <- c("Jul 18", "Jul 25", "Jul 31", "Aug 6", "Aug 12")
syn14m <- mean(syn14$flux14) * 2160000 * .000001
syn14sd <- sd(syn14$flux14) * 2160000 * .000001

synw <- data.frame(c(mean(f1[20:23,]$Flux), mean(f2[16:19,]$Flux), mean(f3[21:24,]$Flux), mean(f4[21:24,]$Flux), mean(f5[21:24,]$Flux)))
colnames(synw) <- "fluxw"
row.names(synw) <- c("Jul 18", "Jul 25", "Jul 31", "Aug 6", "Aug 12")
synwm <- mean(synw$fluxw) * 2160000 * .000001
synwsd <- sd(synw$fluxw) * 2160000 * .000001

syn20 <- data.frame(c(mean(f1[24:27,]$Flux), NA, mean(f3[25:28,]$Flux), mean(f4[25:28,]$Flux), mean(f5[25:28,]$Flux)))
colnames(syn20) <- "flux20"
row.names(syn20) <- c("Jul 18","Jul 25",  "Jul 31", "Aug 6", "Aug 12")
syn20m <- mean(syn20$flux20, na.rm=TRUE) * 2160000 * .000001
syn20sd <- sd(syn20$flux20, na.rm=TRUE) * 2160000 * .000001

syn23 <- data.frame(c(mean(f1[28:31,]$Flux), mean(f2[20:23,]$Flux), mean(f3[29:32,]$Flux), mean(f4[29:32,]$Flux), mean(f5[29:32,]$Flux)))
colnames(syn23) <- "flux23"
row.names(syn23) <- c("Jul 18", "Jul 25", "Jul 31", "Aug 6", "Aug 12")
syn23m <- mean(syn23$flux23) * 2160000 * .000001
syn23sd <- sd(syn23$flux23) * 2160000 * .000001

syn29 <- data.frame(c(mean(f1[32:35,]$Flux), mean(f2[24:27,]$Flux), mean(f3[33:36,]$Flux), mean(f4[33:36,]$Flux), mean(f5[33:36,]$Flux)))
colnames(syn29) <- "flux29"
row.names(syn29) <- c("Jul 18", "Jul 25", "Jul 31", "Aug 6", "Aug 12")
syn29m <- mean(syn29$flux29) * 2160000 * .000001
syn29sd <- sd(syn29$flux29) * 2160000 * .000001

syn35 <- data.frame(c(mean(f1[36:39,]$Flux), mean(f2[28:31,]$Flux), mean(f3[37:40,]$Flux), mean(f4[37:40,]$Flux), mean(f5[37:39,]$Flux)))
colnames(syn35) <- "flux35"
row.names(syn35) <- c("Jul 18", "Jul 25", "Jul 31", "Aug 6", "Aug 12")
syn35m <- mean(syn35$flux35) * 2160000 * .000001
syn35sd <- sd(syn35$flux35) * 2160000 * .000001

all <- cbind(syn1, syn5, syn8, syn11, syn14, synw, syn20, syn23, syn29, syn35)
allpointsavg <- cbind(syn1m, syn5m, syn8m, syn11m, syn14m, synwm, syn20m, syn23m, syn29m, syn35m)
allpointsavg <- t(allpointsavg)
allpointssd <- cbind(syn1sd, syn5sd, syn8sd, syn11sd, syn14sd, synwsd, syn20sd, syn23sd, syn29sd, syn35sd)
allpointssd <- t(allpointssd)
dis <- data.frame(c(245.2, 217.6, 194.9, 169.9, 143.7, 107, 94.1, 75.9, 37.4, 5))
df <- cbind(allpointsavg, allpointssd, dis)
colnames(df) <- c("Flux", "StdDev", "Distance")

p <- ggplot(df, aes(x=Distance, y=Flux)) + 
  geom_bar(stat = "identity") +
  geom_errorbar(aes(ymin=Flux-StdDev, ymax=Flux+StdDev), width=.2, position=position_dodge(.9)) +
  labs(x= "Distance from Peatland", y=expression(bold(CO["2"]~Flux~'[mol/'*m^2*'25d]')),axis.title.y = element_text(face="bold")) + theme_bw(base_size = 20) + theme(legend.title=element_blank())
p
c4<- c("skyblue4", "skyblue3", "skyblue2","skyblue", "lightskyblue1", "palegreen4", "palegreen3", "palegreen2","darkseagreen", "darkseagreen2")

p <- ggplot(df, aes(x=Distance, y=Flux, width =13,  fill = Flux)) + 
  geom_bar(stat = "identity", fill= c("skyblue4", "skyblue3", "skyblue", "lightskyblue1", "darkslategray", "darkolivegreen", "darkolivegreen4", "darkolivegreen3","darkolivegreen2", "darkolivegreen1")) +
  geom_errorbar(aes(ymin=Flux-StdDev, ymax=Flux+StdDev), width=.2, position=position_dodge(.9)) +
  labs(x= "Distance from Peatland", y=expression(bold(CO["2"]~Flux~'[mol/'*m^2*'25d]')),axis.title.y = element_text(face="bold")) + theme_bw(base_size = 20) +
  theme( axis.text.y = element_text(size=14), axis.text.x = element_text(size=14), axis.title.x = element_text(face="bold"))+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())  + ylim(0,22)
p


date <- data.frame(date = c("2019-07-18","2019-07-25","2019-07-31","2019-08-06","2019-08-12"))%>%
  mutate(date = ymd(date))
all <- cbind(time, all)
row.names(all) <- c("Jul 18", "Jul 25", "Jul 31", "Aug 6", "Aug 12")


fulltime <- data.frame(date = seq(ymd("2019-07-18"),ymd("2019-08-12"), by="1 day"))%>%
  left_join(all)%>%
  na_interpolation(option = 'linear', maxgap = Inf)

#convert flux to days
fulltime[,2:11] <- fulltime[,2:11] * 86400 * .000001
# Plot
plot<- ggplot(data = fulltime, aes(x = date, size=1)) +
  #geom_point(aes(y = flux1), color = 'palegreen')+
  #geom_point(aes(y = flux5), color = 'palegreen1')+
  #geom_point(aes(y = flux8), color = 'palegreen2')+
  #geom_point(aes(y = flux11), color = 'palegreen3')+
  #geom_point(aes(y = flux14), color = 'palegreen4')+
  #geom_point(aes(y = fluxw), color = 'lightskyblue1')+
  #geom_point(aes(y = flux20), color = 'skyblue')+
  geom_point(aes(y = flux23), color = 'skyblue2')+
 # geom_point(aes(y = flux29), color = 'skyblue3')+
  geom_point(aes(y = flux35), color = 'skyblue4')+
  labs(x= "Date", y=expression(bold(CO["2"]~Flux~'[micromol/m'^2~'d]')))
  #geom_point(data = all, aes(x = date, y = value), color = 'red', size = 3)
plot
#cumulative
fulltime[,12:21] <- cumsum(fulltime[,2:11])
#colnames(fulltime[,12:21]) = c("syn1c", "syn5c", "syn8c", "syn11c", "syn14c", "synwc", "syn20c", "syn23c", "syn29c", "syn35c")
plotc <- ggplot(data = fulltime, aes(x = date)) +
  geom_point(aes(y = flux1.1, size = 1, col = group), color = 'darkolivegreen1')+
  geom_point(aes(y = flux5.1, size = 1, col = group), color = 'darkolivegreen2')+
  geom_point(aes(y = flux8.1, size = 1, col = group), color = 'darkolivegreen3')+
  geom_point(aes(y = flux11.1, size = 1, col = group), color = 'darkolivegreen4')+
  geom_point(aes(y = flux14.1, size = 1, col = group), color = 'darkolivegreen')+
  geom_point(aes(y = fluxw.1, size = 1, col = group), color = "darkslategrey")+
  geom_point(aes(y = flux20.1, size = 1, col = group), color = 'lightskyblue1')+
  geom_point(aes(y = flux23.1, size = 1, col = group), color = 'skyblue')+
  geom_point(aes(y = flux29.1, size = 1, col = group), color = 'skyblue3')+
  geom_point(aes(y = flux35.1, size = 1, col = group), color = 'skyblue4')+
  labs(x= "Date", y=expression(bold(~Cumulative~CO["2"]~Flux~'[mol/'*m^2*']')),axis.title.y = element_text(face="bold")) + theme_bw(base_size = 20) +
  theme( axis.text.y = element_text(size=14), axis.text.x = element_text(size=14), axis.title.x = element_text(face="bold"))+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +theme(legend.position="none")+ ylim(0,22)
plotc

both <- ggarrange(p,plotc)
both

plotn <- plotc + geom_point(data = all, aes(x = date, y = flux1), color = 'red', size = 3)+ 
  geom_point(data = all, aes(x = date, y = flux5), color = 'red', size = 3)+ 
  geom_point(data = all, aes(x = date, y = flux8), color = 'red', size = 3)+
geom_point(data = all, aes(x = date, y = flux11), color = 'red', size = 3)+
 geom_point(data = all, aes(x = date, y = flux14), color = 'red', size = 3)+
 geom_point(data = all, aes(x = date, y = fluxw), color = 'red', size = 3)+
 geom_point(data = all, aes(x = date, y = flux20), color = 'red', size = 3)+
 geom_point(data = all, aes(x = date, y = flux23), color = 'red', size = 3)+
 geom_point(data = all, aes(x = date, y = flux29), color = 'red', size = 3)+
   geom_point(data = all, aes(x = date, y = flux35), color = 'red', size = 3)
plotc <- ggplot(data = fulltime, aes(x = date)) +
  geom_point(aes(y = flux1.1, size = 1, col = group), color = 'darkolivegreen1')+
  geom_point(aes(y = flux5.1, size = 1, col = group), color = 'darkolivegreen2')+
  geom_point(aes(y = flux8.1, size = 1, col = group), color = 'darkolivegreen3')+
  geom_point(aes(y = flux11.1, size = 1, col = group), color = 'darkolivegreen4')+
  geom_point(aes(y = flux14.1, size = 1, col = group), color = 'darkolivegreen')+
  labs(x= "Date", y=expression(bold(~Cumulative~CO["2"]~Flux~'[mol/'*m^2*']')),axis.title.y = element_text(face="bold")) + theme_bw(base_size = 20) +
  theme( axis.text.y = element_text(size=14), axis.text.x = element_text(size=14), axis.title.x = element_text(face="bold"))+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +theme(legend.position="none")
plotc
