WITH savings_customers AS (
	SELECT
	p.owner_id,
	COUNT(DISTINCT(p.id)) AS savings_count,
	SUM(s.confirmed_amount) AS savings_deposit
	
	FROM plans_plan p
	JOIN savings_savingsaccount s
		ON p.id = s.plan_id
	WHERE (s.transaction_status LIKE "%success%") AND (p.is_regular_savings = 1)
	GROUP BY p.owner_id),
	
investment_customers AS (
	SELECT
	p.owner_id,
	COUNT(DISTINCT(p.id)) AS investment_count,
	SUM(p.amount) AS investment_deposit
	
	FROM plans_plan p
	JOIN savings_savingsaccount s
		ON p.id = s.plan_id
	WHERE (p.amount > 0) AND (p.is_a_fund = 1)
	GROUP BY p.owner_id)
	
SELECT 
	sc.owner_id,
	CONCAT(uc.first_name,' ',uc.last_name) AS Name,
	sc.savings_count AS Savings_Count,
	ic.investment_count AS Investment_Count,
	(sc.savings_deposit + investment_deposit) AS Total_Deposit

FROM savings_customers sc
JOIN investment_customers ic
	ON sc.owner_id = ic.owner_id
JOIN users_customuser uc
	ON sc.owner_id = uc.id
ORDER BY Total_Deposit DESC;