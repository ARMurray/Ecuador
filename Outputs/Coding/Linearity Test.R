library(tidyverse)

#Uploading Picarro Table 1 and Organizing Variables
Picarro1<-read.table("C:/Users/nehemiah/Documents/CarbonShed Lab/Linearity Test 2/Picarro0715_1837_1907.txt", header=TRUE)
Time<-Picarro1$TIME
CO2<-Picarro1$X12CO2
Delta<-Picarro1$Delta_Raw_iCO2

#Separating Time and CO2 for Times we Need
write.csv(Time[400:835], row.names = FALSE)
write.csv(CO2[400:835], row.names = FALSE)
write.csv(Delta[400:835], row.names = FALSE)

#Uploading Picarro table 2 and Organizing Variables
Picarro2<-read.table("C:/Users/nehemiah/Documents/CarbonShed Lab/Linearity Test 2/Picarro0715_1907_1937.txt", header = TRUE)
Time<-Picarro2$TIME
CO2<-Picarro2$X12CO2
Delta<-Picarro2$Delta_Raw_iCO2

#Rewriting Times as .Csv File
write.csv(Time[2001:2063], row.names = FALSE)
write.csv(CO2[2001:2063], row.names = FALSE)
write.csv(Delta[2001:2063], row.names = FALSE)

#Uploading Picarro 3
Picarro3<-read.table("C:/Users/nehemiah/Documents/CarbonShed Lab/Linearity Test 2/Picarro0715_1937_2007.txt", header= TRUE)
Time<-Picarro3$TIME
CO2<-Picarro3$X12CO2
Delta<-Picarro3$Delta_Raw_iCO2

#Uploading Delta CO2 Column for Picarro 1 and Converting to .csv File
write.csv(Time[1001:1108], row.names = FALSE)
write.csv(CO2[1001:1108], row.names = FALSE)
write.csv(Delta[1001:1108], row.names = FALSE)

#Uploading Picarro Table 2 and converting Delta to .csv File
Picarro2<-read.table("C:/Users/Nehemiah/Documents/CarbonShed Lab/Data/Linearity Tests/Picarro0611_1823_1853.txt", header=TRUE)
view(Picarro2)
Delta2<-Picarro2$Delta_Raw_iCO2
write.csv(Delta2[1:363], row.names = FALSE)
write.csv(Delta2[364:1364],row.names = FALSE)

#Uploading Picarro Table 3 and Converting Delta to .csv File
Picarro3<-read.table("C:/Users/Nehemiah/Documents/CarbonShed Lab/Data/Linearity Tests/Picarro0611_1853_1923.txt", header= TRUE)
view(Picarro3)
Delta3<-Picarro3$Delta_Raw_iCO2
write.csv(Delta3[1:363], row.names = FALSE)
write.csv(Delta3[364:1362],row.names = FALSE)

#Uploading Piccaro Table 4 and Converting Delta t .csv File
Picarro4<-read.table("C:/Users/Nehemiah/Documents/CarbonShed Lab/Data/Linearity Tests/Picarro0611_1923_1953.txt", header= TRUE)
View(Picarro4)
Delta4<-Picarro4$Delta_Raw_iCO2
e.csv(Delta4[1:363],row.names = FALSE)
write.csv(Delta4[364:1347], row.names = FALSE)

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

#Uploading Picarro Table 2 and Converting Time, CO2, and Delta CO2 to .csv 
Picarro2II<-read.table("C:/Users/Nehemiah/Documents/CarbonShed Lab/Data/Linearity Tests/Linearity Test 2/Picarro0614_1619_1649.dat", header= TRUE)
Time2II<-Picarro2II$TIME
CO22II<-Picarro2II$X12CO2
Delta2II<-Picarro2II$Delta_Raw_iCO2
view(Picarro2II)
write.csv(Time2II[1:500], row.names= FALSE)
write.csv(Time2II[501:1494], row.names = FALSE)
write.csv(CO22II[1:500], row.names = FALSE)
write.csv(CO22II[501:1494], row.names = FALSE)         
write.csv(Delta2II[1:500], row.names = FALSE)
write.csv(Delta2II[501:1494],row.names = FALSE)

#Uploading Picarro Table 3 and Converting Time, CO2, and Delta CO2 to .csv
Picarro3II<-read.table("C:/Users/Nehemiah/Documents/CarbonShed Lab/Data/Linearity Tests/Linearity Test 2/Picarro0614_1649_1720.dat", header= TRUE)
Time3II<-Picarro3II$TIME
CO23II<-Picarro3II$X12CO2
Delta3II<-Picarro3II$Delta_Raw_iCO2
view(Picarro3II)
write.csv(Time3II[1:500], row.names = FALSE)
write.csv(Time3II[501:1490],row.names = FALSE)
write.csv(CO23II[1:500], row.names = FALSE)
write.csv(CO23II[501:1490],row.names = FALSE)
write.csv(Delta3II[1:500], row.names = FALSE)
write.csv(Delta3II[501:1490],row.names = FALSE

