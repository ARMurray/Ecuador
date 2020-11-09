# This script should be used alongside 'metabolism_stn1.R'

fulltime1 <- fulltime1%>%
  filter(solar.time<lubridate::ymd("2020-01-01"))


ggplot(fulltime1)+
  geom_line(aes(x = solar.time, y = DO.obs), color = "red")+
  geom_line(aes(x = solar.time, y = DO.sat), color = "blue")+
  geom_line(aes(x = solar.time, y = depth*10), color = "green")+
  geom_line(aes(x = solar.time, y = temp.water), color = "orange")+
  #geom_line(aes(x = solar.time, y = light), color = "yellow")+
  geom_line(aes(x = solar.time, y = discharge*10), color = "black")

fullLong <- pivot_longer(fulltinme1, )
