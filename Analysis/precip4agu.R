library(here)
library(ggplot2)
library(dplyr)
library(viridis)
library(plotly)
library(grid)
library(gridExtra)

### load the giant stream file 

allstream <- read.csv(here("data_4_analysis/All_Stream_Data.csv"))

allstream$DateTime <- as.POSIXct(data$DateTime, format = '%Y-%m-%d %H:%M:%OS')

allstream <- allstream%>%
  filter(DateTime > as.POSIXct("2019-07-10 11:30:00") & DateTime < as.POSIXct("2019-08-13 12:15:00"))




# Let's move it to only the times the c6 was on

#c6time <- allstream[c(2479:20893),]
#c6time <- c6time %>%
#  select(DateTime, ppt_mm)
#c6time<- c6time%>%
#  na.omit(ppt_mm)
#c6time$ppt_mm <- as.numeric(as.character(c6time$ppt_mm))


#c6time$DateTime <- as.POSIXct(c6time$DateTime)
#savethis 


#make a table that excludes the co2 injection entirely 


plot5 <- ggplot(allstream)+
  geom_bar(aes(x= DateTime, y = ppt_mm), color = "turquoise4", stat="identity")+
  labs(y=expression(bold("Precip [mm]")), x="")+
  ylim(.0001, .8)
plot5 <- plot5+ theme(axis.text.y= largernumbers, 
                      axis.title.y= largernumbers2, title = largertitle, 
                      axis.text.x=element_blank(),
                      plot.margin=unit(c(1,1,-.25,1), "cm"))

plot5 <- plot5 + scale_y_reverse()+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(fill=NA, colour = "black", size=1.5)) +
  labs(axis.title.y = element_text(face="bold"), axis.title.x = element_blank() ) + 
  theme_bw(base_size = 20) +
  theme(axis.text.y = element_text(size=14), axis.text.x = element_text(size=14), axis.title.x = element_text(face="bold"))+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(fill=NA, colour = "black", size=1.5))
#ggplotly(plot5)

plot5