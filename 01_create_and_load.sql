SaaS Affiliate Revenue Analysis
Author: Ilqa Rabbani
Tool: MySQL
Description: Analyzes affiliate-driven customer revenue for a SaaS platform across Aug 2025 - Jan 2026

STEP 1: Create the database:
CREATE DATABASE IF NOT EXISTS saas_affiliate_db;
USE saas_affiliate_db;

STEP 2: Create the affiliates table:
CREATE TABLE IF NOT EXISTS affiliates (
    affiliate_id    INT AUTO_INCREMENT PRIMARY KEY,
    affiliate_name  VARCHAR(100),
    affiliate_email VARCHAR(150),
    poc             VARCHAR(100)  -- Point of Contact (internal manager)
);

STEP 3: Create the leads table:
CREATE TABLE IF NOT EXISTS leads (
    lead_id         INT AUTO_INCREMENT PRIMARY KEY,
    affiliate_id    INT,
    lead_month      DATE,          -- Month the lead was acquired
    lead_email      VARCHAR(150),
    customer_id     VARCHAR(50),
    FOREIGN KEY (affiliate_id) REFERENCES affiliates(affiliate_id)
);

STEP 4: Create the monthly_revenue table:
#Each row = one customer's revenue for one month
CREATE TABLE IF NOT EXISTS monthly_revenue (
    revenue_id      INT AUTO_INCREMENT PRIMARY KEY,
    customer_id     VARCHAR(50),
    affiliate_id    INT,
    revenue_month   DATE,          -- First day of the revenue month
    revenue_amount  DECIMAL(10, 2),
    FOREIGN KEY (affiliate_id) REFERENCES affiliates(affiliate_id)
);

STEP 5: Insert affiliate data:
INSERT INTO affiliates (affiliate_name, affiliate_email, poc) VALUES
('Olivia Carter',   'olivia.carter@creatorhub.co',     'Daniel M'),
('Olivia Carter',   'olivia.carter@creatorhub.co',     'Sophia L'),
('Olivia Carter',   'olivia.carter@creatorhub.co',     'Ryan K'),
('Olivia Carter',   'olivia.carter@creatorhub.co',     'Chloe S'),
('Logan Adams',     'logan.adams@charlottelinks.co',   'Liam P'),
('Logan Adams',     'logan.adams@charlottelinks.co',   'Harper W'),
('Logan Adams',     'logan.adams@charlottelinks.co',   'Ethan R'),
('Benjamin Scott',  'ben.scott@uscreatoralliance.co',  'Grace T'),
('Benjamin Scott',  'ben.scott@uscreatoralliance.co',  'Jack N'),
('Benjamin Scott',  'ben.scott@uscreatoralliance.co',  'Lily D');

STEP 6: Insert lead data:
INSERT INTO leads (affiliate_id, lead_month, lead_email, customer_id) VALUES
(1,  '2025-08-01', 'hannahrwallor@gmail.com',        'cst001a9f5872a4e11'),
(2,  '2025-08-01', 'samanthacharlottestudio@gmail.com','cst002b7c4a60a5f22'),
(3,  '2025-08-01', 'luascreatorpro@gmail.com',        'cst003bd5b84fb33'),
(4,  '2025-08-01', 'misscreator@creator.com',          'cst004c6e6060g7h44'),
(5,  '2025-10-01', 'jarmail.academy@gmail.com',        'cst005e4f7d18h8b5'),
(6,  '2025-10-01', 'andrewslinkers@creatorband.co',   'cst006a2d9d7b6b76'),
(7,  '2025-11-01', 'nileshinterntech@gmail.com',       'cst007g2ih9f3i0k77'),
(8,  '2025-11-01', 'ameliawatneasponate@gmail.com',   'cst008i110g49k1l88'),
(9,  '2025-12-01', 'williamcreativekoja@gmail.com',   'cst009z1ih502m96'),
(10, '2025-12-01', 'paulycreator@creativeprince.co',  'cst010j3k261m3n10');

STEP 7: Insert monthly revenue data per customer:
#(0 = no payment that month, >0 = active/paying)
INSERT INTO monthly_revenue (customer_id, affiliate_id, revenue_month, revenue_amount) VALUES
-- Olivia Carter affiliates
('cst001a9f5872a4e11', 1, '2025-08-01', 0),
('cst001a9f5872a4e11', 1, '2025-09-01', 299),
('cst001a9f5872a4e11', 1, '2025-10-01', 199),
('cst001a9f5872a4e11', 1, '2025-11-01', 199),
('cst001a9f5872a4e11', 1, '2025-12-01', 199),
('cst001a9f5872a4e11', 1, '2026-01-01', 0),

('cst002b7c4a60a5f22', 2, '2025-08-01', 0),
('cst002b7c4a60a5f22', 2, '2025-09-01', 0),
('cst002b7c4a60a5f22', 2, '2025-10-01', 149),
('cst002b7c4a60a5f22', 2, '2025-11-01', 149),
('cst002b7c4a60a5f22', 2, '2025-12-01', 149),
('cst002b7c4a60a5f22', 2, '2026-01-01', 0),

('cst003bd5b84fb33',   3, '2025-08-01', 0),
('cst003bd5b84fb33',   3, '2025-09-01', 0),
('cst003bd5b84fb33',   3, '2025-10-01', 149),
('cst003bd5b84fb33',   3, '2025-11-01', 149),
('cst003bd5b84fb33',   3, '2025-12-01', 149),
('cst003bd5b84fb33',   3, '2026-01-01', 0),

('cst004c6e6060g7h44', 4, '2025-08-01', 100),
('cst004c6e6060g7h44', 4, '2025-09-01', 300),
('cst004c6e6060g7h44', 4, '2025-10-01', 300),
('cst004c6e6060g7h44', 4, '2025-11-01', 300),
('cst004c6e6060g7h44', 4, '2025-12-01', 0),
('cst004c6e6060g7h44', 4, '2026-01-01', 0),

-- Logan Adams affiliates
('cst005e4f7d18h8b5',  5, '2025-10-01', 0),
('cst005e4f7d18h8b5',  5, '2025-11-01', 249),
('cst005e4f7d18h8b5',  5, '2025-12-01', 0),
('cst005e4f7d18h8b5',  5, '2026-01-01', 0),

('cst006a2d9d7b6b76',  6, '2025-10-01', 0),
('cst006a2d9d7b6b76',  6, '2025-11-01', 0),
('cst006a2d9d7b6b76',  6, '2025-12-01', 89),
('cst006a2d9d7b6b76',  6, '2026-01-01', 100),

('cst007g2ih9f3i0k77', 7, '2025-11-01', 0),
('cst007g2ih9f3i0k77', 7, '2025-12-01', 100),
('cst007g2ih9f3i0k77', 7, '2026-01-01', 109),

-- Benjamin Scott affiliates
('cst008i110g49k1l88', 8, '2025-11-01', 0),
('cst008i110g49k1l88', 8, '2025-12-01', 499),
('cst008i110g49k1l88', 8, '2026-01-01', 499),

('cst009z1ih502m96',   9, '2025-12-01', 0),
('cst009z1ih502m96',   9, '2026-01-01', 299),

('cst010j3k261m3n10',  10,'2025-12-01', 199),
('cst010j3k261m3n10',  10,'2026-01-01', 0);
