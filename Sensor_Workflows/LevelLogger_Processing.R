library(here)

date <- "07152019"

# LEvel Logger #1

data <- read.csv(here("FieldData/LevelLogger", paste0("lvllgr01", paste0(date,".csv"))), skip = 11)

data$DateTime <- paste0(data$Date," ",data$Time)
data$DateTime <- as.POSIXct(data$DateTime, format = "%m/%d/%Y %I:%M:%OS %p")

lvl <- data%>%
  select(DateTime, LEVEL, TEMPERATURE)

write.csv(lvl, here("Outputs", paste0("lvllgr", date, ".csv")))
