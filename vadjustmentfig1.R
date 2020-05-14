library(here)
library(dplyr)
library(ggplot2)
library(plotly)
library(crayon)
library(cowplot)

df <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))%>%
  select(DateTime,Inj,V1,V2,V3,V4,Flux_1,Flux_2,ppt_mm)%>%
  filter(!(Inj == "Yes"))
df$DateTime <- as.POSIXct(df$DateTime) 

df <- df%>%
  filter(DateTime > as.POSIXct("2019-07-10 11:30:00") & DateTime < as.POSIXct("2019-08-13 12:15:00"))


p1 <- ggplot(df)+
  geom_bar(aes(x= DateTime, y = ppt_mm), color = "turquoise4", stat="identity")+
  labs(y=expression(bold("Precip [mm]")), x="") +
  ylim(.0001, .8)
p1 <- p1 + theme(axis.text.y= largernumbers, 
                 axis.title.y= largernumbers2, title = largertitle, 
                 axis.text.x=element_blank(),
                 plot.margin=unit(c(1,1,-.25,1), "cm"))

p1 <- p1 + scale_y_reverse()+
  labs( axis.title.x = element_blank() ) + 
  theme_bw(base_size = 20) +
  theme(axis.text.y = element_text(size=12)) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(fill=NA, colour = "black", size=1.5))+
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_text(size = 12))+
  theme(plot.margin = unit(c(0, 0, 0, 0), "cm"))

p1

#PCO2 PLOT
dfd <- read.csv(here("final.csv"))%>%
  select(DateTime,Inj,V1_adjusted,V2_adjusted,V3_adjusted,V4_adjusted,Flux_1,Flux_2,ppt_mm)%>%
  filter(!(Inj == "Yes"))
dfd$DateTime <- as.POSIXct(dfd$DateTime) 

dfd <- dfd%>%
  filter(DateTime > as.POSIXct("2019-07-10 11:30:00") & DateTime < as.POSIXct("2019-08-13 12:15:00"))



p2 <- ggplot(dfd)+
  geom_point(aes(x= DateTime, y= V1_adjusted,color="Station 1"), size = 1) +
  geom_point(aes(x= DateTime, y= V2_adjusted,color="Station 2"), size = 1) +
  geom_point(aes(x= DateTime, y= V3_adjusted,color="Station 3"), size = 1) +
  geom_point(aes(x= DateTime, y= V4_adjusted,color="Station 4"), size = 1) +
  scale_color_manual(values=c("#F3C519","#1A5807", "#1B48A9", "#63ABF9"))+
  labs(x = "Date", y= expression(bold(pCO["2"]~"[ppm]"))) +
  theme_bw(base_size = 20) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=11),
        axis.title.y = element_text(size = 12))+
  theme(legend.position= c(0.75, 0.84))  +
  theme(legend.title = element_blank(), 
        legend.text = element_text(size = 8)) +
  theme(legend.background = element_rect(colour = 'transparent', fill = 'transparent', linetype='solid')) +
  theme(panel.border = element_rect(fill=NA, colour = "black", size=1.5)) +
  labs(color = "Location") +
  theme(plot.margin = unit(c(0, 0, 0, 0), "cm"))


#FLUX PLOT

data <- df[complete.cases(df$Flux_1),]

data <- data%>%
  select(DateTime,V1, V2, Flux_1)
colnames(data) <- c("DateTime","V1", "V2", "Flux_1")
data$Flux_1 <- as.numeric(as.character(data$Flux_1))
data <- data%>%
  filter(!(Flux_1 >= 4))


allfluxplot <- ggplot() + geom_line(data = data, aes(x= DateTime, y= Flux_1), color = "#F3C519", size = 1, group = 1) + 
  labs(x = "Date", y = "Average FLux (μmol/CO2/m2/s)")+ 
  theme_bw(base_size = 18)
print(allfluxplot)


#Separate out times eos was out of the float
filterdata <- data[-c(1660:1704),] 
filterdata <- filterdata[-c(2029:2078),] 
filterdata <- filterdata[-c(2247:2292),] 
filterdata <- filterdata[-c(3256:3297),] 
filterdata <- filterdata[-c(3862:3893),] 
filterdata <- filterdata[-c(3972:3995),] 

filterdata <- filterdata[filterdata$Flux_1>0, ]

filtfluxplot <- ggplot() + geom_line(data = filterdata, aes(x= DateTime, y= Flux_1), color = "#F3C519", size = 1, group = 1) + 
  labs(x = "Date", y = "Average FLux (μmol/CO2/m2/s)")+ 
  theme_bw(base_size = 18)
print(filtfluxplot)

filtfluxplotp <- ggplot() + geom_point(data = filterdata, aes(x= DateTime, y= Flux_1), color = "#F3C519", size = 1, group = 1) + 
  labs(x = "Date", y = "Average FLux (μmol/CO2/m2/s)")+ 
  theme_bw(base_size = 18)
print(filtfluxplotp)
filterdata$V1 <- filterdata$V1 / 500
filterdata$V2 <- filterdata$V2 / 500

#filtfluxplotp <- filtfluxplotp + geom_point(data = filterdata, aes(x= DateTime, y= V1), color = "blue", size = 1, group = 1) +  geom_point(data = filterdata, aes(x= DateTime, y= V2), color = "green", size = 1, group = 1) +
# scale_y_continuous(sec.axis = sec_axis(~ . * 500))
#filtfluxplotp

eos2 <- read.csv(here::here("FieldData/EosFD/eos2_07152019.csv"))

eos2$Year <- paste0("20",eos2$Year)
eos2$dateTime <- as.POSIXct(as.character(paste0(eos2$Year,"-",eos2$Month,"-",eos2$Day," ",eos2$Time)), format = "%Y-%m-%d %H:%M:%OS")
eos2 <- eos2%>%
  select(dateTime,Flux)
eos2 <- eos2[c(1:319),] 
colnames(eos2) <- c("DateTime","Flux_eos2")



allfluxplot <- filtfluxplotp + geom_point(data = eos2, aes(x= DateTime, y= Flux_eos2), color = "#63ABF9", size = 2, group = 1) + 
  labs(y=expression(bold(Evasion~'[umol'/~m^2~s~']')), axis.title.x = element_blank() ) + 
  theme_bw(base_size = 20) +
  theme(axis.text.y = element_text(size=14), axis.text.x = element_blank(), axis.title.x = element_blank(), axis.ticks.x=element_blank()) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(fill=NA, colour = "black", size=1.5)) + 
  scale_y_continuous(position = "right") +
  theme(plot.margin = unit(c(0, 0, 0, 0), "cm")) +
  theme(axis.title.y = element_text(size = 12))

print(allfluxplot)



cowplot::plot_grid(p1, allfluxplot,p2, align = "v", ncol = 1, rel_heights = c(0.20,0.30,0.50))