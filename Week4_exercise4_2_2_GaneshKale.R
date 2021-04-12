# Assignment: ASSIGNMENT 4.2 - 2. Housing Dataset
# Name: Kale, Ganesh
# Date: 2021-04-10
library(readxl)
library(ggplot2)
library(qqplotr)
library(plyr)


house <- read_excel('week-7-housing.xlsx')
head(house)
# 1. Use the apply function on a variable in your dataset
# get the average sale price and square feet of lot using apply function
apply(house[,c('Sale Price','sq_ft_lot')],2,mean)
# get the maximum sale price and square feet of lot using apply function
apply(house[,c('Sale Price','sq_ft_lot')],2,max)
# get the minimum sale price and square feet of lot using apply function
apply(house[,c('Sale Price','sq_ft_lot')],2,min)

# 2. Use the aggregate function on a variable in your dataset
# get the average price and average lot area of houses from each zip and site type
aggregate(cbind(`Sale Price`,sq_ft_lot) ~ zip5 + sitetype, house, mean)
# get the average sale price for each sale reason 
aggregate(`Sale Price`~ sale_reason, house, mean)
# get the average sale price for each sale instrument
aggregate(`Sale Price`~ sale_instrument, house, mean)

# 3. Use the plyr function on a variable in your dataset – more specifically, I want to see you split some data, perform a modification to the data, and then bring it back together
# get the summary of housing data using ddply
# created new column as sale_month from Sale Date
house$sale_month <- month(house$`Sale Date`)
house.summary <- ddply(house,.(sale_month), summarise,
                       avg.sale_price = mean(`Sale Price`),
                       sd.sale_price = sd(`Sale Price`),
                       avg.square_ft_living = mean(square_feet_total_living),
                       avg.square_ft_lot = mean(sq_ft_lot)
                       )
head(house.summary)

# 4. Check distributions of the data
# distribution of sale price using ggplot2, the sale price distribution is positively skewed
plt0 <- ggplot(house, aes(x=`Sale Price`))
plt1 <- plt0 + geom_histogram(color = 'green', fill = 'blue', alpha = 0.5
                              , aes(y = ..density..))
plt2 <- plt1 + xlab('Sale Price') + ylab('Count') + ggtitle('House Sale Price')
plt3 <- plt2 + stat_function(fun = dnorm, args = list(mean = mean(house$`Sale Price`,na.rm = T), sd = sd(house$`Sale Price`,na.rm = T)),color='red')
plt3


# 5. Identify if there are any outliers
# identify outliers in Sale price using box plot for each area
# from histogram also we can see there are outliers in the Sale Price and below box plot shows outliers exist in sale price
pl0 <- ggplot(data=house, aes(x = as.factor(zip5),y=`Sale Price`)) + geom_boxplot(fill = 'slateblue',alpha=0.4)
pl1 <- pl0  + xlab('Zip Codes') + ylab('Sale Price') + ggtitle('House Sale Price per Zip Code')
pl1

# using scatter plot, we can see year built 1900 with few houses, this could be typo issue
pl0 <- ggplot(data=house, aes(x=year_built, y=`Sale Price`)) + geom_point(color = 'blue', alpha=0.4)
pl0

# 6. Create at least 2 new variables
# new column created to see total house area by adding living are + lot area
house$total_area <- house$square_feet_total_living + house$sq_ft_lot
# new column to see if house renovated or not, if year exist then yes else no
any(is.na(house$year_renovated))  # to check if na value exist
house$is_renovated <- ifelse(house$year_renovated>0, "Yes", "No")







