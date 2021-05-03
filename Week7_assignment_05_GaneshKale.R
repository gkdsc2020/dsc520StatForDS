# Assignment: ASSIGNMENT 5
# Name: Ganesh Kale
# Date: 2021-05-02

library(ggplot2)
library(ggm)

## Set the working directory to the root of your DSC 520 directory
# setwd("/home/jdoe/Workspaces/dsc520")

## Load the `data/r4ds/heights.csv` to
heights_df <- read.csv("dsc520/data/r4ds/heights.csv")
head(heights_df,2)
## Using `cor()` compute correlation coefficients for
## height vs. earn
cor(heights_df$height,heights_df$earn)
### age vs. earn
cor(heights_df$age,heights_df$earn)
### ed vs. earn
cor(heights_df$ed,heights_df$earn)

## Spurious correlation
## The following is data on US spending on science, space, and technology in millions of today's dollars
## and Suicides by hanging strangulation and suffocation for the years 1999 to 2009
## Compute the correlation between these variables
tech_spending <- c(18079, 18594, 19753, 20734, 20831, 23029, 23597, 23584, 25525, 27731, 29449)
suicides <- c(5427, 5688, 6198, 6462, 6635, 7336, 7248, 7491, 8161, 8578, 9000)
cor(tech_spending,suicides)

# -----------------------------------------------------------------------------------
## Assignment 7.2 #2 Student Survey

# load the student survey data

students <- read.csv('dsc520/data/student-survey.csv')
head(students)

# 1.Use R to calculate the covariance of the Survey variables and provide an explanation of why you would use this calculation and what the results indicate.
# for all the variables
cov(students)

# Time spent on Reading vs Watching TV
cov(students$TimeReading,students$TimeTV)
# ggplot(data=students, aes(x=TimeReading,y=TimeTV)) + geom_point()
# The covariance between TimeReading and TimeTV is negative with value -20, which is low number so its weak negative covariance
# which tells watching tv reduces the reading time but the scale/units of both of 
# these variables are different minutes and hours, so we can not compare covariance in an objective way, its not measured on standardized scale.

# 2. What measurement is being used for the variables? 

# TimeReading - Time of reading is measured in hours.
# TimeTV - Time spent to watch TV is measured in minutes
# Happiness - It seems happiness score has been measured on scale 1-10 scale and transformed to percentage.
# Gander - This is binary variable and measurement has been converted to 0 for Female and 1 for Male.

# Explain what effect changing the measurement being used for the variables would have on the covariance calculation. 

# changing TimeReading to minutes and then checking the covariance for TimeReading vs TimeTV

students$TimeReading_mins <- students$TimeReading * 60
cov(students$TimeTV,students$TimeReading_mins)

# When changed Time spent on reading from hours to minute the covariance value increased 
# from -20 to -1222,which is large number, this explains there is strong negative relationship between these variables.That means more students watch TV will spend less time in reading.
# Since we can say larger the covariance stronger the relationship but there is not exact number to tell how much large value to 
# say there is strong relationship.
# when we compare -20 with -1222 definitely we can say that changing the scale of variables gives correct covariance between them.

# Would this be a problem? Explain and provide a better alternative if needed.
# Yes, If two variables do not have same scales, then we cannot truly assume the covariance value to gauge the relationship between the variables.
# This problem can be fixed by dividing the covariance by standard deviation, which gives us Correlation Coefficient.

# 3. Choose the type of correlation test to perform, explain why you chose this test, and make a prediction if the test yields a positive or negative correlation?
# Pearson's Correlation Test will be performed to see the correlation between TimeReading and TimeTV.
# The Pearson's Correlation test is used to see the correlation of two continuous variables, because TimeReading and TimeTV are continuous variables.
# Based on the covariance result we can say that the Pearson's correlation will result negative correlation between TimeReading and TimeTV.

# 4. Perform a correlation analysis 
# 4.1. All Variables

cor(students)

# 4.2. A single correlation between two a pair of the variable

cor(students$TimeReading,students$TimeTV,method = "pearson")
cor(students$TimeReading,students$Happiness,method = "pearson")
cor(students$TimeReading,students$Gender,method = "kendall")
cor(students$TimeTV,students$Happiness,method = "pearson")
cor(students$TimeTV,students$Gender,method = "kendall")
cor(students$Happiness,students$Gender,method = "kendall")

# 4.3. Repeat your correlation test in step 2 but set the confidence interval at 99%

cor.test(students$TimeReading,students$TimeTV,method = "pearson",alternative = "less",conf.level = 0.99)
cor.test(students$TimeReading,students$Happiness,method = "pearson",conf.level = 0.99)
cor.test(students$TimeReading,students$Gender,method = "kendall",conf.level = 0.99)
cor.test(students$TimeTV,students$Happiness,method = "pearson",conf.level = 0.99)
cor.test(students$TimeTV,students$Gender,method = "kendall",conf.level = 0.99)
cor.test(students$Happiness,students$Gender,method = "kendall",conf.level = 0.99)

# 4.4. Describe what the calculations in the correlation matrix suggest about the relationship between the variables. 
# Be specific with your explanation.
# The TimeReading is negatively related to the TimeTV with r value = -0.883067681, we can say that students spending more time watching TV spending less time reading.
# The TimeReading and Happiness negatively related, r = -0.4348663, Students are spending more time reading are less happy.
# The TimeTV and Happiness are positively related, r = 0.6365560, students watch more TV are more happy.


# 5.Calculate the correlation coefficient and the coefficient of determination, describe what you conclude about the results.
# correlation coefficient
cor(students$TimeReading,students$TimeTV,method = "pearson")
#  These two variables TimeReading and TimeTV are negatively correlated, Students who spend more time watching TV getting less time for eading.

# coefficient of determination
cor(students$TimeReading,students$TimeTV,method = "pearson")^2
# The Coefficient of Determination is  =  0.78 or 78%, this means students time spent on watching TV causing 78% variation in time spent on reading. 
# There is still 22% variability to be accounted for other variables causing less time for reading.

# 6.Based on your analysis can you say that watching more TV caused students to read less? Explain.
# No, There is correlation between TimeReading and TimeTV, because correlation does not imply causation.
# There could be third factor that impacting student to read less, here correlation does not show the direction of causality.
# This statistics does not tell us that reading less causing watching more TV.

# 7.Pick three variables and perform a partial correlation, documenting which variable you are “controlling”. Explain how this changes your interpretation and explanation of the results.
# The 3 variables  - TimeReading, TimeTV and Happiness
# Happiness is the variable we are going to control to see if high happiness impacting the time to read and watch TV

pc <- pcor(c('TimeReading','TimeTV','Happiness'),var(students))
pc
pc^2
pcor.test(pc,1,11)

# Based on partial correlation value -0.87, tells that there negative correlation between these two variables when controling the Happiness, which is almost same as correlation value -0.88.
# The R squared of Partial COrrelation is 0.76 or 76%, that means students time spent on watching TV causing 76% variation in time spent on reading, which is similar to R-squared value 78%.
# The p value is less than 0.05 means the correlation is statistically significant.
# We do not see significant difference in correlation and partial correlation value after controlling the students happiness 

