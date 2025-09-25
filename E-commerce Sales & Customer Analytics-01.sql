Create DATABASE e_commerce;
USE e_commerce;
SELECT * FROM customers ;
SELECT * FROM payments;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

-- All Tables with inner join. 
SELECT * FROM Customers C 
Join orders O   
on C.customer_id = O.customer_id
Join payments p  
ON p.order_id = O.order_id;
SELECT * FROM Customers where customer_id is NULL;



-- Customers who are never place a order. 
SELECT 
    C.customer_id,
    CONCAT(first_name, ' ', last_name) AS Full_Name
FROM Customers C
LEFT JOIN Orders O 
    ON C.customer_id = O.customer_id
WHERE O.order_id IS NULL;


-- Top 10 Customers by total spending. 
SELECT  distinct C.customer_id, concat(first_name, ' ', last_name) as Full_Name, SUM(total_amount) as TOP_SPENDERS  FROM Customers C 
Join orders O   
on C.customer_id = O.customer_id
Join payments p  
ON p.order_id = O.order_id Group by C.customer_id, Full_Name order by TOP_SPENDERS DESC limit 10 ;

-- Hightest costly product stored in warehouse.
SELECT group_concat(product_name separator ',') as all_products, group_concat( price * stock_quantity) as total_amount, category 
FROM products group by category order by total_amount DESC LIMIT 1;

-- Highest revenue generated product catagory. 
SELECT 
    category,
    SUM(OI.price * quantity) AS total_revenue
FROM order_items OI
JOIN products P ON OI.product_id = P.product_id
GROUP BY category
ORDER BY total_revenue DESC limit 1;

-- Avarage order value (AOV) by country
SELECT country, SUM(price*quantity) / COUNT(DISTINCT O.order_id) as AOV FROM 
customers C 
JOIN orders O 
ON C.customer_id = O.customer_id
JOIN order_items OI 
on O.order_id = OI.order_id GROUP BY country ORDER BY AOV DESC;

-- Monthly sales trend forecast last 12 months
SELECT date_format(order_date, '%Y-%M') as month,
SUM(total_amount) as total_sales FROM orders
where order_date >= date_sub(curdate(), INTERVAL 12 MONTH)
group by DATE_FORMAT(order_date, '%Y-%M')
ORDER BY month ASC;

-- Refund rate per payment method
SELECT payment_method, 
COUNT(CASE WHEN payment_status = 'Refunded' THEN 1 END) * 100.00 / COUNT(*) as refunded_rate FROM payments
group by payment_method ORDER BY refunded_rate DESC;


                                                                                                           -- End of the project--













