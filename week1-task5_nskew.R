#Date - 03/21/2021
#Author - Ganesh Kale
# Week-1 assignment 1.2
# Plot Negative skewed distribution

# created vector with some random values
x <- c(15,20,3,1,20,10,16,15,6,18,20,19,19,20,4,18,19,17,19,7,18,20,19,20,18,12,15,11,14,20,13,18,20)

# plot density chart
plot(density(x))
title(sub = 'Negatively Skewed Distribution')
