library(tidyverse)
library(here)

# Load dataset 
disaster_raw <- read.csv(here('original','disaster.csv'),header=TRUE)

disaster_clean <- filter(disaster_raw, Year %in% 2000:2019, Disaster.Type %in% c('Earthquake', 'Drought'))
disaster_clean <- dplyr::select(disaster_clean, c('Year', 'ISO', 'Disaster.Type')) %>%
  mutate(drought = if_else(Disaster.Type == 'Drought', 1, 0)) %>%
  mutate(earthquake = if_else(Disaster.Type == 'Earthquake', 1, 0))

disaster_clean <- disaster_clean %>% group_by(Year, ISO) %>%
  summarise(drought = max(drought), earthquake = max(earthquake))

# Write CSV file
write.csv(disaster_clean,here('data','disaster_clean.csv'))