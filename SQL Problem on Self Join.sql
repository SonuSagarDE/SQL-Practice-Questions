/*Find all couples of Trade for same stock that happens in the range of 10 secs and 
 having price difference more than 10 % . Output result should also list the percentage of price difference between
 the Trades */
Create Table Trade_tbl(
TRADE_ID varchar(20),
Trade_Timestamp time,
Trade_Stock varchar(20),
Quantity int,
Price Float
);
Insert into Trade_tbl Values
('TRADE1','10:01:05','ITJunction4All',100,20),
('TRADE2','10:01:06','ITJunction4All',20,15),
('TRADE3','10:01:08','ITJunction4All',150,30),
('TRADE4','10:01:09','ITJunction4All',300,32),
('TRADE5','10:10:00','ITJunction4All',-100,19),
('TRADE6','10:10:01','ITJunction4All',-300,19);

Select t1.TRADE_ID as First_Trade,t1.Trade_Timestamp,t1.Price,t2.TRADE_ID as Second_Trade,
t2.Price,t2.Trade_Timestamp
from Trade_tbl t1
Inner Join Trade_tbl t2 on 1=1
where t1.Trade_Timestamp<t2.Trade_Timestamp and TIME_TO_SEC(timediff(t2.Trade_Timestamp,t1.Trade_Timestamp))<10
Order by t1.TRADE_ID
