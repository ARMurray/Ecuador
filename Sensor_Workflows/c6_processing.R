library(here)
library(ggplot2)
library(dplyr)

# *** SET THE DATE ***
date <- "071119"


#  import C6 data
C6 <- read.csv(here("FieldData/C6",paste0("C6_",date,".csv")), skip=9)

#Set column names

colnames(C6) <- c("DateTime", "Turbidity_NTU", "Chlorophylla_ug/L", "Phycocyanin_ppb", "CDOM_ppb", "Depth_m", "Temp_C", "1", "2", "3", "4", "5","6")

#Delete excess columns 
C6 <- C6 %>% select(DateTime, Turbidity_NTU, "Chlorophylla_ug/L", Phycocyanin_ppb, CDOM_ppb, Depth_m, Temp_C)
  
#set time to posix ct 
C6$DateTime <- as.POSIXct(as.character(C6$DateTime), format = "%m/%d/%Y %H:%M")



### Get a list of all the DO1 files
C6_Files <- list.files(here::here("FieldData/C6"),pattern = 'C6_')


### Create an empty data frame
allC6Data <- data.frame()

### Combine all C6 data
for(i in 1:length(C6_Files)){
  file <- C6_Files[i]
  data <- read.csv(here::here("FieldData/C6",file),skip = 9,
                   header = FALSE)
  data <- data[,2:4]
  colnames(data) <- c("DateTime","DO_mg_L","Temp_C")
  allDO1Data <- rbind(allDO1Data,data)
}