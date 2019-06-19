library(here)

# Import the Vaisala data for a specific day
V1 <- read.csv(here("Field Data", "VB1-6_13.csv"))
V2 <- read.csv(here("Field Data", "VB2-6_13.csv"))
V3 <- read.csv(here("Field Data", "VB3-6_13.csv"))
V4 <- read.csv(here("Field Data", "VB4-6_13.csv"))

#Convert time to POSIXct in a new column called "DateTime"

V1$DateTime <-paste0(V1$Date, " ", V1$Time)
V1$DateTime <- as.POSIXct(V1$DateTime, format = "%m/%d/%Y %H:%M:%S")

V2$DateTime <-paste0(V2$Date, " ", V2$Time)
V2$DateTime <- as.POSIXct(V2$DateTime, format = "%m/%d/%Y %H:%M:%S")

V3$DateTime <-paste0(V3$Date, " ", V3$Time)
V3$DateTime <- as.POSIXct(V3$DateTime, format = "%m/%d/%Y %H:%M:%S")

V4$DateTime <-paste0(V4$Date, " ", V4$Time)
V4$DateTime <- as.POSIXct(V4$DateTime, format = "%m/%d/%Y %H:%M:%S")

