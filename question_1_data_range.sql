SELECT 
	MIN(LEAD_CREATED_DATE) as earliest_lead_created_date , 
	MAX(COALESCE(CASE_CLOSED_SUCCESSFUL_DATE,f.CASE_OPENED_DATE)) as latest_case_closed_successful_date
FROM enpal_sql_challenge.main.leads l 
LEFT JOIN enpal_sql_challenge.main.sales_funnel f
	ON f.LEAD_ID = l.LEAD_ID
