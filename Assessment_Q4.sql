select
	customer_id,
	name,
	tenure_months,  
	count(1) total_transactions,
	(count(1) / tenure_months) * 12 * avg(transaction_profit) estimated_clv
from
	(
	select 	 
		 user.id customer_id,
		 concat(user.first_name, ' ', user.last_name) name , 
		 round(datediff(sysdate(), user.date_joined)/ 30) tenure_months,
		 (0.1 * savings.confirmed_amount)/ 100 transaction_profit
	from
		users_customuser user
	inner join savings_savingsaccount savings on
		(savings.owner_id = user.id
			and savings.confirmed_amount> 0)
		#I Focusing on successful trasactions only
	where 
		user.is_active = 1
		and user.is_account_deleted = 0
		#I considered removing disabled accounts but decided that they might be diabled from login issues.
) filtered
group by
	customer_id,
	name,
	tenure_months