library(tidyverse)
library(here)

maternal_raw <- read.csv(here('original','maternalmortality.csv'),header=TRUE)
clean_maternal<- select(maternal_raw,c('Country.Name','X2000','X2001','X2002','X2003',
                                'X2004','X2005','X2006','X2007','X2008','X2009',
                                'X2010','X2011','X2012','X2013','X2014','X2015',
                                'X2016','X2017','X2018','X2019'))

yr=2000

for (i in 2:ncol(clean_maternal)) {
  names(clean_maternal)[i] <- yr
  yr=yr+1
}
clean_maternal <- clean_maternal %>%
  pivot_longer(c('2000','2001','2002','2003','2004','2005','2006',
                            '2007','2008','2009','2010','2011','2012','2013',
                            '2014','2015','2016','2017','2018','2019'),
               names_to = "Year", values_to="MatMor")

write.csv(clean_maternal,here('data', "maternalmortality_clean.csv"))


# define fcn to prepare the rest of the mortality datasets

prep_data <- function(input_file, output_file, newVar) {
  data_raw <- read.csv(here('original',input_file),header=TRUE)
  data_clean <- select(data_raw,c('Country.Name','X2000','X2001','X2002','X2003',
                                  'X2004','X2005','X2006','X2007','X2008','X2009',
                                  'X2010','X2011','X2012','X2013','X2014','X2015',
                                  'X2016','X2017','X2018','X2019'))
  yr = 2000
  
  for(i in 2:ncol(data_clean)) {
    names(data_clean)[i] <- yr
    yr = yr+1
  }
  data_clean <- data_clean %>% pivot_longer(c('2000','2001','2002','2003','2004','2005','2006',
                            '2007','2008','2009','2010','2011','2012','2013',
                            '2014','2015','2016','2017','2018','2019'),
               names_to = "Year", values_to=newVar)
  write.csv(data_clean,here('data', output_file))
  return(data_clean)
}


# call fcn

clean_infant <- prep_data("infantmortality.csv","infantmortality_clean",
                          "InfMor")
clean_neonatal <- prep_data("neonatalmortality.csv","neonatalmortality_clean.csv",
                            "NeoMor")
clean_under5 <- prep_data("under5mortality.csv","under5mortality_clean.csv",
                          "Under5Mor")


# join datasets

mor_clean <- full_join(clean_maternal,clean_infant, by=c("Country.Name","Year"))
mor_clean <- full_join(mor_clean,clean_neonatal, by=c("Country.Name","Year"))
mor_clean <- full_join(mor_clean,clean_under5, by=c("Country.Name","Year"))

# add country codes

library(countrycode)
mor_clean$ISO <- countrycode(mor_clean$Country.Name,
                            origin = "country.name",
                            destination = "iso3c")

mor_clean <- subset(mor_clean, select = -Country.Name)

write.csv(mor_clean,here('data', "mortality_clean.csv"))
