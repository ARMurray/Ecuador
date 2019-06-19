library(here)

date<- "06182019"

eos1 <- read.csv(here("FieldData",paste0("eos1_",date,".csv")))

Time<- eos1$Time
Flux <- eos1$Flux

#make a table with just flux and time of desired data
 
new<- data.frame(Time[1398:1439], Flux[1398:1439])
new




