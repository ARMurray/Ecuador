library(here)

date<- "06182019"

eos1 <- read.csv(here("FieldData",paste0("eos1_",date,".csv")))

Time<- eos1$Time
Flux <- eos1$Flux

#make a table with just flux and time of desired data
 
new<- data.frame(Time = Time[1398:1439], Flux = Flux[1398:1439])
new
#install.packages("ggplot2")
library("ggplot2")


plot <- ggplot(new)  + geom_line(aes(x= Time, y= Flux, group=1)) 
plot

#add injection points to the frame
injection1 <- data.frame(Time= new$Time[29:31], Flux= new$Flux[29:31])

plot <- plot + geom_point(data=injection1, aes(x=Time, y= Flux), colour = 'red', size = 3)
plot
