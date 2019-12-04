setwd("C:/Users/aestacio/Downloads/EcuadorFieldData/Ecuador/FieldData/DO")
library(here)
library(readxl)
install.packages("formatR")
library("formatR")

date <- "06262019"

data <- read_xls(here("FieldData/DO", paste0("DO_", date ,".xls")))
data <- data[,2:4]
colnames(data) <- c("Time", "mg/L", "TempC")

write.csv(data, here("FieldData/DO",
                 paste0("DO_", date, ".csv")))

dTable <- read.table(here("FieldData/DO", "DO_06262019.csv"))

dTable$datetime <- as.POSIXct(as.character(paste0(dTable$Month, "/", dTable$Day, "/", dTable$Year, " " dTable$Time)), format = "%m/%d/%Y %H:%M:%OS")
