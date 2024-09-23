library(tidyverse)
library(here)
raw_data <- read.csv(here('original','disaster.csv'),header=TRUE)

clean_data <- filter(raw_data, Year >= 2000 & Year <= 2019,
                     Disaster.Type== "Earthquake" | Disaster.Type == "Drought")

clean_data <- clean_data %>% 
  select("Year","ISO","Disaster.Type")

clean_data$earthquake <- ifelse(clean_data$Disaster.Type=="Earthquake",1,0)
clean_data$drought <- ifelse(clean_data$Disaster.Type == "Drought",1,0)

write.csv(clean_data,here('data','disaster_clean.csv'))