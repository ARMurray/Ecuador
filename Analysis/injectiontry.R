library(here)
# eos2 inbetween station 2 and 3 from 15:20 7/25 to 10:00 7/29

eos1 <- read.csv(here("FieldData/EosFD/eos1_FIX_07312019.csv"))
eos1$DateTime <- as.POSIXct(eos1$DateTime, format = "%Y-%m-%d %H:%M:%OS")

eos2 <- read.csv(here("FieldData/EosFD/eos2_07312019.csv"))
eos2$Year <- paste0("20",eos2$Year)
eos2$dateTime <- as.POSIXct(as.character(paste0(eos2$Month,"/",eos2$Day,"/",eos2$Year," ",eos2$Time)), format = "%m/%d/%Y %H:%M:%OS")
eos2 <- eos2%>%
  select(dateTime,Flux,Temperature..C.,CO2.Soil..ppm..,
         CO2.Soil.STD..ppm.,CO2.ATM..ppm.,CO2.ATM.STD..ppm.,Mode)
colnames(eos2) <- c("DateTime","Flux_eos2","Temp_C_eos2","CO2_Soil_ppm_eos2","CO2_Soil_STD_ppm_eos2",
                    "CO2_ATM_ppm_eos2","CO2_ATM_STD_ppm_eos2","Mode")


select1 <- eos1[1891:2303,]
row.names(select1) <- NULL

select2 <- eos2[1197:1592,]
row.names(select2) <- NULL

plot <- ggplot() + geom_point(data = select1, aes(x= DateTime, y= Flux_1), color = "blue", size = 2) +
  geom_point(data = select2, aes(x= DateTime, y= Flux_eos2), color = "red", size = 2)
plot

# m <- merge(select1, select2 ), combine keepking only shared times?
