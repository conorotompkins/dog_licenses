library(tidyverse)
library(stringr)

#this lets us remove all the objects from the environment
rm(list = ls())

#this adds the csv file to our environment
doggie_data_raw <- read_csv("data/lifetime-dog-licenses.csv")

colnames(doggie_data_raw) <- tolower(colnames(doggie_data_raw))

#take raw data and remove duplicates
doggie_data <- doggie_data_raw %>% 
  filter(!str_detect(licensetype,"Duplicate"))


#create new column for neutered
#column will have yes and no
#yes if licensetype contains neuter or spay
#else no

doggie_data <- doggie_data %>%
  mutate(neutered = if_else(str_detect(licensetype,"Neutered|Spayed"),
                            TRUE,FALSE))
         