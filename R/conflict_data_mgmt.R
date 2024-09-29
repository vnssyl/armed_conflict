library(tidyverse)
library(here)

conflict_raw <- read.csv(here('original','conflictdata.csv'),header=TRUE)

conflict_raw$conflict_bin <- ifelse(conflict_raw$best!=0, 1,0)

conflict_cleaned <- distinct(conflict_raw,ISO,year,.keep_all = TRUE)

write.csv(conflict_cleaned,here("data","conflict_clean.csv"))