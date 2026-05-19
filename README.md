# 📊 SaaS Affiliate Revenue Analysis — SQL Project

## 🗂️ Project Overview

This project analyzes affiliate-driven customer revenue for a SaaS platform across **August 2025 to January 2026**. The dataset was originally built during a Program Management internship assignment using Google Sheets (SUMIFS, XLOOKUP, Pivot Tables). This project recreates and extends that analysis using **MySQL**, demonstrating how SQL can replace and scale spreadsheet-based reporting.

---

## 🧩 Business Context

A SaaS platform acquires customers through **affiliate partners**. Each affiliate refers leads, and the platform tracks:
- When a lead was acquired (lead month)
- When they started paying (conversion)
- How much revenue they generate each month
- Which affiliate and internal POC is responsible

Leadership needs monthly performance visibility to make decisions on **affiliate payouts, retention strategy, and growth planning**.

---

## 🗃️ Database Schema

```
saas_affiliate_db
│
├── affiliates         → Affiliate name, email, POC
├── leads              → Lead acquisition data per customer
└── monthly_revenue    → Monthly revenue per customer (Aug 2025 – Jan 2026)
```

---

## 📁 File Structure

```
saas_affiliate_analysis/
├── 01_create_and_load.sql     → Database setup + data insertion
├── 02_analysis_queries.sql    → 8 business analysis queries
└── README.md                  → Project documentation
```

---

## 🔍 Analysis Queries & Business Questions

| # | Query | Business Question |
|---|-------|-------------------|
| 1 | Monthly Revenue Summary | Which month had the highest revenue? |
| 2 | Revenue by Affiliate | Who are our top-performing affiliates? |
| 3 | Customer Retention Status | Which customers churned or never paid? |
| 4 | Month-over-Month Growth | Is the platform growing? |
| 5 | Avg Revenue Per Customer | Which affiliate brings highest-value customers? |
| 6 | Lead-to-Revenue Timeline | How long does it take a lead to convert? |
| 7 | POC Performance | Which internal manager drives the most revenue? |
| 8 | Cumulative Revenue | What is our total platform revenue to date? |

---

## 💡 Key Insights

- **Olivia Carter** is the highest-revenue affiliate, contributing the majority of platform revenue in the early months
- **Benjamin Scott's** customers show the highest average revenue per customer (₹499/month)
- Most customers take **1–2 months** after lead acquisition to make their first payment
- Platform shows a **positive MoM growth trend** from September to December 2025
- Several customers show **churn after 2–3 months**, suggesting a need for retention intervention

---

## 🛠️ SQL Concepts Demonstrated

- `CREATE TABLE`, `INSERT INTO` — data modeling
- `JOIN` — linking affiliates, leads, and revenue
- `GROUP BY`, `HAVING` — aggregation and filtering
- `CASE WHEN` — conditional logic (replaces Excel IF/SUMIFS)
- `CTEs (WITH clause)` — reusable query blocks
- `Window Functions` — `LAG()`, `SUM() OVER()` for growth analysis
- `TIMESTAMPDIFF()` — time-based calculations
- `NULLIF()`, `ROUND()` — safe division and formatting

---

## ▶️ How to Run

1. Open **MySQL Workbench** and connect to your local instance
2. Run `01_create_and_load.sql` to set up the database and insert data
3. Run `02_analysis_queries.sql` query by query to explore the analysis
4. Each query is self-contained with a comment explaining the business question

---

## 🔗 Original Assignment Context

This SQL project is based on a **Program Management Intern selection assignment** for a SaaS platform. The original analysis was done in Google Sheets using SUMIFS, XLOOKUP, and Pivot Tables. This project demonstrates the same business logic implemented in SQL for scalability and reproducibility.

---

## 👤 Author

**[Your Name]**  
MBA — Business Analytics & Finance  
[Your LinkedIn] | [Your Email]
