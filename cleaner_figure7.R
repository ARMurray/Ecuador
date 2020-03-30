#cleaner code for final figure 7 
library(here)
library(ggplot2)
library(tidyr)
library(dplyr)
library(wesanderson)
library(viridis)
library(grid)
library(gridExtra)


#read in the data 

col1 <- read.csv(here("Picarro/EOSTransects/col1statistics.csv"))
col7 <- read.csv(here("Picarro/EOSTransects/col7statistics.csv"))