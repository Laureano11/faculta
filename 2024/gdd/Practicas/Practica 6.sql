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

SELECT lname, fname, c.customer_num from customer c
JOIN orders o ON (c.customer_num = o.customer_num)
WHERE c.customer_num IN (select customer_num from orders
						 group by customer_num 
						 having count(customer_num)>1 )


/* 4. Seleccionar todas las Órdenes de compra cuyo Monto total (Suma de p x q de sus items)
sea menor al precio total promedio (avg p x q) de todas las líneas de las ordenes.
Formato de la salida: 
Nro. de Orden Total
(order_num) (suma) 
*/
SELECT order_num from orders


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
WHERE i.unit_price > (SELECT AVG(unit_price) FROM products s2 
					WHERE s2.manu_code = m.manu_code)

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

/*Reescribir la siguiente consulta utilizando el operador UNION:
SELECT * FROM products
WHERE manu_code = ‘HRO’ OR stock_num = 1  */




SELECT * FROM products
where manu_code= 'HRO'
UNION
SELECT * FROM products
where stock_num=1
order by 2 ASC

/* 10. Desarrollar una consulta que devuelva las ciudades y compañías de todos los Clientes
ordenadas alfabéticamente por Ciudad pero en la consulta deberán aparecer primero las
compañías situadas en Redwood City y luego las demás. */


SELECT 1 sortkey, city ciudad FROM customer WHERE city = 'Redwood City'
UNION 
SELECT 2 sortkey, city ciudad FROM customer where city != 'Redwood City'
order by sortkey, city

/*Desarrollar una consulta que devuelva los dos tipos de productos más vendidos y los dos
menos vendidos en función de las unidades totales vendidas. */


SELECT TOP 2 1 sortkey, item_num, SUM(quantity) cantidad from items 
group by item_num
UNION
SELECT 2 sortkey,item_num, SUM(i.quantity) cantidad
FROM items i
WHERE i.item_num in (SELECT TOP 2 i2.item_num from items i2 
					group by i2.item_num
					order by SUM(i2.quantity) ASC)
group by i.item_num
order by sortkey





/* Transacciones
Escriba una transacción que incluya las siguientes acciones:
• BEGIN TRANSACTION
o Insertar un nuevo cliente llamado “Fred Flintstone” en la tabla de
clientes (customer).
o Seleccionar todos los clientes llamados Fred de la tabla de clientes
(customer).
• ROLLBACK TRANSACTION
*/

BEGIN TRANSACTION
insert INTO customer (fname, lname, customer_num) 
VALUES ('Fred','Flintstone',1005)
SELECT fname, lname FROM customer
WHERE fname = 'Fred'
ROLLBACK TRANSACTION


/* 15. Se ha decidido crear un nuevo fabricante AZZ, quién proveerá parte de los mismos
productos que provee el fabricante ANZ, los productos serán los que contengan el string
‘tennis’ en su descripción.
• Agregar las nuevas filas en la tabla manufact y la tabla products.
• El código del nuevo fabricante será “AZZ”, el nombre de la compañía “AZZIO SA”
y el tiempo de envío será de 5 días (lead_time).
• La información del nuevo fabricante “AZZ” de la tabla Products será la misma
que la del fabricante “ANZ” pero sólo para los productos que contengan 'tennis'
en su descripción.
• Tener en cuenta las restricciones de integridad referencial existentes, manejar
todo dentro de una misma transacción. 
*/


BEGIN TRANSACTION
insert INTO manufact (manu_code, manu_name, lead_time)
values('AZZ','AZZIO SA',5)
insert INTO products (stock_num, manu_code, unit_price, unit_code)
SELECT p.stock_num, 'AZZ',p.unit_price,p.unit_code from products p
		JOIN product_types pt ON p.stock_num=pt.stock_num 
		WHERE p.manu_code = 'ANZ' AND pt.description LIKE '%tennis%'
ROLLBACK TRANSACTION

select 'AZZ', unit_price From products



