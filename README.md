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
**File:** `question_1_data_range.sql`  
**Objective:** Identify earliest lead_created_date and latest case_closed_successful_date

**Key Findings:**
- Earliest lead: 2024-01-16
- Latest successful close: 2024-10-28
- Data span: ~9.5 months

### Question 2: Best-Performing Marketing Channel
**File:** `sql_queries/question_2_best_channel.sql`  
**Objective:** Analyze Lead → PV System Sold conversion rate and time to conversion

**Key Findings:**
***Conversion Rate Performance:***
Channel A demonstrates the highest conversion efficiency, with 10.2% of leads successfully converting to PV System Sold. 
This represents a 1.5 percentage point advantage over Channel B (9.7%) and 1.46 percentage points over Channel C (8.74%)

***Time to Conversion:***
Channel C achieves the fastest lead-to-sale cycle, averaging 43.78 days to convert. Channel B follows closely at 44.57 days, while Channel A takes 46.14 days.
The difference between the fastest and slowest channel is only 2.36 days, representing a 5.4% variance in conversion speed.

### Question 3: Top/Bottom Days by Channel
**File:** `sql_queries/question_3_top_bottom_days.sql`  
**Objective:** Find top 3 and bottom 3 days per marketing channel for Lead → Sales Call 1 conversion
