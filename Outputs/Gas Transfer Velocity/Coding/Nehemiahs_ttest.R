#T tests for 'ol Nehemiah'

install.packages("reshape")
library(reshape)

#set wd
setwd("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/K600_calculations/Nehemiah")


#read in data

df <- read.csv("Kinematic K Versus Effective K.csv")
df$Date <- as.Date(df$Date)


df <- melt(df, id=c("Date","Site","Distance"))

t.test(df$value~df$variable)

boxplot(value~variable,data=df, main="Kinematic K vs Effective K",
        xlab="Method for calculating K", ylab="K (m/d)")
