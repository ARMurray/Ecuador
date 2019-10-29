library(here)
library(ggplot2)
library(tidyverse)

# This is a temporary script meant to correct time stamps for the Vaisala data
# Some of the data re in 12-hour format and some are in 24-hour
# This seems to be related to the data loggers pulling settingfs based on what
# computer they were connected to

# Import the Vaisala data for the date specified above.
V1Files <- list.files(path = here("FieldData/Vaisala"), pattern = "VB1")
V2Files <- list.files(path = here("FieldData/Vaisala"), pattern = "VB2")
V3Files <- list.files(path = here("FieldData/Vaisala"), pattern = "VB3")
V4Files <- list.files(path = here("FieldData/Vaisala"), pattern = "VB4")

### Create an empty data frame
V1Data24 <- data.frame()

# Import files that have 24hour time format
for(i in 1:10){
  file <- V1Files[i]
  data <- read.csv(here::here("FieldData/Vaisala",file),
                   blank.lines.skip = TRUE, header = TRUE)
  data <- data[c(1,2,ncol(data))]   # Some of the files had two extra colums
  V1Data24 <- rbind(V1Data24,data)
}

# Convert time to POSIXct in a new column called "DateTime"
V1Data24$DateTime <- paste0(V1Data24$Date," ",V1Data24$Time)
V1Data24$DateTime <- as.POSIXct(V1Data24$DateTime, format = "%m/%d/%Y %H:%M:%S")

# Import files in AM/PM
V1Data12 <- data.frame()
for(i in 11:24){
  file <- V1Files[i]
  data <- read.csv(here::here("FieldData/Vaisala",file),
                   blank.lines.skip = TRUE, header = TRUE)
  print(paste0(V1Files[i],": ", ncol(data)))
  data <- data[c(1,2,ncol(data))]   # Some of the files had two extra colums
  V1Data12 <- rbind(V1Data12,data)
}
# Convert time to POSIXct in a new column called "DateTime"
V1Data12$DateTime <- paste0(V1Data12$Date," ",V1Data12$Time)
V1Data12$DateTime <- as.POSIXct(V1Data12$DateTime, format = "%m/%d/%Y %I:%M:%S %p")

### Combine Vaisala 1 data
V1Data <- rbind(V1Data24,V1Data12)

# Format the data, adjust based on field calibration and remove duplicate rows
V1Data <- V1Data%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)-5,VID="V1")%>%
  select(DateTime,PPM,VID)%>%
  distinct()


# Vaisala #2: 1-10 are in 24-hour, skipping 11 (VB2_08132019_1min) because I don't know how it
# was created or really where it came from #12 is the only file in AM/PM

V2Data12 <- read.csv(here::here("FieldData/Vaisala/VB2_08152019_1min.csv"))
V2Data12$CO2 <- V2Data12$CO2*10
V2Data12$DateTime <- paste0(V2Data12$Date," ",V2Data12$Time)
V2Data12$DateTime <- as.POSIXct(V2Data12$DateTime, format = "%m/%d/%Y %I:%M:%S %p")

V2Data12 <- V2Data12%>%
  mutate("VID" = "V2")%>%
  select(DateTime,CO2,VID)
colnames(V2Data12) <- c("DateTime","PPM","VID")
V2Data12$PPM <- V2Data12$PPM - 30

# Sensor 2 24 hour data
V2Data <- data.frame()
for(i in 1:10){
  file <- V2Files[i]
  data <- read.csv(here::here("FieldData/Vaisala",file),
                   blank.lines.skip = TRUE, header = TRUE)
  print(paste0(V2Files[i],": ", ncol(data)))
  V2Data <- rbind(V2Data,data)
}

V2Data$DateTime <- paste0(V2Data$Date," ",V2Data$Time)
V2Data$DateTime <- as.POSIXct(V2Data$DateTime, format = "%m/%d/%Y %H:%M:%S")

V2Data <- V2Data%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)-30,VID="V2")%>%
  select(DateTime,PPM,VID)%>%
  distinct()

