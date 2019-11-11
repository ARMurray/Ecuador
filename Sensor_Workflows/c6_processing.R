library(here)
library(ggplot2)
library(dplyr)

### Get a list of all the C6 files
C6_Files <- list.files(here::here("FieldData/C6"),pattern = 'C6_')


### Create an empty data frame
allC6Data <- data.frame()

### Combine all C6 data
for(i in 1:length(C6_Files)){
  file <- C6_Files[i]
  data <- read.csv(here::here("FieldData/C6",file),skip = 10,
                   header = FALSE)
  data <- data[,1:7]
  colnames(data) <- c("DateTime", "Turbidity_NTU", "Chlorophylla_ug/L", "Phycocyanin_ppb", "CDOM_ppb", "Depth_m", "Temp_C")
  allC6Data <- rbind(allC6Data,data)
}

#set time to posix ct 
allC6Data$DateTime <- as.POSIXct(as.character(allC6Data$DateTime), format = "%m/%d/%Y %H:%M")


#write a new file and put it in folder for processig

write.csv(allC6Data, here("data_4_analysis/C6.csv"))

oneday <- read.csv(here("FieldData/C6/C6_071119.csv"))

c6 <- read.csv(here("data_4_analysis/c6.csv"))

#make posic.ct, posixct again
c6$DateTime <- as.POSIXct(c6$DateTime)


c6short <- c6[c(1:661), ]



#let's try to make a simple plot 
plot <- ggplot(c6short)+
  geom_point(aes(x= DateTime, y= CDOM_ppb), color="blue")
plot
ggplotly(plot)

plot2 <- ggplot(c6short)+
  geom_point(aes(x= DateTime, y= Turbidity_NTU), color="red")
plot2
ggplotly(plot2)

plot3 <- ggplot(c6short)+
  geom_point(aes(x= DateTime, y= Chlorophylla_ug.L), color="green")
plot3
ggplotly(plot3)

plot4 <- ggplot(c6short)+
  geom_point(aes(x= DateTime, y= Phycocyanin_ppb), color="purple")
plot4
ggplotly(plot4)
  
  