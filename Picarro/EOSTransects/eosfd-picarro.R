library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

date <- 'aug06'

### Get a list of all the files
Aug6_Files <- list.files(here::here("2019 picarro/08/06"),pattern = '.dat')

#create an empty data.frame
allaug06Data <- read.table(here::here("2019 picarro/08/06",aug06_Files[1]), header= TRUE)


# Combine all aug06 data
for(i in 2:length(aug06_Files)){
  file <- aug06_Files[i]
  data <- read.table(here::here("2019 picarro/08/06",file), header = TRUE)
  allaug06Data <- rbind(allaug06Data,data)
}
#select only the data columns we need 
allaug06Data <- allaug06Data %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)


# Combine Date and time into one column
allaug06Data$DateTime <- paste0(allaug06Data$DATE," ",substr(allaug06Data$TIME,1,8))

# Convert to PosixCT
allaug06Data$PosixCT <- as.POSIXct(allaug06Data$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#Select again the columns we need 
allaug06Data <- allaug06Data %>%
  select(PosixCT, X12CO2, Delta_Raw_iCO2)

#save all data in one file 
write.csv(allaug06Data,here("Picarro/EOSTransects/081319/", "allaug06Data.csv"))


#Do an initial plot of C02 
plot <- ggplot(allAug13Data_cut)+
  geom_point(aes(x= PosixCT, y= X12CO2)) +
  labs(x = "Time", y = "CO2") +
  ggtitle("aug13 EOS Transect Pulls") 
plot

#Do an initial plot of Delta_i 
plot <- ggplot(justsamples23)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2)) +
  labs(x = "Time", y = "Delta_Raw") +
  ggtitle("aug06 EOS Transect Pulls") 
ggplotly(plot)

#Use the C02 graph and excel sheet to find the exact times 

read.csv(here("Picarro/EOSTransects/081319/allAug13Data.csv"))
Aug13 <- read.csv(here("Picarro/EOSTransects/081319/allAug13Data.csv"))

allaug06Data_cut <- allaug06Data[c(70672:98829), ]
allaug06Data_cut <- allaug06Data_cut[c(4109:28158), ]
allaug06Data_cut <- allaug06Data_cut[c(1362:24050), ]


minRow <- Aug13$X[Aug13$Delta_Raw_iCO2 == min(Aug13$Delta_Raw_iCO2[(470:21889)])]

df <- data.frame("Row" = minRow,"Delta" <- Aug13$Delta_Raw_iCO2[minRow])


justsamples23 <- allaug06Data[ which(allaug06Data$PosixCT > "2019-07-23 15:00:00"
                                      & allaug06Data$PosixCT < "2019-07-23 17:00:00"), ]
justsamples17 <- justsamples17[c(1372:8600), ]

#justsamples <- allaug06Data[ which(allaug06Data$PosixCT > "2019-07-17 16:00:00" 
                                    & allaug06Data_cut$PosixCT < "2019-08-13 20:47:00" ), ]

justsamples$sample <- as.character("ECU3")

col1 <- allaug06Data_cut[ which(allaug06Data_cut$PosixCT > "2019-08-13 20:44:00" 
                                & allaug06Data_cut$PosixCT < "2019-08-13 20:47:00" ), ]

mean(justsamples$Delta_Raw_iCO2)


library(git)


?ggplot2-specs

