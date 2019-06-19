library(here)

date <- "06182019"

data <- read.csv(here("FieldData", paste0("lvllgr", date, "rogersroad.csv")), skip = 11)

write.csv(data, here("Outputs", paste0("lvllgr", date, "rogersroad.csv")))
