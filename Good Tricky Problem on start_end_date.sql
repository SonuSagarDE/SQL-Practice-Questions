create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success');

-- Solution1 using CTE
WITH CTE AS (
Select * ,
row_number() over (partition by state order by date_value) as rn,
date_sub(date_value,interval row_number() over (partition by state order by date_value) day) as group_date
from tasks
Order by date_value)

Select min(date_value) as start_date, max(date_value) as end_date ,state
from CTE
group by group_date,state
order by date_value;
-- Soultion 2 using Subquery
select min(date_value) as start_date,max(date_value) as end_date,state
 from 
(
select date_value,state,row_number() over(partition by state order by date_value) as rn 
from tasks order by date_value
)a group by date_sub(date_value,interval rn day);