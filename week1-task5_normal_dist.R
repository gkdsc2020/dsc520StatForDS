#Date - 03/21/2021
#Author - Ganesh Kale
# Week-1 assignment 1.2
# Plot normal distribution

# generated sequence of numbers with length 1000 
x <- seq(from = -10, to = 10, length.out = 1000)
y <- dnorm(x,mean = 0, sd = 1)

# plot the chart for x and y values
plot(x,y,type = 'l')
title(main = 'Normal Distribution')