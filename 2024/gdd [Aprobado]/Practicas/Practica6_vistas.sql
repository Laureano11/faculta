CREATE VIEW vista2 
AS 
	SELECT * From products
	WHERE manu_code = 'HRO'
	WITH CHECK OPTION


Select* from vista2



CREATE VIEW vista
AS
	SELECT lname, fname, c.customer_num from customer c
	JOIN orders o ON (c.customer_num = o.customer_num)
	WHERE c.customer_num IN (select customer_num from orders
						 group by customer_num 
						 having count(order_num)>1 )

