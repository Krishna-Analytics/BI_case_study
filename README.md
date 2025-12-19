# Enpal SQL Case Study

**Candidate:** Krishna Narwade  

## Overview
This repository contains SQL solutions for the Enpal case study analyzing lead conversion funnels and marketing channel performance.

## Dataset
- **Database:** enpal_sql_challenge
- **Total number of lead:** 57906
- **Total number of lead with PV System Sold:** 5480 (10.56%)
- **Date Range:** January 16 - October 28, 2024

## Assumption on Data Quality :
3% of PV System Sold records have NULL case_closed_successful_date values. 
These were replaced with case_opened_date, which is valid since 64% of sales close on the same day they open.
**Impact:** This ensures all 5,323 successful conversions are counted in the analysis rather than excluding 3% of valid sales due to missing date values.

## Questions & Solutions

### Question 1: Data Range Analysis
**File:** `question_1_data_range.sql`  
**Objective:** Identify earliest lead_created_date and latest case_closed_successful_date

**Key Findings:**
- Earliest lead: 2024-01-16
- Latest successful close: 2024-10-28
- Data span: ~9.5 months

### Question 2: Best-Performing Marketing Channel
**File:** `question_2_best_channel.sql`  
**Objective:** Analyze Lead → PV System Sold conversion rate and time to conversion

**Key Findings:**
***Conversion Rate Performance:***
Channel A demonstrates the highest conversion efficiency, with 10.2% of leads successfully converting to PV System Sold. 
This represents a 1.5 percentage point advantage over Channel B (9.7%) and 1.46 percentage points over Channel C (8.74%)

***Time to Conversion:***
Channel C achieves the fastest lead-to-sale cycle, averaging 43.78 days to convert. Channel B follows closely at 44.57 days, while Channel A takes 46.14 days.
The difference between the fastest and slowest channel is only 2.36 days, representing a 5.4% variance in conversion speed.

### Question 3: Top/Bottom Days by Channel
**File:** `question_3_top_bottom_days.sql`  
**Objective:** Find top 3 and bottom 3 days per marketing channel for Lead → Sales Call 1 conversion

### Lead → Sales Call 1 Conversion Rate Performance

| Marketing Channel | Lead Created Date | Total Leads | Converted Leads | Conversion Rate (%) | Performance Category | Top Rank | Bottom Rank |
|-------------------|-------------------|-------------|-----------------|---------------------|---------------------|----------|-------------|
| **Channel A** | 2024-04-22 | 167 | 167 | 100.0 | Top 3 | 1 | 173 |
| **Channel A** | 2024-05-10 | 143 | 143 | 100.0 | Top 3 | 2 | 172 |
| **Channel A** | 2024-05-05 | 140 | 140 | 100.0 | Top 3 | 3 | 171 |
| **Channel A** | 2024-06-16 | 133 | 127 | 95.49 | Bottom 3 | 171 | 3 |
| **Channel A** | 2024-01-21 | 18 | 17 | 94.44 | Bottom 3 | 172 | 2 |
| **Channel A** | 2024-07-05 | 14 | 13 | 92.86 | Bottom 3 | 173 | 1 |
| **Channel B** | 2024-06-09 | 136 | 136 | 100.0 | Top 3 | 1 | 177 |
| **Channel B** | 2024-05-28 | 126 | 126 | 100.0 | Top 3 | 2 | 176 |
| **Channel B** | 2024-06-12 | 114 | 114 | 100.0 | Top 3 | 3 | 175 |
| **Channel B** | 2024-01-24 | 24 | 22 | 91.67 | Bottom 3 | 175 | 3 |
| **Channel B** | 2024-01-21 | 14 | 12 | 85.71 | Bottom 3 | 176 | 2 |
| **Channel B** | 2024-07-06 | 9 | 7 | 77.78 | Bottom 3 | 177 | 1 |
| **Channel C** | 2024-03-18 | 198 | 198 | 100.0 | Top 3 | 1 | 176 |
| **Channel C** | 2024-06-19 | 192 | 192 | 100.0 | Top 3 | 2 | 175 |
| **Channel C** | 2024-06-09 | 186 | 186 | 100.0 | Top 3 | 3 | 174 |
| **Channel C** | 2024-01-27 | 45 | 42 | 93.33 | Bottom 3 | 174 | 3 |
| **Channel C** | 2024-07-03 | 29 | 27 | 93.10 | Bottom 3 | 175 | 2 |
| **Channel C** | 2024-07-06 | 19 | 17 | 89.47 | Bottom 3 | 176 | 1 |

### Key Observations

- All three channels achieved 100% conversion rates on their best-performing days
- Channel B shows the widest performance gap (100% top vs 77.78% bottom)
- Early January and early July dates consistently appear in bottom 3 across all channels
- Top-performing days clustered in April-June period with high lead volumes

