# Load two packages
library(dplyr)
library(stringr)
library(here)
# Count your lines of R code
list.files(path = here(), recursive = T, full.names = T, pattern = ".Rmd$") %>%
  sapply(function(x) x %>% readLines() %>% length()) %>%
  sum()


files <- list.files(path = here(), recursive = T, full.names = T, pattern = '.R$')
count(files)


# Stats

# .Rmd Files = 42
# .R files = 73
# .R lines = 7,565
# .Rmd = 17,500