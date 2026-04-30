/*
Classwork 1 — Query the Views

Use vw_orders or vw_sales_summary to answer each question.
*/

DROP VIEW IF EXISTS vw_orders;
GO

CREATE VIEW vw_orders AS
SELECT *
FROM (
    VALUES
    --  order_id  customer   product        order_date     qty  unit_price  promo_code
        (1,  'Alice',   'Latte',       '2024-01-05',   2,   3.50,  'SAVE10'),
        (2,  'Bob',     'Espresso',    '2024-01-12',   1,   2.00,   NULL   ),
        (3,  'Clara',   'Cappuccino',  '2024-02-03',   3,   3.20,  'SAVE10'),
        (4,  'David',   'Latte',       '2024-02-18',   1,   3.50,   NULL   ),
        (5,  'Eve',     'Tea',         '2024-03-07',   4,   1.80,   NULL   ),
        (6,  'Frank',   'Espresso',    '2024-03-22',   2,   2.00,  'VIP20' ),
        (7,  'Grace',   'Cappuccino',  '2024-04-10',   1,   3.20,   NULL   ),
        (8,  'Henry',   'Latte',       '2024-04-25',   5,   3.50,  'VIP20' ),
        (9,  'Isla',    'Tea',         '2024-05-01',   2,   1.80,   NULL   ),
        (10, 'James',   'Espresso',    '2024-05-14',   3,   2.00,  'SAVE10')
) AS t(order_id, customer, product, order_date, qty, unit_price, promo_code);
GO

/* Q1. Find all orders for 'Latte' or 'Cappuccino' where the quantity is greater than 1.
Return the customer name, product, and quantity. */
SELECT 
    customer, 
    product,
    qty
FROM vw_orders
WHERE product IN ('Latte', 'Cappuccino') 
    AND qty > 1;

/* Q2. Find all orders placed between '2024-02-01' and '2024-04-30' 
where a promo code was used.
Return the customer, product, order date, and promo code. */
SELECT 
    customer, 
    product,
    order_date,
    promo_code
FROM vw_orders
WHERE order_date BETWEEN '2024-02-01' AND '2024-04-30'
    AND promo_code IS NOT NULL;

/* Q3. Find all customers whose name starts with the letters A, E, or I.
(Hint: three LIKE conditions joined with OR) */

SELECT 
    customer
FROM vw_orders
WHERE LEFT(customer, 1) IN ('A', 'E', 'I');

/* Q4. Find all orders where the promo code is NULL or the quantity is exactly 1. */
SELECT 
    customer, 
    product
FROM vw_orders
WHERE qty = 1
    AND promo_code IS NULL;

/* Q5. Using vw_sales_summary, show only the products whose total revenue across all months is greater than £200.
(Hint: GROUP BY + HAVING) */

DROP VIEW IF EXISTS vw_sales_summary;
GO

CREATE VIEW vw_sales_summary AS
SELECT *
FROM (
    VALUES
    --  sale_id  product        month        units_sold  revenue
        (1,  'Latte',       'January',    45,   157.50),
        (2,  'Espresso',    'January',    30,    60.00),
        (3,  'Cappuccino',  'January',    20,    64.00),
        (4,  'Tea',         'January',    10,    18.00),
        (5,  'Latte',       'February',   50,   175.00),
        (6,  'Espresso',    'February',   25,    50.00),
        (7,  'Cappuccino',  'February',   15,    48.00),
        (8,  'Tea',         'February',    5,     9.00),
        (9,  'Latte',       'March',      60,   210.00),
        (10, 'Espresso',    'March',      40,    80.00),
        (11, 'Cappuccino',  'March',      30,    96.00),
        (12, 'Tea',         'March',       8,    14.40)
) AS t(sale_id, product, month, units_sold, revenue);
GO

SELECT
    product,
    SUM(revenue) AS total_revenue
FROM vw_sales_summary
GROUP BY product
HAVING SUM(revenue) > 200;

/*
Classwork 2 — Build Your Own View

Your turn. Create a view from scratch — no tables, just VALUES.

Pick any topic you like: a playlist, a football table, a menu, a list of films, your favourite snacks — anything simple and easy to work with.

Create a view called vw_my_data that meets these requirements:

Requirement	Detail
At least 5 columns	Include at least one number, one text column, and one nullable column
At least 8 rows	Mix your values so filters produce interesting results
DROP + CREATE	Follow the same structure as the session views above
Once your view is created, write three queries against it that each use at least one of:

A WHERE clause with AND / OR and parentheses
BETWEEN or IN
IS NULL or IS NOT NULL
Be ready to demo your view and queries to the group.

*/
DROP VIEW IF EXISTS vw_movies;
GO

CREATE VIEW vw_movies AS
SELECT *

FROM (VALUES
    (1, 'Inception', 'Sci-Fi', 2010, 8.8, 'Nolan'),
    (2, 'Titanic', 'Romance', 1997, 7.9, NULL),
    (3, 'The Dark Knight', 'Action', 2008, 9.0, 'Nolan'),
    (4, 'Avengers: Endgame', 'Action', 2019, 8.4, NULL),
    (5, 'The Notebook', 'Romance', 2004, 7.8, NULL),
    (6, 'Interstellar', 'Sci-Fi', 2014, 8.6, 'Nolan'),
    (7, 'Joker', 'Drama', 2019, 8.5, NULL),
    (8, 'Parasite', 'Thriller', 2019, 8.6, 'Bong')

) AS t(id, title, genre, release_year, rating, director)
GO


-- Movies of genre action or sci-fi with a rating of greater than 8.5.
SELECT *
FROM vw_movies
WHERE (genre = 'Action' OR genre = 'Sci-Fi')
AND rating > 8.5;

-- Movies of genre drama or thriller, released between 2000 and 2020.
SELECT *
FROM vw_movies
WHERE release_year BETWEEN 2000 AND 2020
AND genre IN ('Drama', 'Thriller');


-- Movies with no director recorded (NULL values).
SELECT *
FROM vw_movies
WHERE director IS NULL;