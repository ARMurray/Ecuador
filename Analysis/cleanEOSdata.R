#Read in all stream data
library(here)
library(dplyr)
getwd()
all_stream_data <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))

all_stream_data$DateTime <- as.POSIXct(all_stream_data$DateTime, format="%Y-%m-%d %H:%M:%S", tz="UTC")

flux.df <- all_stream_data[,c("DateTime","Inj","Flux_1")]
colnames(flux.df) <- c("DateTime","Inj","Flux_1_cleaned")
#clean data
#2019-07-15 @ 13:15 - flux_1 looks like it is an error. random negative value there
#2019-07-25 @ 11:45 to 16:46 bad data - is this a synoptic day?
#2019-07-29 @ 9:35 to 15:25
#2019-07-31 @ 10:35 to 16:25
#2019-08-06 @10:30 to 16:00
#2019-08-09 @ 10:00 to 10:05
#2019-08-11 @ 4:45 to 2019-08-12 @ 14:45
#2019-08-13 @ 9:00

flux.df <- subset(flux.df, Inj != "Yes")

flux.df <- subset(flux.df,
                  DateTime != as.POSIXct('2019-07-10 13:00:00', tz="UTC"))

flux.df <- subset(flux.df,
                  DateTime != as.POSIXct('2019-07-12 12:40:00', tz="UTC"))

flux.df <- subset(flux.df,
             DateTime != as.POSIXct('2019-07-15 13:15:00', tz="UTC"))

flux.df <- subset(flux.df,
             DateTime < as.POSIXct('2019-07-25 11:45:00', tz="UTC") |
               DateTime > as.POSIXct('2019-07-25 16:46:00', tz="UTC"))
flux.df <- subset(flux.df,
              DateTime < as.POSIXct('2019-07-26 12:50:00', tz="UTC") |
              DateTime > as.POSIXct('2019-07-26 14:50:00', tz="UTC"))
flux.df <- subset(flux.df,
             DateTime < as.POSIXct('2019-07-29 09:35:00', tz="UTC") |
               DateTime > as.POSIXct('2019-07-29 15:25:00', tz="UTC"))
flux.df <- subset(flux.df,
             DateTime < as.POSIXct('2019-07-31 10:35:00', tz="UTC") |
               DateTime > as.POSIXct('2019-07-31 16:25:00', tz="UTC"))
#flux.df <- subset(flux.df,
#              DateTime < as.POSIXct('2019-08-01 16:25:00', tz="UTC") |
#              DateTime > as.POSIXct('2019-08-01 20:25:00', tz="UTC"))

flux.df <- subset(flux.df,
             DateTime != as.POSIXct('2019-08-03 16:00:00', tz="UTC"))
flux.df <- subset(flux.df,
             DateTime < as.POSIXct('2019-08-06 10:30:00', tz="UTC") |
               DateTime > as.POSIXct('2019-08-06 16:00:00', tz="UTC"))
flux.df <- subset(flux.df,
            DateTime < as.POSIXct('2019-08-08 12:40:00', tz="UTC") |
            DateTime > as.POSIXct('2019-08-08 16:20:00', tz="UTC"))

flux.df <- subset(flux.df,
             DateTime < as.POSIXct('2019-08-09 9:56:00', tz="UTC") |
               DateTime > as.POSIXct('2019-08-09 10:15:00', tz="UTC"))
flux.df <- subset(flux.df,
             DateTime < as.POSIXct('2019-08-11 04:45:00', tz="UTC") |
               DateTime > as.POSIXct('2019-08-12 14:45:00', tz="UTC"))

flux.df <- subset(flux.df,
             DateTime < as.POSIXct('2019-08-13 08:15:00', tz="UTC"))



all_stream_data_joined <- full_join(all_stream_data,flux.df, by="DateTime")


flux_1 <- plot_ly(data=all_stream_data_joined, x=~DateTime, y=~Flux_1)


flux_1_ceaned <- plot_ly(data=all_stream_data_joined, x=~DateTime, y=~Flux_1_cleaned)


write.csv(data=all_stream_data_joined, "")

library(plotly)
