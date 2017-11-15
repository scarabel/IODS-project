## Francesca Scarabel, 15.11.2017
# Exercise 2

# I first load the dataset from the folder IODS-project and save it with name "students2014".
setwd("~/GitHub/IODS-project")
options(max.print=2000)
students2014 <- read.csv("learning2014")

dim(students2014)

str(students2014)



# Plot the results
# Access the gglot2 library
library(ggplot2)
install.packages("ggplot2")

summary(students2014$gender)


p <- ggpairs(learning2014, mapping = aes(col=gender), lower = list(combo = wrap("facethist", bins = 20)))


p1 <- ggplot(students2014, aes(x = points, y = deep, col=gender))
p2 <- p1 + geom_point() + geom_smooth(method="lm") + ggtitle("Student's attitude versus deep learning")
p2

p3 <- ggplot(students2014, aes(x = points, y = surf, col=gender)) + geom_point() + geom_smooth(method="lm") + ggtitle("Student's attitude versus deep learning")
p3

p4 <- ggplot(students2014, aes(x = points, y = stra, col=gender)) + geom_point() + geom_smooth(method="lm") + ggtitle("Student's attitude versus deep learning")
p4

