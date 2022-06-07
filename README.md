# Real-Time-Message-Experiment---Mall Operator---R-Studio
Real-time message: Real-time mobile message is a short text that a customer receives on their mobile phone when they are in a mall. In the experiment, a mobile message was sent to selected customers right after their first purchase in the mall.
Experiment: As the mall operator wants to understand the role of real-time mobile messages on customer’s purchase behavior, it ran a field experiment on a group of 9032 consumers who visited the mall in the week of Oct 1, 2019. In the experiment, 9032 customers were equally divided into two halves. The first half of consumers (4516) received a real-time mobile message right after their first purchase promising 1000 loyalty points if they buy one more time from the mall on that day (irrespective of how much they buy) while the second half (4516 consumers) continued their shopping without receiving any real-time mobile message.
Below are more details about the mall and its data.
A consumer makes a shopping trip to a mall and can make many purchases in one shopping trip. There are two tables in total as described below:
1.	Consumer table
The mall operator is using cutting-edge technology to capture its consumer and purchase data. The mall operator in its high-end mall allows consumers to make a purchase using malls’ mobile app only. 
consumer_id: Each consumer has a unique consumer identifer (consumer_id) that gets assigned as soon as the consumer creates a new profile on the mobile app. Each consumer has only one consumer_id. 
age: Age of the customer
gender: Gender of the customer
loyalty_status: The mall operator on the basis of past spending of the consumer assigns a loyalty status: low (1) and high (2). Low is the lowest loyalty whereas high is the highest loyalty to the mall. 
2.	Purchase table
Sales data gets captured in the purchase table.
from_second_store_sales: The amount spent from the second store onwards in the same shopping trip. This is the sales (in dollars) of all the purchases that a customer makes after the first purchase
realtime_message: This shows if a customer received a real-time mobile message or not. For the consumer who receive a real-time mobile message, realtime_message is marked one, otherwise zero.
