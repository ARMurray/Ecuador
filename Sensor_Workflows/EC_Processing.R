library(here)
library(dplyr)

EC1_files <-  intersect(list.files(here("FieldData/EC"),pattern = "EC_1"), list.files(here("FieldData/EC"),pattern = ".csv"))
EC2_files <-  intersect(list.files(here("FieldData/EC"),pattern = "EC_2"), list.files(here("FieldData/EC"),pattern = ".csv"))
EC3_files <-  intersect(list.files(here("FieldData/EC"),pattern = "EC_3"), list.files(here("FieldData/EC"),pattern = ".csv"))

