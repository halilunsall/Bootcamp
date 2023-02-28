/*
1. Product Sales
You need to create a report on whether customers who purchased the product named '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD' buy the product below or not.

1. 'Polk Audio - 50 W Woofer - Black' -- (other_product)

To generate this report, you are required to use the appropriate SQL Server Built-in functions or expressions as well as basic SQL knowledge.
*/

CREATE VIEW v_customer AS
SELECT cus.customer_id, cus.first_name, cus.last_name, pro.product_name
FROM sale.customer cus 
INNER JOIN sale.orders ord ON cus.customer_id=ord.customer_id
INNER JOIN sale.order_item oi ON ord.order_id=oi.order_id
INNER JOIN product.product pro ON oi.product_id=pro.product_id

SELECT DISTINCT customer_id, first_name,last_name,
	CASE
		WHEN product_name='Polk Audio - 50 W Woofer - Black' THEN 'Yes'
		WHEN product_name!='Polk Audio - 50 W Woofer - Black' THEN 'No' END other_product
FROM v_customer
WHERE customer_id IN
		(SELECT DISTINCT customer_id
		FROM v_customer
		WHERE product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD')
ORDER BY customer_id

/*
2. Conversion Rate
Below you see a table of the actions of customers visiting the website by clicking on two different types of advertisements given by 
an E-Commerce company. Write a query to return the conversion rate for each Advertisement type.
*/

--A)    Create above table (Actions) and insert values,

CREATE TABLE Actions (
   Visitor_ID INT PRIMARY KEY,
   Adv_Type VARCHAR(255) NOT NULL,
   Action VARCHAR(255) NOT NULL
);

INSERT INTO Actions(Visitor_ID, Adv_Type, Action)
VALUES (1, 'A', 'Left'),
(2, 'A', 'Order'),
(3, 'B', 'Left'),
(4, 'A', 'Order'),
(5, 'A', 'Review'),
(6, 'A', 'Left'),
(7, 'B', 'Left'),
(8, 'B', 'Order'),
(9, 'B', 'Review'),
(10, 'A', 'Review');

SELECT *
FROM Actions


--B)    Retrieve count of total Actions and Orders for each Advertisement Type,

CREATE VIEW v_adc_order_status AS
SELECT *, CASE WHEN Action='Order' THEN 1 ELSE 0 END order_status
FROM Actions

SELECT Adv_Type, COUNT(Action) action_num, SUM(order_status) order_num
FROM v_adc_order_status
GROUP BY Adv_Type


--C)    Retrieve count of total Actions and Orders for each Advertisement Type,

SELECT Adv_Type, CONVERT(DECIMAL(2,2),SUM(order_status)*1.0/COUNT(Action)) 'Conversion_Rate'
FROM v_adc_order_status
GROUP BY Adv_Type




