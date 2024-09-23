library(tidyverse)
library(here)

conflict_raw <- read.csv(here('original','conflictdata.csv'),header=TRUE)

conflict_raw$conflict_bin <- ifelse(conflict_raw$conflict_id!=0, 1,0)

conflict_cleaned <- distinct(conflict_raw,ISO,year,.keep_all = TRUE)