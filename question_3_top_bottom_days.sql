/*
============================================================
QUERY: Question 3 - Top and Bottom 3 Days by Marketing Channel
DESCRIPTION: Identifies top 3 and bottom 3 performing days per 
             marketing channel based on Lead → Sales Call 1 
             conversion rate

============================================================
*/

WITH sales_call_1_conversions AS (
    SELECT 
        l.marketing_channel,
        l.lead_created_date,
        l.lead_id
    FROM enpal_sql_challenge.main.leads l
    INNER JOIN enpal_sql_challenge.main.sales_funnel f
        ON f.LEAD_ID = l.LEAD_ID
    WHERE f.SALES_FUNNEL_STEPS = 'Sales Call 1'
),
daily_channel_performance AS (
    SELECT 
        l.marketing_channel,
        l.lead_created_date,
        COUNT(DISTINCT l.lead_id) as total_lead_count,
        COUNT(DISTINCT s.lead_id) as total_converted_lead,
        ROUND((COUNT(s.lead_id) / COUNT(l.lead_id))*100,2) as conversion_rate_pct
    FROM enpal_sql_challenge.main.leads l
    LEFT JOIN sales_call_1_conversions s 
        ON l.lead_id = s.lead_id 
    GROUP BY 1,2
),
ranked_days AS (
    SELECT 
        marketing_channel,
        lead_created_date,
        total_lead_count,
        total_converted_lead,
        conversion_rate_pct,
        ROW_NUMBER() OVER (PARTITION BY marketing_channel ORDER BY conversion_rate_pct desc, total_lead_count desc) AS top_rank,
        ROW_NUMBER() OVER (PARTITION BY marketing_channel ORDER BY conversion_rate_pct ASC,total_lead_count ASC) AS bottom_rank
    FROM daily_channel_performance
)
SELECT 
    marketing_channel,
    lead_created_date,
    total_lead_count,
    total_converted_lead,
    conversion_rate_pct,
    CASE 
        WHEN top_rank <= 3 THEN 'Top 3'
        WHEN bottom_rank <= 3 THEN 'Bottom 3'
    END AS performance_category,
    top_rank,
    bottom_rank
FROM ranked_days
WHERE top_rank <= 3 OR bottom_rank <= 3
ORDER BY marketing_channel ASC, conversion_rate_pct desc , total_lead_count desc