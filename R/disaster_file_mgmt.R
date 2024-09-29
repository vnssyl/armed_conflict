library(tidyverse)
library(here)

# Load dataset 
disaster_raw <- read.csv(here('original','disaster.csv'),header=TRUE)

# Filter by year and disaster type
disaster_clean <- filter(disaster_raw, Year >= 2000 & Year <= 2019,
                     Disaster.Type== "Earthquake" | Disaster.Type == "Drought")

# Select variables
disaster_clean <- disaster_clean %>% 
  select("Year","ISO","Disaster.Type")

# Create dummy var for earthquake and drought
disaster_clean$earthquake <- ifelse(disaster_clean$Disaster.Type=="Earthquake",1,0)
disaster_clean$drought <- ifelse(disaster_clean$Disaster.Type == "Drought",1,0)

# Write CSV file
write.csv(disaster_clean,here('data','disaster_clean.csv'))