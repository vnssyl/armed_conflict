library(tidyverse)
library(here)

# load dataset
conflict_raw <- read.csv(here('original','conflictdata.csv'),header=TRUE)

# generate dummy var to identify conflict 1 - Yes, 0 - No
conflict_raw$armconf1 <- ifelse(conflict_raw$best!=0, 1,0)

# retain distinct years, drop conflict_id
conflict_cleaned <- distinct(conflict_raw,ISO,year,.keep_all = TRUE)
conflict_cleaned <- subset(conflict_cleaned, select = -(conflict_id))

write.csv(conflict_cleaned,here("data","conflict_clean.csv"))