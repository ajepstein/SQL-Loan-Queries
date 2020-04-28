/*
Adam Epstein
*/

/*
I joined the loans and transactions tables. I used the instances where the user_id in loans 
was the same as the user_id in transactions and the created date in both tables were the same. 
*/

select lhs.id as loan_id, lhs.amount as loan_amount, rhs.user_id, rhs.fee as transaction_fee
from
    (select id, user_id, amount, created
    from loans
    where loan_status = 'repaid'
    or loan_status = 'active'
    group by 1,2,3,4) AS lhs
join
    (select id, user_id, fee, created
    from transactions
    group by 1,2,3,4) as rhs
on lhs.user_id = rhs.user_id
and lhs.created = rhs.created;

/*
## Aggregation
*/

/*
I used date_part and the count functions to get the number of 
loans per month.
The month is in ascending order.
*/

SELECT date_part('month', created) AS month, COUNT(*) as ct
FROM loans
GROUP BY 1
ORDER BY 1 ASC;

/*
I used date_part and the sum functions to get the total amount of all
loans per month.
The month is in ascending order.
*/

SELECT date_part('month', created) as month, sum(amount) as amt
FROM loans
GROUP BY 1
ORDER BY 1 ASC;

/*
I used date_part and the average functions to get the average amount of each
loan per month.
The month is in ascending order.
*/

SELECT date_part('month', created) as month, avg(amount) as avg_amt
FROM loans
GROUP BY 1
ORDER BY 1 ASC;

/*
I used date_part and the min functions to get the smallest loan size per month.
The month is in ascending order.
*/

SELECT date_part('month', created) as month, min(amount) as min_amt
FROM loans
GROUP BY 1
ORDER BY 1 ASC;

/*
I used date_part and the max functions to get the largest loan size per month.
The month is in ascending order.
*/

SELECT date_part('month', created) as month, max(amount) as max_amt
FROM loans
GROUP BY 1
ORDER BY 1 ASC;

/*
I used date_part function and order by year descending and month descending 
*/

SELECT date_part('year', created) as year, date_part('month', created) as month
FROM loans
GROUP BY 1, 2
ORDER BY    
1 DESC, 
2 DESC;



/*
## weekly_logins
*/
select sum(weekly_logins) from weekly_logins;

select avg(weekly_logins) from weekly_logins;

/*
## the 75th percentile of login rate have slack integration and free trial.
If you want customers to use the service, give a free trial
*/
select user_name, slack_integration, had_free_trial
from weekly_logins
where weekly_logins >= 9
and slack_integration = 'Yes'
and had_free_trial = 'Yes'
group by 1, 2, 3;