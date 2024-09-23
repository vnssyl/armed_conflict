library(tidyverse)
library(here)

covariates <- read.csv(here("original","covariates.csv"))

source(here("R","disaster_file_mgmt.R"))
source(here("R","conflict_data_mgmt.R"))
source(here("R","mortality_data_msgmt.R"))

