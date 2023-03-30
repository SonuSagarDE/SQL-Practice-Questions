USE mavenfuzzyfactory;
SELECT 
-- YEAR (created_at) AS Yr,
-- WEEK(created_at)  AS Wk,
MIN(DATE(created_at)) AS week_start_date,
COUNT(DISTINCT CASE WHEN device_type='desktop' THEN website_session_id ELSE NULL END ) AS desk_Sessions,
COUNT(DISTINCT CASE WHEN device_type='mobile' THEN website_session_id ELSE NULL END ) AS Mob_Sessions
FROM website_sessions
WHERE website_sessions.created_at < '2012-06-09' AND 
       website_sessions.created_at > '2012-04-15'
	   AND utm_source='gsearch'
       AND utm_campaign='nonbrand'
       GROUP BY 
       YEAR (created_at),
       WEEK(created_at)
       