# The Omega data logger fried (broke) some time on July 22nd
# It appears there was some erratic data recorded prior to 
# it failing all together. The x-axis starts at 16:00 on July 22nd 
# which was a night time injection and ends at July 23rd at 10:25. 
# The injection ended at 19:45 (big drop). The Vaisala readings at 
# Station 1 (red dots) and station 2 begin to diverge at 22:44 on July 22nd.
# We filter out data after 22:00 as non-real data
V2Data <- rbind(V2Data,V2Data12)%>%
  distinct()%>%
  filter(DateTime < as.POSIXct("2019-07-22 22:00:00")|DateTime>as.POSIXct("2019-07-26 00:00:00"))%>% #Omega malfunction
  filter(DateTime < as.POSIXct("2019-08-01 16:30:00")|DateTime>as.POSIXct("2019-08-03 10:30:00"))%>% #Unknown cr300 malfunction
  filter(DateTime < as.POSIXct("2019-08-08 11:36:00")|DateTime>as.POSIXct("2019-08-09 10:05:00"))    #Unknown cr300 malfunction



# Sensor 3

# AM/PM: 11-24
V3Data24 <- data.frame()

# Import files that have 24hour time format
for(i in 1:10){
  file <- V3Files[i]
  data <- read.csv(here::here("FieldData/Vaisala",file),
                   blank.lines.skip = TRUE, header = TRUE)
  data <- data[c(1,2,ncol(data))]   # Some of the files had two extra colums
  V3Data24 <- rbind(V3Data24,data)
}

# Convert time to POSIXct in a new column called "DateTime"
V3Data24$DateTime <- paste0(V3Data24$Date," ",V3Data24$Time)
V3Data24$DateTime <- as.POSIXct(V3Data24$DateTime, format = "%m/%d/%Y %H:%M:%S")

# Import files in AM/PM
V3Data12 <- data.frame()
for(i in 11:24){
  file <- V3Files[i]
  data <- read.csv(here::here("FieldData/Vaisala",file),
                   blank.lines.skip = TRUE, header = TRUE)
  print(paste0(V3Files[i],": ", ncol(data)))
  data <- data[c(1,2,ncol(data))]   # Some of the files had two extra colums
  V3Data12 <- rbind(V3Data12,data)
}
# Convert time to POSIXct in a new column called "DateTime"
V3Data12$DateTime <- paste0(V3Data12$Date," ",V3Data12$Time)
V3Data12$DateTime <- as.POSIXct(V3Data12$DateTime, format = "%m/%d/%Y %I:%M:%S %p")

### Combine Vaisala 1 data
V3Data <- rbind(V3Data24,V3Data12)

# Format the data, adjust based on field calibration and remove duplicate rows
V3Data <- V3Data%>%
  dplyr::mutate(PPM=(Voltage..V. * 10000)+17.5,VID="V3")%>%
  select(DateTime,PPM,VID)%>%
  distinct()







# Sensor 4

# AM/PM: 11-22
V4Data24 <- data.frame()

# Import files that have 24hour time format
for(i in 1:10){
  file <- V4Files[i]
  data <- read.csv(here::here("FieldData/Vaisala",file),
                   blank.lines.skip = TRUE, header = TRUE)
  print(paste0(V4Files[i],": ", ncol(data)))
  data <- data[c(1,2,5)]   # Some of the files had two extra colums
  V4Data24 <- rbind(V4Data24,data)
}

# Convert time to POSIXct in a new column called "DateTime"
V4Data24$DateTime <- paste0(V4Data24$Date," ",V4Data24$Time)
V4Data24$DateTime <- as.POSIXct(V4Data24$DateTime, format = "%m/%d/%Y %H:%M:%S")

# Import files in AM/PM
V4Data12 <- data.frame()
for(i in 11:22){
  file <- V4Files[i]
  data <- read.csv(here::here("FieldData/Vaisala",file),
                   blank.lines.skip = TRUE, header = TRUE)
  print(paste0(V4Files[i],": ", ncol(data)))
  data <- data[c(1,2,ncol(data))]   # Some of the files had two extra colums
  V4Data12 <- rbind(V4Data12,data)
}
# Convert time to POSIXct in a new column called "DateTime"
V4Data12$DateTime <- paste0(V4Data12$Date," ",V4Data12$Time)
V4Data12$DateTime <- as.POSIXct(V4Data12$DateTime, format = "%m/%d/%Y %I:%M:%S %p")

### Combine Vaisala 1 data
V4Data <- rbind(V4Data24,V4Data12)

# Format the data, adjust based on field calibration and remove duplicate rows
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
plotly::ggplotly(outPlot)
write.csv(VMerge, here("data_4_analysis/Vaisala_Stations_AllData_Clean.csv"))
