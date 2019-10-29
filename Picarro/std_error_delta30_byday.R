library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#let's call all of the day summaries and combine them into one and call it comboecuavg

july17 <- read.csv(here("Picarro/EOSTransects/071619/", "July17alldayecuavg.csv"))
july23 <- read.csv(here("Picarro/EOSTransects/072219/", "July23alldayecuavg.csv"))
july23$Day <- as.character("July23")
july30 <- read.csv(here("Picarro/EOSTransects/072919/", "July30alldayecuavg.csv"))
aug02 <- read.csv(here("Picarro/EOSTransects/080119/", "Aug02alldayecuavg.csv"))
aug09 <- read.csv(here("Picarro/EOSTransects/080819/", "Aug09alldayecuavg.csv"))
aug13 <- read.csv(here("Picarro/EOSTransects/081319/", "Aug13alldayecuavg.csv"))


comboecuavg <- rbind(july17, july23, july30, aug02, aug09, aug13)