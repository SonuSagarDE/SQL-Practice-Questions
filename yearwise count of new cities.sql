-- Business city table has data from the day Udan has started Operations
-- write a SQL query to identify yearwise count of new cities where udan started their operations
create table business_city (
business_date date,
city_id int
);
insert into business_city
values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),(cast('2022-02-28' as date),12);
With CTE AS ( 
Select *,
Year(business_date)  AS Year_business,
row_number() over (partition by city_id order by business_date) AS rn
from business_city
)
Select Year_business,Count(1) as new_cities
from CTE
where rn=1
group by Year_business
