WITH monthly_transactions as
	(SELECT 
		s.owner_id,
		MONTHNAME(s.transaction_date) AS m,
		COUNT(s.id) AS transaction_count
	
	FROM savings_savingsaccount s
	WHERE transaction_status LIKE "%success%"
	GROUP BY s.owner_id, MONTHNAME(s.transaction_date)),

	user_avg_transactions as 
		(SELECT
			mt.owner_id,
			AVG(mt.transaction_count) AS Avg_Monthly_Transactions
		
		FROM monthly_transactions mt
		GROUP BY mt.owner_id)
		
	SELECT
		case
			when uat.Avg_Monthly_Transactions >=10 then "High Frequency"
			when uat.Avg_Monthly_Transactions >=3 then "Medium Frequency"
			ELSE "Low Frequency"
		END AS Frequency_Category,
		
		COUNT(DISTINCT(uc.id)) AS Customer_Count,
		avg(uat.Avg_Monthly_Transactions) AS Avg_Transactions_Per_Month
		
	FROM users_customuser uc
	LEFT JOIN user_avg_transactions uat
		ON uc.id = uat.owner_id
	GROUP BY 
		case
			when uat.Avg_Monthly_Transactions >=10 then "High Frequency"
			when uat.Avg_Monthly_Transactions >=3 then "Medium Frequency"
			ELSE "Low Frequency"
		end	
	ORDER BY Avg_Transactions_Per_Month DESC;