select
	frequency_category,
	count(1) customer_count,
	avg(avg_per_month) avg_transactions_per_month
from
	(
	select
		filtered.user_id,
		avg(count_for_user) avg_per_month,
		case
			when round(avg(count_for_user)) <= 2 then 'Low Frequency'
			when round(avg(count_for_user)) between 3 and 9 then 'Medium Frequency'
			else 'High Frequency'
		end frequency_category
	from
		(
		select
			user.id user_id ,
			month(savings.transaction_date) month_of_transaction,
			count(1) count_for_user
		from
			users_customuser user
		inner join savings_savingsaccount savings on
			(savings.owner_id = user.id
				and savings.confirmed_amount>0 )
			#I considered using transaction status to remove failed transactions but decided confirmed_amount>0 is better. would have asked my manager
		where
			user.is_active = 1
			and user.is_account_deleted = 0
			#I considered removing disabled accounts but decided that they might be disabled from login issues.
		group by
			user.id ,
			month(savings.transaction_date)
			
) filtered
	group by
		filtered.user_id) final_step
group by
	frequency_category
;