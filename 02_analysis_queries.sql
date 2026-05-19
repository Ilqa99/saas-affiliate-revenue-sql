-- ============================================================
-- SaaS Affiliate Revenue Analysis
-- FILE 2: Business Analysis Queries
-- ============================================================

USE saas_affiliate_db;

-- ============================================================
-- QUERY 1: Total revenue generated per month
-- Business Question: Which month had the highest revenue?
-- ============================================================
SELECT
    DATE_FORMAT(revenue_month, '%b %Y')     AS month,
    SUM(revenue_amount)                      AS total_revenue,
    COUNT(DISTINCT customer_id)              AS active_customers
FROM monthly_revenue
WHERE revenue_amount > 0
GROUP BY revenue_month
ORDER BY revenue_month;


-- ============================================================
-- QUERY 2: Revenue contribution by affiliate
-- Business Question: Who are our top performing affiliates?
-- ============================================================
SELECT
    a.affiliate_name,
    COUNT(DISTINCT mr.customer_id)           AS total_customers,
    SUM(mr.revenue_amount)                   AS total_revenue,
    ROUND(SUM(mr.revenue_amount) /
          (SELECT SUM(revenue_amount) FROM monthly_revenue) * 100, 2)
                                             AS revenue_share_pct
FROM monthly_revenue mr
JOIN affiliates a ON mr.affiliate_id = a.affiliate_id
GROUP BY a.affiliate_name
ORDER BY total_revenue DESC;


-- ============================================================
-- QUERY 3: Customer retention - active vs churned
-- Business Question: Which customers stopped paying?
-- ============================================================
SELECT
    customer_id,
    SUM(CASE WHEN revenue_amount > 0 THEN 1 ELSE 0 END) AS active_months,
    SUM(CASE WHEN revenue_amount = 0 THEN 1 ELSE 0 END)  AS inactive_months,
    SUM(revenue_amount)                                   AS lifetime_value,
    CASE
        WHEN MAX(revenue_amount) = 0 THEN 'Never Paid'
        WHEN SUM(CASE WHEN revenue_month = (
                SELECT MAX(revenue_month) FROM monthly_revenue) 
             AND revenue_amount = 0 THEN 1 ELSE 0 END) > 0
        THEN 'Churned'
        ELSE 'Active'
    END AS customer_status
FROM monthly_revenue
GROUP BY customer_id
ORDER BY lifetime_value DESC;


-- ============================================================
-- QUERY 4: Month-over-month revenue growth
-- Business Question: Is the platform growing?
-- ============================================================
WITH monthly_totals AS (
    SELECT
        revenue_month,
        SUM(revenue_amount) AS total_revenue
    FROM monthly_revenue
    GROUP BY revenue_month
)
SELECT
    DATE_FORMAT(revenue_month, '%b %Y')  AS month,
    total_revenue,
    LAG(total_revenue) OVER 
        (ORDER BY revenue_month)          AS prev_month_revenue,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY revenue_month))
        / NULLIF(LAG(total_revenue) OVER (ORDER BY revenue_month), 0) * 100
    , 2)                                  AS mom_growth_pct
FROM monthly_totals
ORDER BY revenue_month;


-- ============================================================
-- QUERY 5: Average revenue per customer (ARPC) by affiliate
-- Business Question: Which affiliate brings highest-value customers?
-- ============================================================
SELECT
    a.affiliate_name,
    COUNT(DISTINCT mr.customer_id)                        AS customers,
    SUM(mr.revenue_amount)                                AS total_revenue,
    ROUND(SUM(mr.revenue_amount) / 
          COUNT(DISTINCT mr.customer_id), 2)              AS avg_revenue_per_customer
FROM monthly_revenue mr
JOIN affiliates a ON mr.affiliate_id = a.affiliate_id
WHERE mr.revenue_amount > 0
GROUP BY a.affiliate_name
ORDER BY avg_revenue_per_customer DESC;


-- ============================================================
-- QUERY 6: Lead-to-revenue conversion timeline
-- Business Question: How many months after lead acquisition 
--                    does a customer start paying?
-- ============================================================
SELECT
    l.customer_id,
    a.affiliate_name,
    l.lead_month,
    MIN(mr.revenue_month)                                 AS first_payment_month,
    TIMESTAMPDIFF(MONTH, l.lead_month, 
                  MIN(mr.revenue_month))                  AS months_to_convert
FROM leads l
JOIN affiliates a      ON l.affiliate_id = a.affiliate_id
JOIN monthly_revenue mr ON l.customer_id = mr.customer_id
WHERE mr.revenue_amount > 0
GROUP BY l.customer_id, a.affiliate_name, l.lead_month
ORDER BY months_to_convert;


-- ============================================================
-- QUERY 7: POC (Point of Contact) performance
-- Business Question: Which internal POC manages highest revenue?
-- ============================================================
SELECT
    l.poc,
    COUNT(DISTINCT l.customer_id)                         AS leads_managed,
    SUM(mr.revenue_amount)                                AS total_revenue_driven
FROM leads l
JOIN monthly_revenue mr ON l.customer_id = mr.customer_id
GROUP BY l.poc
ORDER BY total_revenue_driven DESC
LIMIT 5;


-- ============================================================
-- QUERY 8: Cumulative revenue growth over time
-- Business Question: What is our total platform revenue to date?
-- ============================================================
WITH monthly_totals AS (
    SELECT
        revenue_month,
        SUM(revenue_amount) AS monthly_revenue
    FROM monthly_revenue
    GROUP BY revenue_month
)
SELECT
    DATE_FORMAT(revenue_month, '%b %Y')     AS month,
    monthly_revenue,
    SUM(monthly_revenue) OVER 
        (ORDER BY revenue_month)             AS cumulative_revenue
FROM monthly_totals
ORDER BY revenue_month;
