SaaS Affiliate Revenue Analysis (SQL Project)

Overview: This project analyzes affiliate-driven customer revenue for a SaaS platform across August 2025 to January 2026. The dataset was originally built during a Program Management internship assignment using Google Sheets (SUMIFS, XLOOKUP, Pivot Tables). This project recreates and extends that analysis using MySQL, demonstrating how SQL can replace and scale spreadsheet-based reporting.

Business Context: A SaaS platform acquires customers through affiliate partners. Each affiliate refers leads, and the platform tracks:
1. When a lead was acquired (lead month)
2. When they started paying (conversion)
3. How much revenue they generate each month
4. Which affiliate and internal POC is responsible
Leadership needs monthly performance visibility to make decisions on affiliate payouts, retention strategy, and growth planning.

Database Schema:
saas_affiliate_db
│
├── affiliates         → Affiliate name, email, POC
├── leads              → Lead acquisition data per customer
└── monthly_revenue    → Monthly revenue per customer (Aug 2025 – Jan 2026)

File Structure:
saas_affiliate_analysis/
├── 01_create_and_load.sql     → Database setup + data insertion
├── 02_analysis_queries.sql    → 8 business analysis queries
└── README.md                  → Project documentation

Analysis Queries & Business Questions:
| 1 | Monthly Revenue Summary |Insights on which month had the highest revenue? |
| 2 | Revenue by Affiliate | Insights on who are our top-performing affiliates? |
| 3 | Customer Retention Status | Insights on which customers churned or never paid? |
| 4 | Month-over-Month Growth | Answers if the platform growing? |
| 5 | Avg Revenue Per Customer | Insights on which affiliate brings highest-value customers? |
| 6 | Lead-to-Revenue Timeline | Insights on how long does it take a lead to convert? |
| 7 | POC Performance | Insights on which internal manager drives the most revenue? |
| 8 | Cumulative Revenue | Insights on what is our total platform revenue to date? |


Key Insights and Findings:
1. Olivia Carter is the highest-revenue affiliate, contributing the majority of platform revenue in the early months
2. Benjamin Scott's customers show the highest average revenue per customer (₹499/month)
3. Most customers take 1–2 months after lead acquisition to make their first payment
4. Platform shows a positive MoM growth trend from September to December 2025
5. Several customers show churn after 2–3 months, suggesting a need for retention intervention

SQL Concepts:
- `CREATE TABLE`, `INSERT INTO` — data modeling
- `JOIN` — linking affiliates, leads, and revenue
- `GROUP BY`, `HAVING` — aggregation and filtering
- `CASE WHEN` — conditional logic (replaces Excel IF/SUMIFS)
- `CTEs (WITH clause)` — reusable query blocks
- `Window Functions` — `LAG()`, `SUM() OVER()` for growth analysis
- `TIMESTAMPDIFF()` — time-based calculations
- `NULLIF()`, `ROUND()` — safe division and formatting


Author:
Ilqa Rabbani
MBA — Business Analytics & Finance  
LinkedIn: https://www.linkedin.com/in/ilqarabbani/
Email: ilqarabbani2003@gmail.com
