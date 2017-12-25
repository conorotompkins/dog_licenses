
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

#This is to get a look at the count of dog breeds that are popular
popular_breeds <- pure_bred_names %>% 
  filter(n > 50) %>% 
    arrange(n)

#Counting all the Lidos
doggie_data %>% 
  filter(str_detect(breed,"CHES")) %>% 
  filter(!str_detect(breed,"MANCHESTER")) %>% 
  count(breed)

#Creating bar chart NOT graph
popular_breeds %>% 
  #mutate(breed=as.factor(breed, levels=n)) %>% 
    ggplot(aes(reorder(breed,n), n)) + geom_col() + coord_flip()


#BIG COMMENT: Adding column for group

#Create csv of unique dog breeds
unique_dog_breeds <- pure_bred_names %>% 
  top_n(20) %>% 
    select(breed)

#save csv file to hard drive
#write.csv(unique_dog_breeds, "unique_dog_breeds.csv")

#write new object for goups csv
top_dog_groups <- read_csv("data/unique_breed_names_grouped.csv")
colnames(top_dog_groups) <- tolower(colnames(top_dog_groups))

#replace Yoy with Toy because CJ is a silly
top_dog_groups <- top_dog_groups %>% 
  mutate(group = str_replace(group,"Yoy","Toy"))

#Joining groups with main list (top_dog_groups with doggie_data)
#doggie_data <- doggie_data %>% 
  #left_join(top_dog_groups)

#filter out NA's
#doggie_data <- doggie_data %>%
    #filter(!is.na(group))

#bar chart for count of dogs in each group
doggie_data %>%
  count(group) %>% 
    ggplot(aes(group,n)) + geom_col() + coord_flip()
