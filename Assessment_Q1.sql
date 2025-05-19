select
	*
from
	(
	select
		filtered.owner_id,
		concat(filtered.first_name, ' ', filtered.last_name) name,
		sum(filtered.is_fixed_investment) investment_count,
		sum(filtered.is_regular_savings) savings_count,
		sum(filtered.total_deposit) total_deposits
	from
		(
		select
			plan.owner_id owner_id,
			plan.id plan_id,
			user.first_name,
			user.last_name,
			plan.is_fixed_investment,
			plan.is_regular_savings,
			sum(savings.confirmed_amount) total_deposit
		from
			users_customuser user
			#I considered removing failed transactions in addition to summing over confirmed amount also but summing over confirmed amount alone looked more reliable, would have asked my manager
		inner join plans_plan plan on
			(user.id = plan.owner_id
				and (plan.is_fixed_investment = 1
					or plan.is_regular_savings = 1)
				and plan.is_archived = 0
				and plan.is_deleted = 0 )
		inner join savings_savingsaccount savings on
			(savings.plan_id = plan.id)
			#I considered removing anonymous accounts, would have asked my manager
		where
			user.is_active = 1
			and user.is_account_deleted = 0
			#I considered removing disabled accounts but decided that they might be diabled from login issues.
		group by
			plan.owner_id,
			user.id ,
			user.first_name,
			user.last_name,
			plan.is_fixed_investment,
			plan.is_regular_savings) filtered
	group by
		filtered.owner_id,
		filtered.first_name,
		filtered.last_name) final_step
where
	final_step.investment_count > 0
	and final_step.savings_count > 0; 
