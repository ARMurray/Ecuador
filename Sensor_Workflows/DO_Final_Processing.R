# Dissolved Oxygen data processing
library(here)
library(dplyr)
library(ggplot2)

## DO Sensor #1

DO1_Data <- read.csv(here("FieldData/DO/Last_Collection/DO_1_2019-08-14.csv"),
                     skip = 2, blank.lines.skip = TRUE, header = FALSE)
DO1_Data <- DO1_Data[,2:4]
colnames(DO1_Data) <- c("DateTime","DO_mg_L","Temp_C")

### Convert time from factor to POSIXct
DO1_Data$DateTime <- as.POSIXct(as.character(DO1_Data$DateTime),
                                  format = '%m/%d/%y %I:%M:%OS %p')

DO1_Data <- DO1_Data[complete.cases(DO1_Data), ]%>%
  mutate(Station = "1")

## DO Sensor #2
DO2_Data <- read.csv(here("FieldData/DO/Last_Collection/DO_2_2019-08-14.csv"),
                     skip = 2, blank.lines.skip = TRUE, header = FALSE)
DO2_Data <- DO2_Data[,2:4]
colnames(DO2_Data) <- c("DateTime","DO_mg_L","Temp_C")

### Convert time from factor to POSIXct
DO2_Data$DateTime <- as.POSIXct(as.character(DO2_Data$DateTime),
                                format = '%m/%d/%y %I:%M:%OS %p')

DO2_Data <- DO2_Data[complete.cases(DO2_Data), ]%>%
  mutate(Station = "2")

## DO Sensor #3
DO3_Data <- read.csv(here("FieldData/DO/Last_Collection/DO_3_2019-08-14.csv"),
                     skip = 2, blank.lines.skip = TRUE, header = FALSE)
DO3_Data <- DO3_Data[,2:4]
colnames(DO3_Data) <- c("DateTime","DO_mg_L","Temp_C")

### Convert time from factor to POSIXct
DO3_Data$DateTime <- as.POSIXct(as.character(DO3_Data$DateTime),
                                format = '%m/%d/%y %I:%M:%OS %p')

DO3_Data <- DO3_Data[complete.cases(DO3_Data), ]%>%
  mutate(Station = "4")

### Combine all data

allDOdata <- rbind(DO1_Data,DO2_Data,DO3_Data)

temp_C <- data.frame()
for(n in 1:nrow(allDOdata)){
  row <- allDOdata[n,]
  if (row$Temp_C > 25){
    temp <- (row$Temp_C - 32)*(5/9)
  } else{
    temp <- row$Temp_C
  }
  temp_C <- rbind(temp_C,temp)
}

allDOdata$Temp_C <- temp_C$X12.0222222222222

write.csv(allDOdata, here("data_4_analysis/all_DO.csv"))
