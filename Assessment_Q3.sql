WITH plans_max_transactions AS(

	SELECT
		p.id,
		p.owner_id,
		p.is_a_fund,
		p.is_regular_savings,
		MAX(p.last_charge_date) AS last_transaction_date
	
	FROM plans_plan p
	JOIN savings_savingsaccount s
		ON p.id = s.plan_id
	WHERE (p.is_a_fund = 1 OR p.is_regular_savings = 1)
  		AND (s.transaction_status LIKE "%success%")
	GROUP BY p.id,p.owner_id),
		
savings_max_transactions AS (
	SELECT
		s.plan_id,
		s.owner_id,
		MAX(date(s.transaction_date)) AS Savings_last_transaction_date
	
	FROM savings_savingsaccount s
	WHERE (s.transaction_status LIKE "%success%")
	GROUP BY s.plan_id, s.owner_id)
		

SELECT
	pmt.id AS Plan_Id,
	pmt.owner_id AS Owner_Id,
	case
	 when pmt.is_regular_savings = 1 then "Savings"
	 when pmt.is_a_fund = 1 then "Investment"
	 END AS TYPE,
	 COALESCE(pmt.last_transaction_date, smt.Savings_last_transaction_date) AS Last_Transaction_Date,
	 DATEDIFF(CURRENT_DATE, COALESCE(pmt.last_transaction_date, smt.Savings_last_transaction_date)) AS Inactivity_Days
	 
FROM plans_max_transactions pmt
JOIN savings_max_transactions smt
	ON pmt.id = smt.plan_id
WHERE DATEDIFF(CURRENT_DATE, COALESCE(pmt.last_transaction_date, smt.Savings_last_transaction_date)) >365
ORDER BY Inactivity_Days DESC;
	 


	
	
		