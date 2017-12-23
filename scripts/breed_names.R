library(tidyverse)
library(stringr)

#this lets us remove all the objects from the environment
#rm(list = ls())

#this adds the csv file to our environment
doggie_data_raw <- read_csv("data/lifetime-dog-licenses.csv")

colnames(doggie_data_raw) <- tolower(colnames(doggie_data))

#take raw data and remove duplicates
doggie_data <- doggie_data_raw %>% 
  filter(!str_detect(licensetype,"Duplicate"))

#This is to create a list of dog count based on breed with filter on breed name
#mix_names <- doggie_data %>%
  #filter(str_detect(breed, "MIX")) %>% 
    #count(breed)
#View(mix_names)
#rm(mix_names)

#This is to get a count of all dogs based on breed
all_breed_counts <- doggie_data %>% 
  count(breed) %>% 
  arrange(desc(n))


#This is to get a count of dogs based on breed with filter to exclude mixes
pure_bred_names <- doggie_data %>% 
  filter(!str_detect(breed,"MIX")) %>% 
  count(breed) %>% 
  arrange(desc(n))

#This is to get a look at the count of dog breeds that are rare
rare_breeds <- pure_bred_names %>% 
  filter(n < 2)
View(rare_breeds)

#This is to get a look at the count of dog breeds that are popular
popular_breeds <- pure_bred_names %>% 
  filter(n > 500)

#Counting all the Lidos
doggie_data %>% 
  filter(str_detect(breed,"CHES")) %>% 
  filter(!str_detect(breed,"MANCHESTER")) %>% 
  count(breed)

#Creating bar chart NOT graph
ggplot(popular_breeds, aes(breed,n)) +
  geom_col()


#BIG COMMENT: Adding column for group

#Create csv of unique dog breeds
unique_dog_breeds <- pure_bred_names %>% 
  top_n(50) %>% 
    select(breed)

#save csv file to hard drive
write.csv(unique_dog_breeds, "unique_dog_breeds.csv")

