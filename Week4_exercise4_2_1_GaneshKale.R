# Assignment: ASSIGNMENT 4.2 - 1. scores
# Name: Kale, Ganesh
# Date: 2021-04-10

library(pastecs)

############################
# Exercise 4.2.1 - Scores
############################
# load the data set
scores <- read.csv('scores.csv')
head(scores)

# 1.What are the observational units in this study?
# The observational units in this study are students and Grades.

# 2.Identify the variables mentioned in the narrative paragraph and determine which are categorical and quantitative?
# Categorical Variable - Section of the course
# Quantitative Variable - Student Count and Student Scores

# 3. Create one variable to hold a subset of your data set that contains only the Regular Section and one variable for the Sports Section.
# created sports variable to save all scores with section is Sports
# sports <- scores[scores$Section == "Sports",]
sports <- subset(scores,scores$Section=='Sports')
head(sports)
dim(sports)
# created regular variable to save all scores with section is Regular
# regular <- scores[scores$Section == "Regular",]
regular <- subset(scores,scores$Section=='Regular')
head(regular)
dim(regular)

# 4. Use the Plot function to plot each Sections scores and the number of students achieving that scor
# plot for sports section
plot(sports$Score,sports$Count, type = "l", 
     main = 'Sports Section',
     ylab = 'Count', xlab = 'Score', col = 'red')
# plot for regular section
plot(regular$Score,regular$Count, type = "l", 
     main = 'Regular Section',
     ylab = 'Count', xlab = 'Score', col = 'blue')
#  plot both section together to compare
plot(sports$Score, sports$Count,col = 'blue', type = 'l', main = 'Students Scores', ylab = 'Count', xlab = 'Score')
     points(regular$Score,regular$Count, col = 'red', type = 'l')

# Comparing and contrasting the point distributions between the two section, looking at both tendency and consistency: Can you say that one section tended to score more points than the other? 
#  Based mean and median values we can say that students with Regular section tended to more scores as compared to students from Sports section
# The mean and median of scores justifies this. Mean and median of students from Regular section is greater that sports section 
mean(sports$Score)
mean(regular$Score)
median(sports$Score)
median(regular$Score)


# Did every student in one section score more points than every student in the other section? If not, explain what a statistical tendency means in this context.
# Not every student from one section scored more than other section,  
# We can measure the distribution of data or central tendency using mean, mode and median but when it comes to the
# two groups comparison then all of these should be equal but we can not determine the tendency of data by just comparing
# these values within two groups.

# What could be one additional variable that was not mentioned in the narrative that could be influencing the point distributions between the two sections?
# I think the the data set has count meaning number of students and scores they received for specific section,
# but here one variable missing is course total, we do not have info about student received score out of what number.









