select
	plan_id,
	owner_id,
	type,
	last_transaction_date,
	DATEDIFF(sysdate(), last_transaction_date) inactivity_days
from
	(
	select
		plan_id,
		owner_id,
		type,
		max(transaction_date) last_transaction_date
	from
		(
		select 
			plan.id plan_id, 
			plan.owner_id owner_id,
			case
				when plan.is_fixed_investment = 1 then 'Investment'
				else 'Savings'
			end type,
			savings.transaction_date
			#sum(savings.confirmed_amount) total_deposit
			#I considered removing failed transactions in addition to summing over confirmed amount also but summing over confirmed amount alone looked more reliable, would have asked my manager
		from
			plans_plan plan
		inner join savings_savingsaccount savings on
			(savings.plan_id = plan.id)
		where
			(plan.is_fixed_investment = 1
				or plan.is_regular_savings = 1)
			and plan.locked = 0
			and plan.is_archived = 0
			and plan.is_deleted = 0) filtered
	group by
		plan_id,
		owner_id,
		type) final_step
where
	DATE_SUB(sysdate(), interval 365 day) > final_step.last_transaction_date ; 