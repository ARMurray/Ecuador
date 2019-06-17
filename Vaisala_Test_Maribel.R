library(here)

# Import the Vaisala data for a specific day
V1 <- read.csv(here("Field Data","Vbox1-6_13.csv"))
V2 <- read.csv(here("Field Data","Vbox2-6_13.csv"))
V3 <- read.csv(here("Field Data","Vbox3-6_13.csv"))
V4 <- read.csv(here("Field Data","Vbox4-6_13.csv"))

try<- V1
try$Date <-as.POSIXct(as.character(try$Date))

V1$DateTime <-paste0(V1$Date," ", V1$Time)
V2$DateTime <-as.POSIXct(V2$DateTime, format = "%m/%d/%Y %H:%M:%OS")
V3$DateTime <-as.POSIXct(V3$DateTime, format = "%m/%d/%Y %H:%M:%OS")
V4$DateTime <-as.POSIXct(V4$DateTime, format = "%m/%d/%Y %H:%M:%OS")
V1$DateTime <-as.POSIXct(V1$DateTime, format = "%m/%d/%Y %H:%M:%OS")
