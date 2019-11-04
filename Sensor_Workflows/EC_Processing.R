library(here)
library(dplyr)

# Station 1
EC1 <- read.csv(here("FieldData/EC/Last_Collection/EC1_2019-08-14.csv"),
                skip = 2, blank.lines.skip = TRUE, header = FALSE)

EC1 <- EC1[,2:4]
colnames(EC1) <- c("DateTime","uS","Temp_C")

### Convert time from factor to POSIXct
EC1$DateTime <- as.POSIXct(as.character(EC1$DateTime),
                                format = '%m/%d/%y %I:%M:%OS %p')

EC1 <- EC1[complete.cases(EC1), ]%>%
  mutate(Station = "1")

# Station 2
EC2 <- read.csv(here("FieldData/EC/Last_Collection/EC2_2019-08-14.csv"),
                skip = 2, blank.lines.skip = TRUE, header = FALSE)
EC2 <- EC2[,2:4]
colnames(EC2) <- c("DateTime","uS","Temp_C")
EC2$DateTime <- as.POSIXct(as.character(EC2$DateTime),
                           format = '%m/%d/%y %I:%M:%OS %p')
EC2 <- EC2[complete.cases(EC2), ]%>%
  mutate(Station = "2")

# Station 4
EC3 <- read.csv(here("FieldData/EC/Last_Collection/EC3_2019-08-14.csv"),
                skip = 2, blank.lines.skip = TRUE, header = FALSE)
EC3 <- EC3[,2:4]
colnames(EC3) <- c("DateTime","uS","Temp_C")
EC3$DateTime <- as.POSIXct(as.character(EC3$DateTime),
                           format = '%m/%d/%y %I:%M:%OS %p')
EC3 <- EC3[complete.cases(EC3), ]%>%
  mutate(Station = "4")

allEC <- rbind(EC1,EC2,EC3)

allEC$Temp_C <- allEC$Temp_C - 32*(5/9)

write.csv(allEC, here("data_4_analysis/all_EC.csv"))
