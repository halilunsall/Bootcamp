;WITH t1 AS(
		SELECT *, AVG(total_quantity) OVER(PARTITION BY product_id ORDER BY product_id) as avg_quantity
		FROM(	SELECT DISTINCT product_id, discount, 
				SUM(quantity) OVER(PARTITION BY product_id, discount) as total_quantity
				FROM sale.order_item) as t)
,t2 AS (
		SELECT *, CASE
					WHEN total_quantity > avg_quantity THEN 'Positive'
					WHEN total_quantity < avg_quantity THEN 'Negative' ELSE 'Neutral' END as status
		FROM t1), t3 AS (
SELECT *
FROM t2
PIVOT (
		COUNT(status)
		FOR status IN(
		[Positive],
		[Negative],
		[Neutral])
) AS pvt), t4 AS (
SELECT product_id, SUM(Positive) as Positive, SUM(Negative) as Negative, SUM(Neutral) as Neutral
FROM t3
GROUP BY product_id)
SELECT product_id, CASE
				WHEN Positive > Negative THEN 'Positive'
				WHEN Positive < Negative THEN 'Negative'
				WHEN Positive = Negative THEN 'Neutral'
END Discount_Effect
FROM t4
