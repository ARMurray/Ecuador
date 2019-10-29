library(tmaptools)
library(ggplot2)
library(here)
library(dplyr)
library(plotly)
library(wesanderson)

#let's call all of the day summaries and combine them into one and call it comboecuavg


aug13 <- read.csv(here("Picarro/EOSTransects/071619/", "Aug13alldayecuavg.csv"))