library(here)

date<- "06182019"
# eos 1 data

eos1 <- read.csv(here("FieldData",paste0("eos1_",date,".csv")))

Time<- eos1$Time
Flux <- eos1$Flux
eos1$Time <- as.POSIXct(as.character(eos1$Time), format = "%H:%M:%OS")


#make a table with just flux and time of desired data
 
new<- data.frame(Time = Time[1398:1439], Flux = Flux[1398:1439])
new$Time <- as.POSIXct(as.character(new$Time), format = "%H:%M:%OS")
new
#install.packages("ggplot2")
library("ggplot2")


plot <- ggplot(new)+
  geom_line(aes(x= Time, y= Flux, group=1)) 
plot

#add injection points to the frame
injection1 <- data.frame(Time= new$Time[29:31], Flux= new$Flux[29:31])
injection2 <- data.frame(Time = new$Time[38:40], Flux = new$Flux[38:40])


plot <- plot+
  geom_point(data=injection1, aes(x=Time, y= Flux), colour = 'red', size = 3)+
  geom_point(data=injection2, aes(x=Time, y= Flux), colour = 'blue', size = 3)
plot

#eos2 data 
eos2 <- read.csv(here("FieldData", "EosFD",paste0("eos2_",date,".csv")))

eos2$Time <- as.POSIXct(as.character(eos2$Time), format = "%H:%M:%OS")
Time<- eos2$Time
Flux <- eos2$Flux

eos2
#make a table with just flux and time of desired data

new2<- data.frame(Time = Time[1374:1415], Flux = Flux[1374:1415])
new2

#add second eos data to plot
plot <- plot + geom_line(data=new2, aes(x= Time, y= Flux)) 
plot
