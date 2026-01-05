/*
============================================================
QUERY: Question 2 - Best Performing Marketing Channel
DESCRIPTION: Analyzes Lead → PV System Sold conversion rates
             and average time to conversion by marketing channel
             
Business logic & assumptions:
  - Conversion rate = (total converted lead / total leads) * 100
  - Time to conversion uses COALESCE to handle NULL dates(Becuase in almost 66% cases, the PV System is Sold with in the same day as case_opened_date ) 
============================================================
*/
WITH sucessful_lead AS (
		SELECT 
				l.marketing_channel, 
				l.lead_id, 
				COALESCE(f.case_closed_successful_date,f.case_opened_date)-l.lead_created_date AS days_diff 
		FROM enpal_sql_challenge.main.leads l
		INNER JOIN enpal_sql_challenge.main.sales_funnel f
			ON f.LEAD_ID = l.LEAD_ID
		WHERE f.SALES_FUNNEL_STEPS = 'PV System Sold'
),
channel_performance AS (
SELECT 
	l.marketing_channel, 
	COUNT(DISTINCT l.lead_id) as total_lead_count,
	COUNT(DISTINCT s.lead_id) as total_converted_lead,
	ROUND((COUNT(DISTINCT s.lead_id) / COUNT(DISTINCT l.lead_id))*100,2) as conversion_rate_pct,
	ROUND(AVG(days_diff),2) as avg_days_to_conversion
FROM enpal_sql_challenge.main.leads l
LEFT JOIN sucessful_lead s ON l.lead_id = s.lead_id
GROUP BY 1
)
SELECT 
	marketing_channel,
	total_lead_count,
	total_converted_lead,
	conversion_rate_pct,
	avg_days_to_conversion,
	ROW_NUMBER() OVER (ORDER BY conversion_rate_pct DESC) AS conversion_rate_rank,
    ROW_NUMBER() OVER (ORDER BY avg_days_to_conversion ASC) AS conversion_speed_rank

FROM channel_performance
