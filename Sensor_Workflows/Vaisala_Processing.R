library(here)
library(ggplot2)
library(tidyverse)

# This script is for the processing of data collected from the 4 vaisalas
# which are permanently installed inside of the 4 large weatherproof boxes

# Import the Vaisala data for the date specified above.
V1Files <- list.files(path = here("FieldData/Vaisala"), pattern = "VB1")
V2Files <- list.files(path = here("FieldData/Vaisala"), pattern = "VB2")
V3Files <- list.files(path = here("FieldData/Vaisala"), pattern = "VB3")
V4Files <- list.files(path = here("FieldData/Vaisala"), pattern = "VB4")

### Create an empty data frame
V1Data <- data.frame()

### Combine Vaisala 1 data
for(i in 1:length(V1Files)){
  file <- V1Files[i]
  data <- read.csv(here::here("FieldData/Vaisala",file),
                   blank.lines.skip = TRUE, header = TRUE)
  V1Data <- rbind(V1Data,data)
}
# Convert time to POSIXct in a new column called "DateTime"
V1Data$DateTime <- paste0(V1Data$Date," ",V1Data$Time)
V1Data$DateTime <- as.POSIXct(V1Data$DateTime, format = "%m/%d/%Y %H:%M:%S")

# Format the data, adjust based on field calibration and remove duplicate rows
V1Data <- V1Data%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)-5,VID="V1")%>%
  select(DateTime,PPM,VID)%>%
  distinct()

# Sensor 2
V2Data <- data.frame()
for(i in 1:length(V2Files)){
  file <- V2Files[i]
  data <- read.csv(here::here("FieldData/Vaisala",file),
                   blank.lines.skip = TRUE, header = TRUE)
  V2Data <- rbind(V2Data,data)
}
V2Data$DateTime <- paste0(V2Data$Date," ",V2Data$Time)
V2Data$DateTime <- as.POSIXct(V2Data$DateTime, format = "%m/%d/%Y %H:%M:%S")
V2Data <- V2Data%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)-30,VID="V2")%>%
  select(DateTime,PPM,VID)%>%
  distinct()

# Sensor 3
V3Data <- data.frame()
for(i in 1:length(V3Files)){
  file <- V3Files[i]
  data <- read.csv(here::here("FieldData/Vaisala",file),
                   blank.lines.skip = TRUE, header = TRUE)
  V3Data <- rbind(V3Data,data)
}
V3Data$DateTime <- paste0(V3Data$Date," ",V3Data$Time)
V3Data$DateTime <- as.POSIXct(V3Data$DateTime, format = "%m/%d/%Y %H:%M:%S")
V3Data <- V3Data%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)+17.5,VID="V3")%>%
  select(DateTime,PPM,VID)%>%
  distinct()

# Sensor 4
V4Data <- data.frame()
for(i in 1:length(V4Files)){
  file <- V4Files[i]
  data <- read.csv(here::here("FieldData/Vaisala",file),
                   blank.lines.skip = TRUE, header = TRUE)
  data <- data[,1:5]
  V4Data <- rbind(V4Data,data)
}
V4Data$DateTime <- paste0(V4Data$Date," ",V4Data$Time)
V4Data$DateTime <- as.POSIXct(V4Data$DateTime, format = "%m/%d/%Y %H:%M:%S")
V4Data <- V4Data%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)+17.5,VID="V4")%>%
  select(DateTime,PPM,VID)%>%
  distinct()

# Combine data and make the ID field a factor so it is groupable
VMerge <- rbind(V1Data,V2Data,V3Data,V4Data)%>%
  filter(PPM > 100)%>%
  filter(PPM < 10000)

# Make a simple plot
outPlot <- ggplot(VMerge, aes(x = DateTime, y = PPM, group = VID))+
  geom_point(aes(col=VID), size = .5)
outPlot

write.csv(VMerge, here("data_4_analysis/Vaisala_Stations_AllData.csv"))
