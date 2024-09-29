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
                      covariates) %>% reduce(full_join, by = keys)

# verify 20 obs per country
table(final_dataset$ISO)
## not right, some yrs+countries r duplicated i.e. AFG 2015