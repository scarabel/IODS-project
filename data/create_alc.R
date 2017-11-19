## Francesca Scarabel, 19.11.2017
# script create_alc
# RStudio Exercise 3 - data wrangling
#
# the dataset for this exercise is taken from the webpage
# https://archive.ics.uci.edu/ml/datasets/Student+Performance
#  

# load table data
setwd("~/GitHub/IODS-project/data")
stud_math <-  read.table("student-mat.csv", sep = ";" , header=TRUE)
stud_por <- read.table("student-por.csv", sep = ";" , header=TRUE)

# explore structure and dimension
str(stud_math)
dim(stud_math)

str(stud_por)
dim(stud_por)

# join the datasets
library(dplyr)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(stud_math, stud_por, by = join_by, suffix = c(".math", ".por"))
str(math_por)
dim(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(stud_math)[!colnames(stud_math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

colnames(alc)

# create a new column "alc_use" by avaraging 
# alcohol consumption during weekdays ("Dalc") and weekends ("Walc")
alc <- mutate(alc,alc_use = rowMeans(select(alc,c("Dalc","Walc"))))

# create column high_use if alc_use is greater than 2
alc <- mutate(alc, high_use = (alc$alc_use>2))
alc$high_use

# check that the new database contains the correct data and has the correct dimension
glimpse(alc)
dim(alc)

colnames(alc)

# save table
setwd("~/GitHub/IODS-project/data")
write.csv(alc, file="alc")
# read table
read.csv("alc")
