# DataAnalytics-Assessment


**ASSESSMENT 1**
**Query Structure and Logic**
-	savings_customers (First CTE): Helps to identify users with savings plans.

-	investment_customers (Second CTE): Helps to identify users with investment plans.

-	Main Query: The CTEs were joined to ensure the query results to only include customers who appear in both CTEs (have both types of plans).

**Challenges and Solutions**
1. The success status had variants so I had to use LIKE “%success%” to capture any status containing the word "success".
2. Had to present user names, which required combining first_name and last_name. Used CONCAT to combine names



**ASSESSMENT 2**
**Query Structure and Logic**
-	monthly_transaction (First CTE): Gave a breakdown of how many transactions each user made in each month.

-	user_avg_transactions (Second CTE): This provided a measure of each user's typical monthly transaction frequency.

-	Main Query: This segmented users into three categories based on their average monthly transactions, counted the number of customers in each segment, and calculates the average number of monthly transactions within each segment

**Challenges and Solutions**
1. I needed to determine how to group transactions by time period, so I used MONTHNAME() to group by calendar month.
2. Users with no transactions would be excluded if using INNER JOIN, so I used a LEFT JOIN from users_customusers table to user_avg_transaction CTE, ensuring all users appear in the results, even those with no transaction history.



**ASSESSMENT 3**
**Query Structure and Logic**
Again, I broke down the problem into 2 CTEs (Common Table Expressions) and 1 final query:
-	plans_max_transactions (First CTE): Calculates the latest transaction date from the plans table.

-	savings_max_transactions (CTE): Calculates the latest transaction date from the savings account table.

-	Main query: Which joins both CTEs to get accounts with no transaction in 365 days. 

**Challenges and Solutions**
1.	Determining which date field represents the "last transaction date" across different tables was a challenge. I addressed this by;
o	Taking data from both plans_plan.last_charge_date and savings_savingsaccount.transaction_date
o	Using COALESCE to choose the most recent date between them

2.	Again, the success status had variants so I had to use LIKE “%success%” to capture any status containing the word "success".



**ASSESSMENT 4**
**Query Structure and Logic**
I broke down the problem into 2 CTEs (Common Table Expressions) and 1 final query:
-	transactions (First CTE): Aggregates transaction data

-	account_tenure (Second CTE): Calculates user tenure information

-	Main query: Joins the queries and calculates CLV

**Challenges and Solutions**
1.	The success status had variants so I had to use LIKE “%success%” to capture any status containing the word "success".
2.	Users who signed up very recently could have zero tenure months, causing division by zero, so I used CASE statement to handle this.
3.	Working with different date formats, so I had to convert date objects before calculation.

