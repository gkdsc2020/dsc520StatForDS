#Date - 03/21/2021
#Author - Ganesh Kale
# Week-1 assignment 1.2
# Plot positive skewed distribution

# created vector with some random values
x <- c(1,2,3,1,2,10,6,5,4,3,2,1,1,2,4,5,1,7,9,7,3,2,1,1,4,12,15,11,4,2,13,18,20)

# plot density chart
plot(density(x))
title(sub  = 'Positively Skewed Distribution')
