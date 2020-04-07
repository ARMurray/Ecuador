library(tidyverse)
library(pracma)
library(ggplot2)


#Calculating Discharge for 6/18
#Uploading Sontek Measurement 1, 2 and MM data
Son1<-read.csv("D:/CarbonShed Lab/Discharge Data/Flow Measurements- Rogers Road- 06_18_2019 - Sontek Measurement 1- Downstream (Past the Inject).csv", header= TRUE)
Son2<-read.csv("D:/CarbonShed Lab/Discharge Data/Flow Measurements- Rogers Road- 06_18_2019 - Sontek 2- Downstream (Past the Inject) - Copy.csv", header= TRUE)
MM1<-read.csv("D:/CarbonShed Lab/Discharge Data/Flow Measurements- Rogers Road- 06_18_2019 - Marsh McBernie- Downstream (Past the Inject).csv", header = TRUE)
view(MM1)
view(Son1)

#Creating Area Column in MM, Son1, and Son2 Data
MM1$Area<-MM1$Depth..cm.*20
AreaM<-MM1$Area
VelocityM<-MM1$Velocity..cm.s.
Son1$Area<-Son1$Depth..cm.*20
Son2$Area<-Son2$Depth..cm.*20
AreaS1<-Son1$Area
AreaS2<-Son2$Area
VelocityS1<-Son1$Velocity
VelocityS2<-Son2$Velocity

#Extra Tools in R
#Creating Difference in Length Measurements and Placing in New Data Table
newData <- data.frame()
for(n in 2:nrow(MM1)) {
  L2<- MM1$Length.of.Measurement..cm.[n]
  L1<-MM1$Length.of.Measurement..cm.[n-1]
  Output<-L2-L1
  print(Output)
  new<-rbind(newData,Output)
}
data.frame(new)
colnames(newData)<- "Length Diff"
view(new)
#Matching Up Column Size of New Data Table with MM1 Data Table Size
MM1 <- MM1[2:8,]
view("Length Diff.")

#Merging Both Data Tables
merge <- cbind(MM1,newData)

#Creating Area Column
MM1$Area<-merge$depthDiff*merge$Depth..cm.
view(MM1)

#Discharge Station 1 July 10th, 2019
Station1<-read.csv("C:/Users/nehemiah/Documents/CarbonShed Lab/Discharge Data/Ecuador Discharge Sheet.csv", header= TRUE)
Area<-Station1$Area
Velocity<-Station1$V
int<-trapz(Area[1:13], Velocity[1:13])
int
#Discharge Station 1= .03775 meter^3/s

#Discharge Station 2 Aug 1st, 2019
Station2<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/FieldData/EC/EC_3_07122019_INJECTION.csv", header= TRUE)
Area2<-Station2$Area2[1:11]
Velocity2<-Station2$V2
int<-trapz(Area2[1:11], Velocity2[1:11])
int

##Same for Station 2
Station2 <- read.csv("C:/Users/nehemiah/Desktop/Ecuador/FieldData/EC/EC_Logger_2_071452019SALTSLUG.csv", header = TRUE)

#Create new Column of Seconds from Zero
Station2$TimeLapse<-as.integer(rownames(Station2))-1
Station2$TimeLapsesec<-Station2$TimeLapse*60

plot<-ggplot(Station2)+geom_line(aes(x=Station2$TimeLapsesec,y=Station2$Full.Range...S.cm..LGR.S.N..20636127..SEN.S.N..20636127.))
plot
int<-trapz(Station2$TimeLapsesec[51:101],Station2$Full.Range...S.cm..LGR.S.N..20636127..SEN.S.N..20636127.[51:101])
int

## Read Salt Slug Data from YSI for Station 3 
SaltSlug<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/FieldData/YSI Data/V20808SS.csv", header= TRUE)

# Get rid of garbage second and third rows
SaltSlug <- SaltSlug[3:nrow(SaltSlug),]

# Convert time to posixCT
SaltSlug$Date.Time <- as.POSIXct(as.character(SaltSlug$Date.Time), format = '%m/%d/%Y %H:%M')

# Convert conductivity from factor to integer
SaltSlug$SpCond <-as.integer(as.character(SaltSlug$SpCond))

# Create a new column representing seconds from zero
SaltSlug$row <- as.integer(rownames(SaltSlug))-3

#Plot
plot<-ggplot(SaltSlug) + geom_line(aes(x=Date.Time, y=SpCond))
plot

# Integrate
Int<-trapz(SaltSlug$row[713:1200],SaltSlug$SpCond[713:1200])
Int

##Read Salt Slug Data From EC
Station4<-read.csv("C:/Users/nehemiah/Desktop/Ecuador/FieldData/EC/EC_3_07122019_INJECTION.csv")

#Convert time to PosixCt
Station4$Date.Time<- as.POSIXct(as.character(Station4$Date.Time),format = '%m/%d/%Y %H:%M')

#Create new column of seconds from zero
Station4$TimeLapse<-as.integer(rownames(Station4))-1
Station4$TimeLapseSec<-Station4$TimeLapse*60

#Integrate
Int<-trapz(x=Station4$TimeLapseSec[60:125],Station4$Full.Range...S.cm.[60:125])
Int
#94743- Station 4 July 12th, 2019
plot<-ggplot(Station4)+geom_line(aes(x=Station4$TimeLapse,y=Station4$Full.Range...S.cm.))
plot

