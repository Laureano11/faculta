--Ejercicio 1
SELECT company, order_num, c.customer_num
FROM orders o JOIN customer c ON (c.customer_num = o.customer_num) 
ORDER BY c.customer_num


-- Ejercicio 2

SELECT o.order_num, i.item_num, pt.description, i.manu_code, i.quantity, (i.quantity*i.unit_price) precio_total
FROM orders o
	JOIN items i ON (o.order_num= i.order_num)
	JOIN product_types pt ON (pt.stock_num= i.stock_num)
WHERE o.order_num=1004
ORDER BY precio_total


-- Ejercicio 3

SELECT o.order_num, i.item_num, pt.description, i.manu_code, i.quantity, mf.manu_name,(i.quantity*i.unit_price) precio_total
FROM orders o
	JOIN items i ON (o.order_num= i.order_num)
	JOIN product_types pt ON (pt.stock_num= i.stock_num)
	JOIN manufact mf ON (mf.manu_code = i.manu_code)
WHERE o.order_num=1004



-- Ejercicio 4

SELECT c.fname, c.lname, c.company, o.order_num
FROM orders o
	JOIN customer c ON (c.customer_num=o.customer_num)
ORDER BY 3,2

-- Ejercicio 5

SELECT DISTINCT c.fname, c.lname, c.company, o.order_num
FROM orders o
	JOIN customer c ON (c.customer_num=o.customer_num)
ORDER BY 3,2

-- Ejercicio 6

SELECT p.stock_num, mf.manu_name, pt.description, u.unit, p.unit_price, (p.unit_price*1.20) precio_junio
	FROM products p
		JOIN manufact mf ON (p.manu_code= mf.manu_code)
		JOIN product_types pt ON (pt.stock_num = p.stock_num)
		JOIN units u ON (u.unit_code = p.unit_code)

-- Ejercicio 7 

SELECT i.item_num, pt.description, i.quantity, (i.quantity*i.unit_price) precio_total
	FROM items i
		JOIN product_types pt ON (i.stock_num = pt.stock_num)
		JOIN orders o ON (o.order_num = i.order_num)
WHERE o.order_num = 1004


-- Ejercicio 8

SELECT mf.manu_name, mf.lead_time, o.customer_num
	FROM orders o
		JOIN items i ON (i.order_num = o.order_num)
		JOIN manufact mf ON (mf.manu_code = i.manu_code)
WHERE o.customer_num = 104

-- Ejercicio 9
-- Mas de lo mismo

-- Ejercicio 10

SELECT (lname+ ', ' + fname) Apellido_Nombre, '('+ SUBSTRING(phone,1,3) +')' + SUBSTRING(phone,4,11) numero FROM customer
ORDER BY 1

-- Ejercicio 11




SELECT 
    c.customer_num,
    (lname + ', ' + fname) AS apellido_nombre,
    COUNT(o.order_num) AS cantidad_ordenes,
    o.ship_date,
    s.sname,
    c.zipcode
FROM 
    orders o
JOIN  
    customer c ON o.customer_num = c.customer_num
JOIN 
    state s ON c.state = s.state
WHERE 
    s.sname = 'California' 
    AND c.zipcode <= 94100 
    AND c.zipcode >= 94000
GROUP BY 
    c.customer_num,
    lname,
    fname,
    o.ship_date,
    s.sname,
    c.zipcode
ORDER BY 
    2;
