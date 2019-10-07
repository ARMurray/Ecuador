library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

date <- 'aug09'

### Get a list of all the files
aug09_Files <- list.files(here::here("2019 picarro/08/09"),pattern = '.dat')

#create an empty data.frame
allaug09Data <- read.table(here::here("2019 picarro/08/09",aug09_Files[1]), header= TRUE)


# Combine all aug09 data
for(i in 2:length(aug09_Files)){
  file <- aug09_Files[i]
  data <- read.table(here::here("2019 picarro/08/09",file), header = TRUE)
  allaug09Data <- rbind(allaug09Data,data)
}
#select only the data columns we need 
aug09 <- aug09 %>%
  select(DATE, TIME, X12CO2, Delta_Raw_iCO2)


# Combine Date and time into one column
aug09$DateTime <- paste0(aug09$DATE," ",substr(aug09$TIME,1,8))

# Convert to PosixCT
aug09$PosixCT <- as.POSIXct(aug09$DateTime, format = '%Y-%m-%d %H:%M:%OS')

#Select again the columns we need 
aug09 <- aug09 %>%
  select(PosixCT, X12CO2, Delta_Raw_iCO2)

#save all data in one file 
write.csv(allaug09Data,here("Picarro/EOSTransects/081319/", "allaug09Data.csv"))


#Do an initial plot of C02 
plot <- ggplot(allAug13Data_cut)+
  geom_point(aes(x= PosixCT, y= X12CO2)) +
  labs(x = "Time", y = "CO2") +
  ggtitle("aug13 EOS Transect Pulls") 
plot

#Do an initial plot of Delta_i 
plot <- ggplot(onlyecuaug09)+
  geom_point(aes(x= PosixCT, y= Delta_Raw_iCO2)) +
  labs(x = "Time", y = "Delta_Raw") +
  ggtitle("aug09 EOS Transect Pulls") 
ggplotly(plot)

#Use the C02 graph and excel sheet to find the exact times 

read.csv(here("Picarro/EOSTransects/081319/allAug13Data.csv"))
Aug13 <- read.csv(here("Picarro/EOSTransects/081319/allAug13Data.csv"))

allaug09Data_cut <- allaug09Data[c(70672:98829), ]
allaug09Data_cut <- allaug09Data_cut[c(4109:28158), ]
allaug09Data_cut <- allaug09Data_cut[c(1362:24050), ]


minRow <- Aug13$X[Aug13$Delta_Raw_iCO2 == min(Aug13$Delta_Raw_iCO2[(470:21889)])]

df <- data.frame("Row" = minRow,"Delta" <- Aug13$Delta_Raw_iCO2[minRow])


justsamples23 <- allaug09Data[ which(allaug09Data$PosixCT > "2019-07-23 15:00:00"
                                      & allaug09Data$PosixCT < "2019-07-23 17:00:00"), ]
justsamples17 <- justsamples17[c(1372:8600), ]

#justsamples <- allaug09Data[ which(allaug09Data$PosixCT > "2019-07-17 16:00:00" 
                                    & allaug09Data_cut$PosixCT < "2019-08-13 20:47:00" ), ]

justsamples$sample <- as.character("ECU3")

col1 <- allaug09Data_cut[ which(allaug09Data_cut$PosixCT > "2019-08-13 20:44:00" 
                                & allaug09Data_cut$PosixCT < "2019-08-13 20:47:00" ), ]

mean(justsamples$Delta_Raw_iCO2)


library(git)


?ggplot2-specs

