## Francesca Scarabel, 15.11.2017
# script create_learning2014
#  
# the meaning of the combined variable is available at the webpage
# http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt

# load table data
learning2014 <-  read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header = TRUE, sep = "\t")

# dimension of the table:
dim(learning2014)

# both dimension and structure:
str(learning2014)

# create new dataset
# install.packages("dplyr")
library(dplyr)

# combine variables into deep
deep_qu <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
deep_col <- select(learning2014, one_of(deep_qu))
learning2014$deep <- rowMeans(deep_col)

# combine variables into stra 
stra_qu <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
stra_col <- select(learning2014,one_of(stra_qu))
learning2014$stra <- rowMeans(stra_col)

# combine variables into surf
surf_qu <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
surf_col <- select(learning2014, one_of(surf_qu))
learning2014$surf <- rowMeans(surf_col)

# choose columns:
columns <- c("gender","Age","Attitude","deep","stra","surf","Points")

# create new dataset
new_lrn14 <- select(learning2014,columns)

# select only positive points 
# (and check that the right number of entries is left)
new_lrn14 <- filter(new_lrn14, Points>0)
str(new_lrn14)

# rename columns coherently
str(new_lrn14)
colnames(new_lrn14)[2] <- "age"
colnames(new_lrn14)[3] <- "attitude"
colnames(new_lrn14)[7] <- "points"

# choose working directory and save table
setwd("~/GitHub/IODS-project")
write.csv(new_lrn14, file="learning2014")
# read table (and make sure to print all the entries)
options(max.print=2000)
read.csv("learning2014")

