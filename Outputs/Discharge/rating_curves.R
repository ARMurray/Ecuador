library(ggplot2)
library(tidyverse)
library(here)

df <- read.csv(here("Outputs/Discharge/discharge_prelim.csv"))

# Reformat the dates
df$Month <- sapply(strsplit(as.character(df$Date),"-"), '[',2)
df$Month <- paste0("0",match(df$Month,month.abb))

df$Day <- sapply(strsplit(as.character(df$Date),"-"), '[',1)

df$Year <- "2019"

# Make the dates POSIXct
df$Posix <- as.POSIXct(paste0(df$Year,"-",df$Month,"-",df$Day),format = "%Y-%m-%d")

# Clean up the table
df <- df%>%
  select(Posix,Discharge.m.3.s.,Water.Level..m.,Station)
  colnames(df) <- c("Date","Discharge_m","Level_m","Station")

df$Station <- as.factor(df$Station)

# Plot Everything
plot <- ggplot(df)+
  geom_point(aes(x = Discharge_m, y = Level_m, color = as.factor(Date), shape = Station ), size=3)
plot
