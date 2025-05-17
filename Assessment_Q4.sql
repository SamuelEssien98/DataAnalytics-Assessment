WITH transactions AS (
	SELECT 
		s.owner_id,
		COUNT(s.id) AS Total_Transactions,
		avg(s.confirmed_amount*0.001) AS Avg_Profit_Per_Transaction
	
	FROM savings_savingsaccount s
	WHERE s.transaction_status LIKE "%success%"
	GROUP BY s.owner_id),

account_tenure AS (	
	SELECT
		uc.id,
		CONCAT(uc.first_name,' ',uc.last_name) AS Name,
		datediff(CURRENT_DATE, date(uc.date_joined)) / 30 AS Tenure_Months
	
	FROM users_customuser uc
	WHERE uc.is_active = 1)
	
	
SELECT
		a.id AS Customer_Id,
		a.Name,
		a.Tenure_Months,
		t.Total_Transactions,
	case
		when a.Tenure_Months > 0 then ROUND(((t.Total_Transactions/a.Tenure_Months)*12*t.Avg_Profit_Per_Transaction),2)
		ELSE 0
	END AS Estimated_CLV
	
FROM account_tenure a
JOIN transactions t
	ON a.id = t.owner_id
ORDER BY Estimated_CLV DESC;
	 