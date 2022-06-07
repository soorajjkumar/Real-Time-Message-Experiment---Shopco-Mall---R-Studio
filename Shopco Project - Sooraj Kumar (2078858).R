################################################################################
#                            CLASS PROJECT
################################################################################

# This was a class project for the MGT585 course

# Name: Sooraj Kumar (2078858)

# This script is based on the Shopco data- Shopco is a mall operator
# I have used the Shopco caselet and data (consumer.csv,  purchase.csv) 
# I have used the knowledge from MGT585 that I have learned so far

################################################################################
#                                  MGT585
################################################################################

# I have learnt the following concepts in MGT585 which will all be implemented 
#in this project:

# Basic functions in R
# DPLYR
# Summary stats
# Viz. using GGPLOT
# Regression
# Classification
# Clustering (Session 8)

################################################################################
#                                    Data
################################################################################

library(dplyr)
library(ggplot2)

# Let's read the data in: consumer and purchase tables

# setting my working directory and use read.csv() to read files
setwd("G:/Data/DePaul MsBA/Winters'22/Fundamentals of Business Analytics")
consumer_data<- read.csv("consumer.csv")
purchase_data<- read.csv("purchase.csv")
################################################################################

# Let's first start with exploring various tables

# will explore consumer table using 5 functions
# hint: loyalty status 1 is low and 2 is high
# age is in years
dim(consumer_data)

str(consumer_data)

colnames(consumer_data)

head(consumer_data)

tail(consumer_data)


# Now will explore purchase table using 5 functions
# Hint: real time message 1 is received and 0 is not received
# Sales are in $ dollars
dim(purchase_data)

str(purchase_data)

colnames(purchase_data)

head(purchase_data)

tail(purchase_data)



################################################################################
# We will now correct the data types in consumer table #

# correct gender as a factor
consumer_data$gender <- as.factor(consumer_data$gender)

# correct loyalty_status as a factor
consumer_data$loyalty_status <- as.factor(consumer_data$loyalty_status)

# correct the data types in purchase table #

# correct realtime_message as a factor
purchase_data$realtime_message <- as.factor(purchase_data$realtime_message)

################################################################################
#                         Descriptive Analytics
################################################################################

# let's look at one table at a time: consumer table #

# continuous variables #
# Will show what is the average age of consumer by gender

consumer_data %>% group_by(gender) %>% summarize(mean(age))

# categorical variables #

# How many consumers are female and male

consumer_data %>% group_by(gender) %>% summarize(n())

# How many consumers are there in each loyalty_status

consumer_data %>% group_by(loyalty_status) %>% summarize(n())

# what can I conclude about consumers of Shopco: 
#Around 64% of the consumers fall in the high loyalty status. Majority of the consumers are female with average age 30-32.
################################################################################

# Now, let's look at the second table : purchase  #

# continuous variables #

# How much, on an average, customers spend on second trip onwards

summary(purchase_data$from_second_store_sales)

# categorical variables #
# How many customers received realtime_message

table(purchase_data$realtime_message)

# About the real time mobile experiment in the Shopco mall:

#Total number of consumers were divided in two halves, with one half whom real time messages were sent. The average amount spent on 2nd store onwards is 34.65 dollars.

################################################################################
# Next, let's see what impacts sales

# before that, we will combine consumer and purchase data using inner join
# Using inner_join() on consumer_id create a new data frame called experiment

experiment <- consumer_data %>% inner_join(purchase_data, by="consumer_id")

# Lets see how many number of rows are there in the experiment table:
dim(experiment)

# There are 9032 rows and 6 columns in experiment data frame.

################################################################################
#                                  Predictive analytics
################################################################################
#                                    Regression
################################################################################

# Now, let's run regression to see what impacts sales from second store onwards

# Lets look at the impact of age on sales from second store onwards

# We will visualize using scatter plot

ggplot(experiment,aes(x=age,y=from_second_store_sales))+ geom_point() +geom_smooth(method = lm, se = FALSE)+ggtitle("Impact of Age on Sales")+xlab("Age")+ylab("Second Store Sales")

# We will run regression using lm()
reg1<- lm(from_second_store_sales ~ age, data = experiment)
summary(reg1)

# dummy variable regression

# what is the impact of realtime mobile message on sales from second store onwards

# We will visualize using bar chart
ggplot(experiment, aes(x=realtime_message, y= from_second_store_sales, fill= realtime_message)) +geom_bar(stat = "identity")+ggtitle("Impact of Real Time Message on Sales")+xlab("Real Time Message")+ylab("Second Store Sales")

# We will run regression using lm()

reg2<- lm(from_second_store_sales ~ realtime_message, data = experiment)
summary(reg2)

# What are the managerial implications:
#We can analyze from the visualization that there is an increased amount of sales for the consumers, who have received real time messages.However, only 0.004% of the sales is defined by real_time_message1.
################################################################################
#                                    Clustering
################################################################################

#Last, let's run clustering to find clusters of different customers
set.seed(1234)
# We will use kmeans() to run cluster analysis on age and sales on second store onwards
# we know from experience that there are three clusters
cluster_1 <- kmeans(experiment[, c("age","from_second_store_sales")],3, nstart = 20)

cluster_1
# Lets visualize using ggplot()

cluster_1$cluster <- as.factor(cluster_1$cluster)

# Lets visualize clusters

ggplot(experiment, aes(age, from_second_store_sales, color = cluster_1$cluster)) +geom_point() +ggtitle("Cluster Analysis of Age on Sales")+labs(colour= "Clusters")+xlab("Age")+ylab("Sales")

# Managerial implications:
#We can see that there are 3 clusters which are defined by the amount of the purchase they have made and almost equally spread out through out the ages. Cluster 3 being the largest, followed by 2 and 1. 
################################################################################
