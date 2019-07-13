library(here)
library(ggplot2)
library(tidyverse)

# This script is for the processing of data collected from the GM70 Handheld Vaisala 
fileList <- list.files(here::here("FieldData/GM70HandheldVaisala"))

allData <- data.frame()

for(i in 1:length(fileList)){
  file <- fileList[i]
  data <- read.csv(here::here("FieldData/GM70HandheldVaisala",file))
  allData <- rbind(allData,data)
}

colnames(allData) <- c("DateTime","CO2_PPM")
allData$DateTime <- as.POSIXct(allData$DateTime, format = "%m/%d/%Y %H:%M:%S")

allData <- allData[complete.cases(allData), ]

allData <- arrange(allData,DateTime)

write.csv(allData,here::here("data_4_analysis/GM70",paste0("GM70_All_Data.csv")))
