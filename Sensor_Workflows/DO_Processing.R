# Dissolved Oxygen data processing
library(here)
library(dplyr)
library(ggplot2)

## DO Sensor #1

### Get a list of all the DO1 files
DO1_Files <- list.files(here::here("FieldData/DO"),pattern = 'DO_1')

### Create an empty data frame
allDO1Data <- data.frame()

### Combine all DO1 data
for(i in 1:length(DO1_Files)){
  file <- DO1_Files[i]
  data <- read.csv(here::here("FieldData/DO",file),skip = 2,
                   blank.lines.skip = TRUE, header = FALSE)
  data <- data[,2:4]
  colnames(data) <- c("DateTime","DO_mg_L","Temp_C")
  allDO1Data <- rbind(allDO1Data,data)
}

### Convert time from factor to POSIXct
allDO1Data$DateTime <- as.POSIXct(as.character(allDO1Data$DateTime),
                                  format = '%m/%d/%y %I:%M:%OS %p')

allDO1Data <- allDO1Data[complete.cases(allDO1Data), ]%>%
  mutate(Station = "1")

## DO Sensor #2
### Get a list of all the DO2 files
DO2_Files <- list.files(here::here("FieldData/DO"),pattern = 'DO_2')

### Create an empty data frame
allDO2Data <- data.frame()

### Combine all DO2 data
for(i in 1:length(DO2_Files)){
  file <- DO2_Files[i]
  data <- read.csv(here::here("FieldData/DO",file),skip = 2,
                   blank.lines.skip = TRUE, header = FALSE)
  data <- data[,2:4]
  colnames(data) <- c("DateTime","DO_mg_L","Temp_C")
  allDO2Data <- rbind(allDO2Data,data)
}

### Convert time from factor to POSIXct
allDO2Data$DateTime <- as.POSIXct(as.character(allDO2Data$DateTime),
                                  format = '%m/%d/%y %I:%M:%S %p')

allDO2Data <- allDO2Data[complete.cases(allDO2Data), ]%>%
  mutate(Station = "2")

## DO Sensor #3
### Get a list of all the DO3 files
DO3_Files <- list.files(here::here("FieldData/DO"),pattern = 'DO_3')

### Create an empty data frame
allDO3Data <- data.frame()

### Combine all DO3 data
for(i in 1:length(DO3_Files)){
  file <- DO3_Files[i]
  data <- read.csv(here::here("FieldData/DO",file),skip = 2,
                   blank.lines.skip = TRUE, header = FALSE)
  data <- data[,2:4]
  colnames(data) <- c("DateTime","DO_mg_L","Temp_C")
  allDO3Data <- rbind(allDO3Data,data)
}

### Convert time from factor to POSIXct
allDO3Data$DateTime <- as.POSIXct(as.character(allDO3Data$DateTime),
                                  format = '%m/%d/%y %I:%M:%S %p')

allDO3Data <- allDO3Data[complete.cases(allDO3Data), ]%>%
  mutate(Station = "4")

### Combine all data

allDOdata <- rbind(allDO1Data,allDO2Data,allDO3Data)

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

write.csv(allDOdata, here("data_4_analysis/DO.csv"))
