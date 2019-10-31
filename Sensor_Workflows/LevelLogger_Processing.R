library(here)
library(dplyr)
library(ggplot2)

paths <- list.files(here("FieldData/LevelLogger/Last_Collection/"),pattern = ".csv", full.names = TRUE)
files <- list.files(here("FieldData/LevelLogger/Last_Collection/"),pattern = ".csv", full.names = FALSE)


df <- read.csv(paths[1])
df <- df%>%
  mutate(DateTime = as.POSIXct(paste0(df$Date," ",df$Time), format = "%m/%d/%Y %H:%M:%OS"),
         Serial = substr(files[1],7,13))%>%
  select(DateTime,LEVEL_m,TEMP_c,Serial)

for(n in 2:length(files)){
  file <- read.csv(paths[n])
  file$DateTime <- as.POSIXct(paste0(file$Date," ",file$Time), format = "%m/%d/%Y %H:%M:%OS")
  file$Serial <- substr(files[n],7,13)
  file <- file%>%
    select(DateTime,LEVEL_m,TEMP_c, Serial)
  df <- rbind(df,file)
}

write.csv(df, here("FieldData/LevelLogger/WaterLevel_All.csv"))

plot <- ggplot(df)+
  geom_point(aes(x = DateTime, y = LEVEL_m, group = Serial, color = Serial))

plot
