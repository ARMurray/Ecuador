library(imputeTS)
library(tidyverse)
library(lubridate)

df <- data.frame(date = c("2019-07-18","2019-07-25","2019-07-31","2019-08-06","2019-08-12"),
                 flux1 = c(0.6025,0.8050,0.3225,0.6650,0.8575))%>%
  mutate(date = ymd(date))


fulltime <- data.frame(date = seq(ymd("2019-07-18"),ymd("2019-08-12"), by="1 day"))%>%
  left_join(df)%>%
  na_interpolation(option = 'linear', maxgap = Inf)

# Plot
ggplot()+
  geom_point(data = fulltime, aes(x = date, y = flux1), color = 'black')+
  geom_point(data = df, aes(x = date, y = flux1), color = 'red', size = 3)
