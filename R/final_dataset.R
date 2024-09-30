library(tidyverse)
library(here)

covariates <- read.csv(here("original","covariates.csv"))

source(here("R","disaster_file_mgmt.R"))
source(here("R","conflict_data_mgmt.R"))
source(here("R","mortality_data_mgmt.R"))

# rename 'year' variable in conflict/covariates dataset
conflict_cleaned <- rename(conflict_cleaned, 'Year'='year')
covariates <- rename(covariates, 'Year' = 'year')

# convert 'Year' in mortality data from char to int
mor_clean$Year <- as.integer(mor_clean$Year)

# join data
keys <- c("Year","ISO")
final_dataset <- list(conflict_cleaned, disaster_clean, mor_clean, 
                      covariates) %>% reduce(left_join, by = keys)

# fill NAs for 'earthquake','drought', and 'armconf1'
final_dataset %>%
  replace_na(list(earthquake=0, drought=0, armconf1=0))

# verify 20 obs per country
table(final_dataset$ISO)


write.csv(final_dataset,here("data","final_dataset.csv"))