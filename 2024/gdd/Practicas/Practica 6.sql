/*
1. Mostrar el Código del fabricante, nombre del fabricante, tiempo de entrega y monto
Total de productos vendidos, ordenado por nombre de fabricante. En caso que el
fabricante no tenga ventas, mostrar el total en NULO. */

SELECT m.manu_code, manu_name, COUNT(i.order_num) cantidad FROM manufact m
LEFT JOIN items i ON (i.manu_code=m.manu_code)
GROUP BY m.manu_name, m.manu_code
ORDER BY manu_name

/*
2.Mostrar en una lista de a pares, el código y descripción del producto, y los pares de
fabricantes que fabriquen el mismo producto. En el caso que haya un único fabricante
deberá mostrar el Código de fabricante 2 en nulo. Ordenar el resultado por código de
producto.*/

SELECT p.stock_num, p.manu_code, c1.manu_code, pt.description FROM products p
LEFT JOIN products c1 ON (c1.stock_num = p.stock_num AND c1.manu_code != p.manu_code) 
JOIN product_types pt ON (p.stock_num=pt.stock_num)
ORDER BY p.manu_code

/*3. Listar todos los clientes que hayan tenido más de una orden.
a) En primer lugar, escribir una consulta usando una subconsulta.
b) Reescribir la consulta utilizando GROUP BY y HAVING. */
SELECT lname, fname, c.customer_num from customer cJOIN orders o ON (c.customer_num = o.customer_num)WHERE c.customer_num IN (select customer_num from orders						 group by customer_num 						 having count(customer_num)>1 )/* 4. Seleccionar todas las Órdenes de compra cuyo Monto total (Suma de p x q de sus items)
sea menor al precio total promedio (avg p x q) de todas las líneas de las ordenes.
Formato de la salida: 
Nro. de Orden Total
(order_num) (suma) */SELECT order_num from orders


SELECT o.order_num 'Nro. de Orden', SUM (i.unit_price * i.quantity) Total FROM orders o
JOIN items i ON (o.order_num= i.order_num)
GROUP BY o.customer_num, o.order_num
HAVING SUM (i.unit_price * i.quantity) > (SELECT AVG (unit_price * quantity) from items)
ORDER BY o.customer_num


SELECT AVG(unit_price*quantity) from items
 

 /* 5. Obtener por cada fabricante, el listado de todos los productos de stock con precio
unitario (unit_price) mayor que el precio unitario promedio de dicho fabricante.
Los campos de salida serán: 
manu_code, manu_name, stock_num, description, unit_price. */

SELECT i.manu_code, m.manu_name, i.stock_num, pt.description, unit_price  FROM items i
JOIN product_types pt ON (pt.stock_num = i.stock_num)
JOIN manufact m ON (i.manu_code = m.manu_code)
WHERE i.unit_price > (SELECT AVG(unit_price) FROM products s2 					WHERE s2.manu_code = m.manu_code)
/* Usando el operador NOT EXISTS listar la información de órdenes de compra que NO
incluyan ningún producto que contenga en su descripción el string ‘ baseball gloves’.
Ordenar el resultado por compañía del cliente ascendente y número de orden
descendente. */

SELECT c.fname, c.lname, c.company, o.order_num FROM Orders o
JOIN customer c ON c.customer_num = o.customer_num
WHERE NOT EXISTS (SELECT item_num from items i
					JOIN product_types pt ON (i.stock_num= pt.stock_num)
					WHERE pt.description LIKE '%baseball gloves%'
					AND i.order_num = o.order_num)
ORDER BY c.company ASC, o.order_num DESC



/*Obtener el número, nombre y apellido de los clientes que NO hayan comprado productos
del fabricante ‘HSK’.*/

select customer_num,fname, lname FROM customer c
WHERE NOT EXISTS (SELECT i.manu_code from orders o 
				 JOIN items i ON i.order_num = o.order_num
				 WHERE i.manu_code = 'HSK' AND
				 o.customer_num = c.customer_num)

/*Obtener el número, nombre y apellido de los clientes que hayan comprado TODOS los
productos del fabricante ‘HSK’.*/

select customer_num,fname, lname FROM customer c
WHERE NOT EXISTS (SELECT i.manu_code from orders o 
				 JOIN items i ON i.order_num = o.order_num
				 WHERE i.manu_code = 'HSK' AND
				 o.customer_num = c.customer_num)


