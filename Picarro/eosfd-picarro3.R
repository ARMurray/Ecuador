library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

date <- 'july30'

### Get a list of all the files
july30_Files <- list.files(here::here("2019 picarro/07/30"),pattern = '.dat')

#create an empty data.frame
alljuly30Data <- read.table(here::here("2019 picarro/07/30",july30_Files[1]), header= TRUE)


# Combine all july30 data
for(i in 2:length(july30_Files)){
  file <- july30_Files[i]
  data <- read.table(here::here("2019 picarro/07/30",file), header = TRUE)
  alljuly30Data <- rbind(alljuly30Data,data)
}
#select only the data columns we need 
july30 <- july30 %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)


# Combine Date and time into one column
july30$DateTime <- paste0(july30$DATE," ",substr(july30$TIME,1,8))

# Convert to PosixCT
july30$PosixCT <- as.POSIXct(july30$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#Select again the columns we need 
july30 <- july30 %>%
  select(PosixCT, X12CO2, Delta_Raw_iCO2)

#save all data in one file 
write.csv(alljuly30Data,here("Picarro/EOSTransects/081319/", "alljuly30Data.csv"))


#Do an initial plot of C02 
plot <- ggplot(allAug13Data_cut)+
  geom_point(aes(x= PosixCT, y= X12CO2)) +
  labs(x = "Time", y = "CO2") +
  ggtitle("aug13 EOS Transect Pulls") 
plot

#Do an initial plot of Delta_i 
plot <- ggplot(onlyecujuly30)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2)) +
  labs(x = "Time", y = "Delta_Raw") +
  ggtitle("july30 EOS Transect Pulls") 
ggplotly(plot)

#Use the C02 graph and excel sheet to find the exact times 

read.csv(here("Picarro/EOSTransects/081319/allAug13Data.csv"))
Aug13 <- read.csv(here("Picarro/EOSTransects/081319/allAug13Data.csv"))

alljuly30Data_cut <- alljuly30Data[c(70672:98829), ]
alljuly30Data_cut <- alljuly30Data_cut[c(4109:28158), ]
alljuly30Data_cut <- alljuly30Data_cut[c(1362:24050), ]


minRow <- Aug13$X[Aug13$Delta_Raw_iCO2 == min(Aug13$Delta_Raw_iCO2[(470:21889)])]

df <- data.frame("Row" = minRow,"Delta" <- Aug13$Delta_Raw_iCO2[minRow])


justsamples23 <- alljuly30Data[ which(alljuly30Data$PosixCT > "2019-07-23 15:00:00"
                                      & alljuly30Data$PosixCT < "2019-07-23 17:00:00"), ]
justsamples17 <- justsamples17[c(1372:8600), ]

#justsamples <- alljuly30Data[ which(alljuly30Data$PosixCT > "2019-07-17 16:00:00" 
                                    & alljuly30Data_cut$PosixCT < "2019-08-13 20:47:00" ), ]

justsamples$sample <- as.character("ECU3")

col1 <- alljuly30Data_cut[ which(alljuly30Data_cut$PosixCT > "2019-08-13 20:44:00" 
                                & alljuly30Data_cut$PosixCT < "2019-08-13 20:47:00" ), ]

mean(justsamples$Delta_Raw_iCO2)


library(git)


?ggplot2-specs

