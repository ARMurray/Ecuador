library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)
library(viridis)
library(grid)
library(gridExtra)

#load everything in 

sumaug13 <- read.csv(here("Picarro/EOSTransects/081319/sumaug13_30sec_corrected.csv"))
sumjuly17 <- read.csv(here("Picarro/EOSTransects/071619/sumjuly17_30sec_corrected.csv"))
sumjuly23 <- read.csv(here("Picarro/EOSTransects/072219/sumjuly23_30sec_corrected.csv"))
sumjuly30 <- read.csv(here("Picarro/EOSTransects/072919/sumjuly30_30sec_corrected.csv"))
sumaug02 <- read.csv(here("Picarro/EOSTransects/080119/sumaug02_30sec_corrected.csv"))
sumaug09 <- read.csv(here("Picarro/EOSTransects/080819/sumaug09_30sec_corrected_1aug09.csv"))

sumaug13$day <- as.character("Aug13")
sumjuly17$day <- as.character("July17")
sumjuly23$day <- as.character("July23")
sumjuly30$day <- as.character("July30")
sumaug02$day <- as.character("Aug02")
sumaug09$day <- as.character("Aug09")

sumalltransects <- rbind(sumaug13, sumjuly17, sumjuly23, sumjuly30, sumaug02, sumaug09)

#make a dataframe for each individual collar, find the collar avg and std deviation, and the coefficient of variation and relative standard deviation 
#save this 


col1 <- sumalltransects[ which(sumalltransects$Sample == "col1"), ]
col1 <- col1 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col1total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col1$CorrectedAverage), "StdDev_iCO2" = sd(col1$CorrectedAverage))
col1 <- rbind(col1, col1total)
col1$CV <- col1$StdDev_iCO2/col1$CorrectedAverage
col1$RelativeStdDev <- 100*(col1$StdDev_iCO2/abs(col1$CorrectedAverage))

write.csv(col1, here("Picarro/EOSTransects/", "col1statistics.csv"))

col2 <- sumalltransects[ which(sumalltransects$Sample == "col2"), ]

col2 <- col2 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col2total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col2$CorrectedAverage), "StdDev_iCO2" = sd(col2$CorrectedAverage))
col2 <- rbind(col2, col2total)
col2$CV <- col2$StdDev_iCO2/col2$CorrectedAverage
col2$RelativeStdDev <- 100*(col2$StdDev_iCO2/abs(col2$CorrectedAverage))

write.csv(col2, here("Picarro/EOSTransects/", "col2statistics.csv"))

col3 <- sumalltransects[ which(sumalltransects$Sample == "col3"), ]

col3 <- col3 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col3total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col3$CorrectedAverage), "StdDev_iCO2" = sd(col3$CorrectedAverage))
col3 <- rbind(col3, col3total)
col3$CV <- col3$StdDev_iCO2/col3$CorrectedAverage
col3$RelativeStdDev <- 100*(col3$StdDev_iCO2/abs(col3$CorrectedAverage))

write.csv(col3, here("Picarro/EOSTransects/", "col3statistics.csv"))

col4 <- sumalltransects[ which(sumalltransects$Sample == "col4"), ]

col4 <- col4 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col4total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col4$CorrectedAverage), "StdDev_iCO2" = sd(col4$CorrectedAverage))
col4 <- rbind(col4, col4total)
col4$CV <- col4$StdDev_iCO2/col4$CorrectedAverage
col4$RelativeStdDev <- 100*(col4$StdDev_iCO2/abs(col4$CorrectedAverage))

write.csv(col4, here("Picarro/EOSTransects/", "col4statistics.csv"))

col5 <- sumalltransects[ which(sumalltransects$Sample == "col5"), ]

col5 <- col5 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col5total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col5$CorrectedAverage), "StdDev_iCO2" = sd(col5$CorrectedAverage))
col5 <- rbind(col5, col5total)
col5$CV <- col5$StdDev_iCO2/col5$CorrectedAverage
col5$RelativeStdDev <- 100*(col5$StdDev_iCO2/abs(col5$CorrectedAverage))

