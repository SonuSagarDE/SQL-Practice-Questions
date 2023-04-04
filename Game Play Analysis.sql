-- Game Play Analyis
create table activity (

 player_id     int     ,
 device_id     int     ,
 event_date    date    ,
 games_played  int
 );

 insert into activity values (1,2,'2016-03-01',5 ),(1,2,'2016-03-02',6 ),(2,3,'2017-06-25',1 )
 ,(3,1,'2016-03-02',0 ),(3,4,'2018-07-03',5 );
 
 Select * from activity;
 
 -- Question 1: Write an SQL query that reports the first login date for each player
 WITH CTE AS
 (
 Select player_id,event_date,
 rank() over (partition by player_id order by event_date ) as rnk
 from activity )
 Select player_id,event_date from CTE where rnk=1;
 
 -- O/P:
 /*
 1	2016-03-01
2	2017-06-25
3	2016-03-02
 */
 -- Q2 Write a SQL query that reports the device that is first logged in for each player
 WITH CTE AS
 (
 Select player_id,event_date,device_id,
 rank() over (partition by player_id order by event_date ) as rnk
 from activity )
 Select player_id,event_date,device_id from CTE where rnk=1;
 
 -- q3: Write an SQL query that reports for each player and date, how many games played so far by the player. 
-- That is, the total number of games played by the player until that date.
  Select player_id,event_date,device_id,
 sum(games_played) over (partition by player_id order by event_date ) as total_game_played
 from activity ;
-- q4: Write an SQL query that reports the fraction of players that logged in again 
--  on the day after the day they first logged in, rounded to 2 decimal places
With cte_min_date As (
select player_id, min(event_date) as first_login from activity group by player_id
)
-- select t2.* from cte_min_date t1 checking the list
select round( (select count(1) as cnt_1 from cte_min_date t1
inner join activity t2 on t1.player_id=t2.player_id and date_add(t1.first_login,interval 1 day)=t2.event_date
)/(select count(distinct player_id) from activity),2) as fraction
-- 