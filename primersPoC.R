library(readr)
library(dplyr)
library(stringr)

source("functions.R")

# loading data

p5 <- read_tsv(file = "data/data_base/P5_in.csv")
p7 <- read_tsv(file = "data/data_base/P7_in.csv")

p5.names <- removeP5andP7FromNames((p5$Name))
p7.names <- removeP5andP7FromNames(unlist(p7$Name))

returnNValidCombinations(p5.names, p7.names)
