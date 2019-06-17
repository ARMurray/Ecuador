library(here)
library(ggplot2)


# Import the Vaisala data for a specific day
V1 <- read.csv(here("FieldData","VB1_06132019.csv"))
V2 <- read.csv(here("FieldData","VB2_06132019.csv"))
V3 <- read.csv(here("FieldData","VB3_06132019.csv"))
V4 <- read.csv(here("FieldData","VB4_06132019.csv"))


# Convert time to POSIXct in a new column called "DateTime"
V1 <- V1[1:5000,]
V1$DateTime <- paste0(V1$Date," ",V1$Time)
V1$DateTime <- as.POSIXct(V1$DateTime, format = "%m/%d/%Y %H:%M:%S")

V2$DateTime <- paste0(V2$Date," ",V2$Time)
V2$DateTime <- as.POSIXct(V2$DateTime, format = "%m/%d/%Y %H:%M:%S")

V3$DateTime <- paste0(V3$Date," ",V3$Time)
V3$DateTime <- as.POSIXct(V3$DateTime, format = "%m/%d/%Y %H:%M:%S")

V4$DateTime <- paste0(V4$Date," ",V4$Time)
V4$DateTime <- as.POSIXct(V4$DateTime, format = "%m/%d/%Y %H:%M:%S")


V1Plot <- ggplot(V1, aes(x = DateTime, y = Volts))+
  geom_line()
V1Plot
