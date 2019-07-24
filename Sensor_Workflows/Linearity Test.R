library(tidyverse)

#Uploading Picarro Table 1 and Organizing Variables
Picarro1<-read.table("C:/Users/nehemiah/Desktop/Ecuador/data_4_analysis/Picarro0715_2007_2038.txt", header=TRUE)
Time<-Picarro1$TIME
CO2<-Picarro1$X12CO2
Delta<-Picarro1$Delta_Raw_iCO2

#Separating Time and CO2 for Times we Need
write.csv(Time[1501:2064], row.names = FALSE)
write.csv(CO2[1501:2064], row.names = FALSE)
write.csv(Delta[1501:2064], row.names = FALSE)

#Uploading Picarro table 2 and Organizing Variables
Picarro2<-read.table("C:/Users/nehemiah/Desktop/Ecuador/data_4_analysis/Picarro0715_2038_2108.txt", header = TRUE)
Time<-Picarro2$TIME
CO2<-Picarro2$X12CO2
Delta<-Picarro2$Delta_Raw_iCO2

#Rewriting Times as .Csv File
write.csv(Time[2001:2064], row.names = FALSE)
write.csv(CO2[2001:2064], row.names = FALSE)
write.csv(Delta[2001:2064], row.names = FALSE)

#Uploading Picarro 3
Picarro3<-read.table("C:/Users/nehemiah/Desktop/Ecuador/data_4_analysis/Picarro0715_2108_2138.txt", header= TRUE)
Time<-Picarro3$TIME
CO2<-Picarro3$X12CO2
Delta<-Picarro3$Delta_Raw_iCO2

#Uploading Delta CO2 Column for Picarro 1 and Converting to .csv File
write.csv(Time[2001:2064], row.names = FALSE)
write.csv(CO2[2001:2064], row.names = FALSE)
write.csv(Delta[2001:2064], row.names = FALSE)

#Uploading Piccaro Table 4 and Converting Delta t .csv File
Picarro4<-read.table("C:/Users/nehemiah/Desktop/Ecuador/data_4_analysis/Picarro0715_2138_2208.txt", header= TRUE)
Time<-Picarro4$TIME
CO2<-Picarro4$X12CO2
Delta<-Picarro4$Delta_Raw_iCO2

write.csv(Time[727:1137], row.names = FALSE)
write.csv(CO2[727:1137], row.names = FALSE)
write.csv(Delta[727:1137], row.names = FALSE)

#Linearity Test 2 June 14th
#Uploading Picarro Table 1 and Converting Time, CO2, and Delta CO2 to .csv
Picarro1II<-read.table("C:/Users/Nehemiah/Documents/CarbonShed Lab/Data/Linearity Tests/Linearity Test 2/Picarro0614_1549_1619.dat", header= TRUE)
TimeII<-Picarro1II$TIME
CO2II<-Picarro1II$X12CO2
DeltaII<-Picarro1II$Delta_Raw_iCO2
write.csv(TimeII[1:500],row.names = FALSE)
write.csv(TimeII[501:1480], row.names = FALSE)
write.csv(CO2II[1:500], row.names = FALSE)
write.csv(CO2II[501:1480],row.names = FALSE)
write.csv(DeltaII[1:500], row.names = FALSE)
write.csv(DeltaII[501:1480],row.names = FALSE)

eos1<-eos1$eos1[50:135]


