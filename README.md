# Enpal SQL Case Study

**Candidate:** Krishna Narwade  

## Overview
This repository contains SQL solutions for the Enpal case study analyzing lead conversion funnels and marketing channel performance.

## Dataset
- **Database:** enpal_sql_challenge
- **Tables:** leads, sales_funnel
- **Date Range:** January 16 - October 28, 2024

## Questions & Solutions

### Question 1: Data Range Analysis
**File:** `sql_queries/question_1_data_range.sql`  
**Objective:** Identify earliest lead_created_date and latest case_closed_successful_date

**Key Findings:**
- Earliest lead: 2024-01-16
- Latest successful close: 2024-10-28
- Data span: ~9.5 months

### Question 2: Best-Performing Marketing Channel
**File:** `sql_queries/question_2_best_channel.sql`  
**Objective:** Analyze Lead → PV System Sold conversion rate and time to conversion

**Approach:**
- Calculate end-to-end conversion rates per channel
- Measure average days from lead creation to PV System Sold
- Handle NULL case_closed_successful_date as proxy using case_opened_date

### Question 3: Top/Bottom Days by Channel
**File:** `sql_queries/question_3_top_bottom_days.sql`  
**Objective:** Find top 3 and bottom 3 days per marketing channel for Lead → Sales Call 1 conversion

**Methodology:**
- Daily conversion rate calculation per channel
- Window functions (ROW_NUMBER) for ranking
- Separate rankings for top and bottom performers

## How to Run
1. Connect to Snowflake using DBeaver
2. Navigate to enpal_sql_challenge.main schema
3. Execute queries in order (Question 1 → 2 → 3)
4. Export results to CSV for Power BI visualization (optional)

## Tools Used
- **Database:** Snowflake
- **SQL Client:** DBeaver
- **Dialect:** Snowflake SQL
