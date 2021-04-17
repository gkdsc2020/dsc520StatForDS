# Assignment: ASSIGNMENT 5.2
# Name: Kale, Ganesh
# Date: 2021-04-17

library(dplyr)
library(readxl)
library(purrr)
library(stringr)


house <- read_excel('week-7-housing.xlsx')
head(house)

# a. Using the dplyr package, use the 6 different operations to analyze/transform the data - GroupBy, Summarize, Mutate, Filter, Select, and Arrange 

#  selecting few columns from the df and saving in another df 
# select()
house1 <- house %>% select(`Sale Date`,`Sale Price`,zip5,bedrooms,sitetype)
head(house1)

# arranging/order house1 by price and number of bedroom desc 
# arrange()
house1 <- house1 %>% arrange(`Sale Price`, desc(bedrooms))
head(house1)
dim(house1)

# created new column as total area by adding square_feet_total_living and sq_ft_lot
# mutate()
head(house %>% mutate(total_area = square_feet_total_living + sq_ft_lot)) %>% select(`Sale Date`,`Sale Price`,total_area,bedrooms,sitetype)


# selecting house price greater than 500K and more than 2 bedrooms
# filter()
head(house1 %>% filter(`Sale Price`>500000, bedrooms >2))

# average sale price and bedroom of house
# summarize()
house1 %>% summarise(avg_price = mean(`Sale Price`), avg_bedrooms = mean(bedrooms))

# summaryof avg sale price by site type
# group_by()
house1 %>% group_by(sitetype) %>% summarise(avg_price = mean(`Sale Price`))

# b. Using the purrr package
# compact()
# discard the null values from the ctyname column
city.name <- house$ctyname %>% compact()
head(city.name )
# discard the year in year_bult which are not between 1964
# discard()
year.bult <- house$year_built %>% keep(function(x) x < 1964)
head(year.bult)

# keep the site type starts with R
# keep()
r.sitetypes <- house$sitetype %>% keep(startsWith,'R')
head(r.sitetypes)

# c. use rbind and cbind function
house$total_area = house$square_feet_total_living + house$sq_ft_lot
# added total_area to df house1 using cbind()
house1 <- house1 %>% cbind(total_area = house$total_area)
head(house1)
# created two dfs based on bedrooms and joined using rbind()
bed4_plus <- house1 %>% filter(bedrooms>=4)
bed3_less <- house1 %>% filter(bedrooms>=4)
# joined these two dfs to one
house.beds <- rbind(bed4_plus,bed3_less)
head(house.beds)

# d.Split a string, then concatenate the results back together
address.list <- str_split(string = house$addr_full,pattern = ' ')
# concatenating addr_full, postalctyn and zip5 to new column for full address
# paste()
house$full_address <- paste(house$addr_full,house$postalctyn,house$zip5,sep = ',')
head(house %>% select(`Sale Date`, `Sale Price`,full_address))


