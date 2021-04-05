# Assignment: ASSIGNMENT 3.3 American Community Survey Exercise
# Name: Kale, Ganesh
# Date: 2021-04-02

# load the libraries 
library(ggplot2)
library(qqplotr)
library(pastecs)

# load the data set 

acs <- read_csv('data/acs-14-1yr-s0201.csv')

# get first 6 records of data set
head(acs)

# What are the elements in your data (including the categories and data types)?
str(acs)

# Please provide the output from the following functions: str(); nrow(); ncol()
nrow(acs)
ncol(acs)

# Create a Histogram of the HSDegree variable using the ggplot2 package.

plt0 <- ggplot(acs, aes(x=HSDegree))
plt1 <- plt0 + geom_histogram(bins = 20, color = 'green', fill = 'blue', alpha = 0.5)
plt <- plt1 + xlab('HSDgree') + ylab('HSDgree Count') + ggtitle('American Community Survey')
plt

#Include a normal curve to the Histogram that you plotted.

plt0 <- ggplot(acs, aes(x=HSDegree))
plt1 <- plt0 + geom_histogram(bins = 20, color = 'green', fill = 'blue', alpha = 0.5
                              , aes(y = ..density..))
plt2 <- plt1 + xlab('HSDgree') + ylab('HSDgree Count') + ggtitle('American Community Survey')
plt3 <- plt2 + stat_function(fun = dnorm, args = list(mean = mean(acs$HSDegree,na.rm = T), sd = sd(acs$HSDegree,na.rm = T)),color='red')
plt3

# Create a Probability Plot of the HSDegree variable.

plt0 <- ggplot(acs, aes(sample = HSDegree))
plt1 <- plt0 + stat_qq_point(size=1, alpha = 0.4, color = 'blue')
plt1 + stat_qq_line(color='red')


# description, rounded numbers to 4
round(stat.desc(acs['HSDegree'],basic = T, desc = T, norm = T),4)
