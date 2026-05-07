
-- Drop and recreate — run both blocks together
DROP VIEW IF EXISTS vw_orders;
GO

CREATE VIEW vw_orders AS
SELECT *
FROM (
    VALUES
    --  order_id  customer   product   order_date     qty  unit_price  promo_code
        (1,  'Alice',  'Latte',       '2024-01-05',   NULL, 3.50, 'SAVE10'),
        (2,  'Bob',    'Espresso',    '2024-01-12',   1,   2.00,  NULL   ),
        (3,  'Clara',  'Cappuccino',  '2024-02-03',   3,   3.20, 'SAVE10'),
        (4,  'David',  'Latte',       '2024-02-18',   1,   3.50,  NULL   ),
        (5,  'Eve',    'Tea',         '2024-03-07',   4,   1.80,  NULL   ),
        (6,  'Frank',  'Espresso',    '2024-03-22',   2,   2.00, 'VIP20' ),
        (7,  'Grace',  'Cappuccino',  '2024-04-10',   1,   3.20,  NULL   ),
        (8,  'Henry',  'Latte',       '2024-04-25',   5,   3.50, 'VIP20' ),
        (9,  'Isla',   'Tea',         '2024-05-01',   2,   1.80,  NULL   ),
        (10, 'James',  'Espresso',    '2024-05-14',   3,   2.00, 'SAVE10')
) AS t(order_id, customer, product, order_date, qty, unit_price, promo_code);
GO

-- Quick sanity check — you should see 10 rows
SELECT * FROM vw_orders;

-- Exercise 1

-- Add a column called drink_category that labels each product as 'Hot Drink' (Latte or Cappuccino), 
-- 'Coffee Shot' (Espresso), or 'Cold Drink' (Tea). Return customer, product, and your new column.

-- Hint: Simple CASE on the product column.

SELECT
    customer,
    product,
    CASE product
        WHEN 'Latte'      THEN 'Latte (Hot Drink)'
        WHEN 'Espresso'   THEN 'Coffee Shot'
        WHEN 'Cappuccino' THEN 'Cappuccino (Hot Drink)'
        WHEN 'Tea'        THEN 'Tea (Cold Drink)'
        ELSE                   'Other'
    END AS drink_category
FROM vw_orders;

-- Exercise 2

-- Create a column called spend_band based on the total line value (qty × unit_price): 'Under £5', 
-- '£5–£10', or 'Over £10'. Show customer, product, the calculated total, and your band.

-- Hint: Searched CASE using qty * unit_price in the WHEN conditions.

SELECT
    customer,
    product,
    qty * unit_price AS total,
    CASE
        WHEN qty * unit_price < 5 THEN 'Under £5'
        WHEN qty * unit_price BETWEEN 5 AND 10 THEN '£5–£10'
        WHEN qty * unit_price > 10 THEN 'Over £10'
        ELSE NULL
    END AS spend_band
FROM vw_orders;


-- Exercise 3

-- Write a GROUP BY query that shows, for each product: total orders, the count of orders with a promo code, 
-- and the count without one. Name your columns clearly.

--Hint: COUNT(CASE WHEN ... THEN 1 END) — remember no ELSE for COUNT.

SELECT product,
        COUNT(*) AS total_orders,
        COUNT(CASE WHEN promo_code IS NOT NULL THEN 1 END) AS orders_with_promo,
        COUNT(CASE WHEN promo_code IS NULL THEN 1 END) AS orders_without_promo
    FROM vw_orders
    GROUP BY product;


-- Exercise 4

-- Return all orders sorted so that VIP20 promo orders appear first, then SAVE10 orders, 
-- then orders with no promo code. Within each group, sort by customer name A–Z.

SELECT *,
    CASE

		WHEN promo_code = 'VIP20' THEN 'VIP20' 
        WHEN promo_code = 'SAVE10' THEN 'SAVE10'
        WHEN promo_code IS NULL THEN  'No Promo Code' 

        ELSE 'Invalid promo code' 

    END AS order_promo 

    FROM vw_orders 

    ORDER BY 
	    CASE  

            WHEN promo_code = 'VIP20' THEN 1
            WHEN promo_code = 'SAVE10' THEN 2
            WHEN promo_code IS NULL THEN 3
            ELSE 4
    END,
    customer ASC;



-- Exercise 5 — stretch

-- Build a single summary row (no GROUP BY) showing total revenue split into three columns: premium_revenue (unit_price ≥ £3.00), standard_revenue (£2.00–£2.99), and budget_revenue (below £2.00).

-- Hint: SUM(CASE ... ELSE 0 END) — three separate SUM/CASE expressions in one SELECT.

SELECT
   
    SUM(CASE WHEN unit_price >= 3.00 THEN qty * unit_price ELSE 0 END) AS premium_revenue,
    SUM(CASE WHEN unit_price >= 2.00 AND unit_price < 3.00 THEN qty * unit_price ELSE 0 END) AS standard_revenue,
    SUM(CASE WHEN unit_price < 2.00 THEN qty * unit_price ELSE 0 END) AS budget_revenue
FROM vw_orders;