write.csv(col5, here("Picarro/EOSTransects/", "col5statistics.csv"))

col6 <- sumalltransects[ which(sumalltransects$Sample == "col6"), ]

col6 <- col6 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col6total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col6$CorrectedAverage), "StdDev_iCO2" = sd(col6$CorrectedAverage))
col6 <- rbind(col6, col6total)
col6$CV <- col6$StdDev_iCO2/col6$CorrectedAverage
col6$RelativeStdDev <- 100*(col6$StdDev_iCO2/abs(col6$CorrectedAverage))

write.csv(col6, here("Picarro/EOSTransects/", "col6statistics.csv"))

col7 <- sumalltransects[ which(sumalltransects$Sample == "col7"), ]

col7 <- col7 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col7total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col7$CorrectedAverage), "StdDev_iCO2" = sd(col7$CorrectedAverage))
col7 <- rbind(col7, col7total)
col7$CV <- col7$StdDev_iCO2/col7$CorrectedAverage
col7$RelativeStdDev <- 100*(col7$StdDev_iCO2/abs(col7$CorrectedAverage))

write.csv(col7, here("Picarro/EOSTransects/", "col7statistics.csv"))

col8 <- sumalltransects[ which(sumalltransects$Sample == "col8"), ]

col8 <- col8 %>%
  select(Sample, day, CorrectedAverage, StdDev_iCO2)
col8total <- data.frame("Sample"= "Total", "day" = "total", "CorrectedAverage" = mean(col8$CorrectedAverage), "StdDev_iCO2" = sd(col8$CorrectedAverage))
col8 <- rbind(col8, col8total)
col8$CV <- col8$StdDev_iCO2/col8$CorrectedAverage
col8$RelativeStdDev <- 100*(col8$StdDev_iCO2/abs(col8$CorrectedAverage))

write.csv(col8, here("Picarro/EOSTransects/", "col8statistics.csv"))


#ok now let's make a table that just has the totals for every collar 

col1total <- col1[ which(col1$Sample == "Total"), ]
col1total$Sample <- as.character("col1")
col2total <- col2[ which(col2$Sample == "Total"), ]
col2total$Sample <- as.character("col2")
col3total <- col3[ which(col3$Sample == "Total"), ]
col3total$Sample <- as.character("col3")
col4total <- col4[ which(col4$Sample == "Total"), ]
col4total$Sample <- as.character("col4")
col5total <- col5[ which(col5$Sample == "Total"), ]
col5total$Sample <- as.character("col5")
col6total <- col6[ which(col6$Sample == "Total"), ]
col6total$Sample <- as.character("col6")
col7total <- col7[ which(col7$Sample == "Total"), ]
col7total$Sample <- as.character("col7")
col8total <- col8[ which(col8$Sample == "Total"), ]
col8total$Sample <- as.character("col8")

allcollarCV <- rbind(col1total, col2total ,col3total, col4total, col5total, col6total, col7total, col8total)

write.csv(allcollarCV, here("Picarro/EOSTransects/" , "allcollarstatistics.csv"))


#alright the easy thing to do from here is the per collar, so let's start that
#the datafram col# is the one we need 
#alright first we need to take the total off of each 
col1 <- col1[c(1:6),]
col2 <- col2[c(1:6),]
col3 <- col3[c(1:6),]
col4 <- col4[c(1:6),]
col5 <- col5[c(1:6),]
col6 <- col6[c(1:6),]
col7 <- col7[c(1:6),]
col8 <- col8[c(1:5),]


#plotting time 

#make a legend function

get_legend<-function(myggplot){
  tmp <- ggplot_gtable(ggplot_build(myggplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}

largernumbers <- element_text(face = "bold", size = 12)
largernumbers2 <- element_text(face = "bold", size = 10)
legend <- get_legend(plot1)



#orange - #de7f00, #e69200
#red #ef0000
#darker blue #2d88a4
#light blue #58a2b5
#green #b0bb4e




