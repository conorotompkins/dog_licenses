#Objective: Compare dog licenses between neutered and unneutered dogs across breed and gender

#shows percent that are neutered/spayed
doggie_data %>%
  summarize(is_neutered = mean(neutered == TRUE))

#shows percent of each breed that are neutered/spayed
doggie_data %>%
  group_by(breed) %>%
  summarize(is_neutered = mean(neutered == TRUE))

#filter for top 20 breeds - pure and mixed
top_20_breeds <- doggie_data %>%
  group_by(breed) %>%
    summarize(n=n()) %>%
      top_n(20) %>%
        select(breed)

#removes any rows from doggie_data that didn't match in top_20_breeds (Joined by "breed" because it was the only one that matched)
top_20_breeds_neutered <- doggie_data %>%
  inner_join(top_20_breeds)

#shows percentage of top 20 dog breeds that were neutered
top_20_breeds_neutered <- top_20_breeds_neutered %>% 
  group_by(breed) %>%
    summarize(is_neutered = mean(neutered == TRUE)) %>% 
  arrange(is_neutered)

#This associates a column of strings - orders string column by another column (that is something the computer understands, like numbers)
breed_factor <- top_20_breeds_neutered %>% 
  select(breed) %>% 
  unlist()

top_20_breeds_neutered <- top_20_breeds_neutered %>% 
  mutate(breed = factor(breed, levels = breed_factor))
  
#graph it, yo
ggplot(top_20_breeds_neutered,aes(breed,is_neutered)) + geom_col() + coord_flip() + theme_minimal()





