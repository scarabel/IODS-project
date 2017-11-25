## Francesca Scarabel, 26.11.2017
# script create_human
# data wrangling in preparation of RStudio Exercise 5
#
# the dataset for this exercise are available at
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv


# load the data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# explore structure and dimension
str(hd)
dim(hd)

str(gii)
dim(gii)

# summaries of the variables
summary(hd)
summary(gii)

# rename variables
colnames(hd) <- c("hdi_rk", "country","hdi","exp_life","exp_school","mean_school","gni","rk_dif")
str(hd)
colnames(gii) <- c("gii_rk","country","gii","mat_mort","ado_birth","parl","eduF","eduM","labF","labM")
str(gii)

# mutate "genger inequality" and create variables "ratio"
library(dplyr)
edu_ratio <- gii$eduF/gii$eduM
lab_ratio <- gii$labF/gii$labM
gii <- mutate(gii,edu_ratio,lab_ratio)
str(gii)

# join the datasets by country
human <- inner_join(hd, gii, by = "country")
str(human)

# save table
setwd("~/GitHub/IODS-project/data")
write.csv(human, file="human")
# read table
read.csv("human")
