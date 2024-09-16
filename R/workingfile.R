library(tidyverse)
library(here)
raw_data <- read.csv(here('original','maternalmortality.csv'),header=TRUE)
clean_data <- select(raw_data,c('Country.Name','X2000','X2001','X2002','X2003',
                                'X2004','X2005','X2006','X2007','X2008','X2009',
                                'X2010','X2011','X2012','X2013','X2014','X2015',
                                'X2016','X2017','X2018','X2019'))

yr=2000
for (i in 2:ncol(clean_data)) {
  names(clean_data)[i] <- yr
  yr=yr+1
}

pivot_longer(clean_data,c('2000','2001','2002','2003','2004','2005','2006',
                          '2007','2008','2009','2010','2011','2012','2013',
                          '2014','2015','2016','2017','2018','2019'),
             names_to = "Year", values_to="MatMor")
