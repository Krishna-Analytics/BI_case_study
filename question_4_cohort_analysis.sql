/*
============================================================
QUERY: Cohort Analysis Dataset - Marketing Channel Funnel
DESCRIPTION: Lead-level cohort dataset with dynamic cutoff date

OUTPUT: One row per lead_id with funnel progression metrics
Assumption NOTE: Uses MAX(lead_created_date) as reference for maturity calculation
============================================================
*/
CREATE OR REPLACE VIEW enpal_sql_challenge.main.cohort_lead_funnel AS (
WITH date_reference AS (
    -- Get the latest lead creation date dynamically
    SELECT MAX(lead_created_date) AS max_lead_date
    FROM enpal_sql_challenge.main.leads
),
lead_base AS (
    SELECT 
        l.lead_id,
        l.marketing_channel,
        l.lead_created_date,
        DATE_TRUNC('MONTH', l.lead_created_date) AS cohort_month,
        DATEDIFF('day', l.lead_created_date, dr.max_lead_date) AS days_since_creation,
        CASE 
            WHEN DATEDIFF('day', l.lead_created_date, dr.max_lead_date) >= 90 THEN 'Mature'
            WHEN DATEDIFF('day', l.lead_created_date, dr.max_lead_date) >= 60 THEN 'Partially Mature'
            ELSE 'Immature'
        END AS cohort_maturity_status
    FROM enpal_sql_challenge.main.leads l
    CROSS JOIN date_reference dr
),
funnel_stages AS (
    SELECT 
        lead_id,
        MAX(CASE WHEN sales_funnel_steps = 'Sales Call 1' 
            THEN COALESCE(case_opened_date, case_closed_successful_date) END) AS sales_call_1_date,
        MAX(CASE WHEN sales_funnel_steps = 'Sales Call 2' 
            THEN COALESCE(case_opened_date, case_closed_successful_date) END) AS sales_call_2_date,
        MAX(CASE WHEN sales_funnel_steps = 'PV System Sold' 
            THEN COALESCE(case_closed_successful_date, case_opened_date) END) AS pv_sold_date
    FROM enpal_sql_challenge.main.sales_funnel
    GROUP BY lead_id
)

SELECT 
    lb.lead_id,
    lb.marketing_channel,
    lb.lead_created_date,
    lb.cohort_month,
    lb.days_since_creation,
    lb.cohort_maturity_status,
    
    fs.sales_call_1_date,
    fs.sales_call_2_date,
    fs.pv_sold_date,
    
    CASE WHEN fs.sales_call_1_date IS NOT NULL THEN 1 ELSE 0 END AS converted_to_sales_call_1,
    CASE WHEN fs.sales_call_2_date IS NOT NULL THEN 1 ELSE 0 END AS converted_to_sales_call_2,
    CASE WHEN fs.pv_sold_date IS NOT NULL THEN 1 ELSE 0 END AS converted_to_pv_sold,
    
    DATEDIFF('day', lb.lead_created_date, fs.sales_call_1_date) AS days_to_sales_call_1,
    DATEDIFF('day', lb.lead_created_date, fs.sales_call_2_date) AS days_to_sales_call_2,
    DATEDIFF('day', lb.lead_created_date, fs.pv_sold_date) AS days_to_pv_sold,
    
    DATEDIFF('day', fs.sales_call_1_date, fs.sales_call_2_date) AS days_between_call_1_and_2,
    DATEDIFF('day', fs.sales_call_2_date, fs.pv_sold_date) AS days_between_call_2_and_sold
    
FROM lead_base lb
LEFT JOIN funnel_stages fs ON lb.lead_id = fs.lead_id
ORDER BY lb.lead_created_date, lb.lead_id);

SELECT * FROM cohort_lead_funnel;
