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

## save table
# setwd("~/GitHub/IODS-project/data")
# write.csv(human, file="human")
# read table
# human <- read.csv("human")

## second part:
library(tidyr)
library(stringr)
library(dplyr)

# mutate the gni column as numeric

human$gni <- str_replace(human$gni, pattern=",", replace ="") %>% as.numeric
str(human$gni)

# keep only the relevant columns. With the names I am using, these are
keep <- c("country","edu_ratio","lab_ratio","mean_school","exp_life","gni","mat_mort","ado_birth","parl")

human <- dplyr::select(human,one_of(keep))

# I rename the columns for coherency with the DataCamp exercise,
# descriptions are available in the metafile
# https://raw.githubusercontent.com/TuomoNieminen/Helsinki-Open-Data-Science/master/datasets/human_meta.txt

colnames(human) <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# delete rows with missing values
human <- filter(human,complete.cases(human))
str(human)

# remove data that relates to regions instead of countries
tail(human$Country, n=10)
human <- human[1:(nrow(human)-7),]

# Define the row names of the data by the country names 
# and remove the country name column from the data.
rownames(human) <- human$Country
human <- select(human,-Country)
dim(human)

## save table
setwd("~/GitHub/IODS-project/data")
write.csv(human, file="human", row.names = TRUE)
# read table
human2 <- read.csv("human", row.names=TRUE)
