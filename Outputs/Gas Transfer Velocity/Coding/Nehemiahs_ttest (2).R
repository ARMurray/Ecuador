#T tests for 'ol Nehemiah'

install.packages("reshape")
library(reshape)
library(ggplot2)
library(here)

#set wd
setwd("C:/Users/whitm/OneDrive - University of North Carolina at Chapel Hill/Ecuador/K600_calculations/Nehemiah")



#read in data

df <- read.csv(here("Outputs/Gas Transfer Velocity/Effective K/Kinematic K Versus Effective K.csv"))

df$Date <- as.Date(df$Date)
df$Date_ascharacter <- as.character(df$Date)

df <- melt(df, id=c("Date","Site","Distance"))

df.outlierRemoved <- subset(df, value < 600)
df.outlierRemoved$Date_ascharacter <- as.character(df.outlierRemoved$Date)

#stats
#first ,assumptions

hist(df.outlierRemoved$value[df.outlierRemoved$variable=="Kkin"])
hist(df.outlierRemoved$value[df.outlierRemoved$Date=="2019-07-18"])
hist(df.outlierRemoved$value)

#Welch's test below (but don't use bc the data doesn't meet assumptions)
t.test(df.outlierRemoved$value~df.outlierRemoved$variable)


##Wilcox test is a non-paramtric ttest.
#subset data so that you can run wilcox test for each data (surly there is a more elegant way to do this)
july18 <- subset(df.outlierRemoved, Date=="2019-07-18")
july25 <- subset(df.outlierRemoved, Date=="2019-07-25")
july31 <- subset(df.outlierRemoved, Date=="2019-07-31")
Aug6 <- subset(df.outlierRemoved, Date=="2019-08-06")
Aug12 <- subset(df.outlierRemoved, Date=="2019-08-12")


wilcox.test(df.outlierRemoved$value~df.outlierRemoved$variable)
wilcox.test(july18$value~july18$variable)
wilcox.test(july25$value~july25$variable)
wilcox.test(july31$value~july31$variable)
wilcox.test(Aug6$value~Aug6$variable)
wilcox.test(Aug12$value~Aug12$variable)



##plot
#lot's of options to play around with below

# I like this one:
g<-ggplot(df.outlierRemoved, aes(x=variable, y=value,fill=Date_ascharacter)) +
  geom_boxplot(show.legend = FALSE) + 
  facet_wrap(~Date_ascharacter)+
  
  labs(title= "Kinematic K vs Effective K by Date",
       y="K (m/d)", x = "")+
  theme_bw()
g



#you can play with other one's too

boxplot(value~variable,data=df.outlierRemoved, main="Kinematic K vs Effective K",
        xlab="Method for calculating K", ylab="K (m/d)")

boxplot(value~variable*Date, data=df.outlierRemoved, notch=TRUE,
        col=(c("gold","darkgreen")),
        main="Tooth Growth", xlab="Suppliment and Dose")


p <- ggplot(df, aes(x=variable, y=value)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=4)



g<-ggplot(df.outlierRemoved, aes(x=variable, y=value,fill=Date_ascharacter)) +
  geom_boxplot(show.legend = FALSE) + 
  facet_wrap(~Date_ascharacter)+

  labs(title= "Kinemativ K vs Effective K by Date",
       y="K (m/d)", x = "")+
  theme_bw()
g




