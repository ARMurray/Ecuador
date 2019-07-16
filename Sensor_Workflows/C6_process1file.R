#to process a single C6 data file quickly 

library(here)
library(ggplot2)
library(dplyr)

# *** SET THE DATE ***
date <- "071119"


#  import C6 data
C6 <- read.csv(here("FieldData/C6",paste0("C6_",date,".csv")), skip=10, header = FALSE)

#Set column names

colnames(C6) <- c("DateTime", "Turbidity_NTU", "Chlorophylla_ug/L", "Phycocyanin_ppb", "CDOM_ppb", "Depth_m", "Temp_C", "1", "2", "3", "4", "5","6")

#Delete excess columns 
C6 <- C6 %>% select(DateTime, Turbidity_NTU, "Chlorophylla_ug/L", Phycocyanin_ppb, CDOM_ppb, Depth_m, Temp_C)

#set time to posix ct 
C6$DateTime <- as.POSIXct(as.character(C6$DateTime), format = "%m/%d/%Y %H:%M")
