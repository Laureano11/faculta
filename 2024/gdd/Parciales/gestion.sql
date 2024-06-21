use GD2015C1

select clie_razon_social AS 'Cliente',
	ISNULL(SUM(item_cantidad), 0) AS 'Unidades compradas',
	ISNULL((SELECT TOP 1 item_producto FROM Factura
	JOIN Item_Factura ON fact_numero + fact_sucursal +fact_tipo = 
	item_numero + item_sucursal + item_tipo
	WHERE fact_cliente = clie_codigo
	GROUP BY fact_cliente, item_producto 
	ORDER BY SUM(item_cantidad) DESC, item_producto ASC), 0) AS 'Producto mas comprado'
FROM Cliente
JOIN Factura ON clie_codigo = fact_cliente
JOIN Item_Factura ON fact_numero + fact_sucursal + fact_tipo = 
item_numero + item_sucursal + item_tipo
WHERE YEAR(fact_fecha) = 2012
GROUP BY clie_codigo, clie_razon_social, clie_domicilio
HAVING SUM(item_cantidad) < (1.00/3) * 
(SELECT TOP 1 SUM(item_cantidad) FROM Factura
JOIN Item_Factura ON fact_numero + fact_sucursal +fact_tipo = 
item_numero + item_sucursal + item_tipo 
WHERE YEAR(fact_fecha) = 2012
GROUP BY item_producto
ORDER BY SUM(item_cantidad) DESC)
ORDER BY clie_domicilio ASC

--------------------------17-------------------------

SELECT 
	CONCAT(YEAR(F1.fact_fecha), RIGHT('0' + RTRIM(MONTH(F1.fact_fecha)), 2)) AS 'Periodo',
	prod_codigo AS 'Codigo',
	ISNULL(prod_detalle, 'SIN DESCRIPCION') AS 'Producto',
	ISNULL(SUM(item_cantidad), 0) AS 'Cantidad vendida',
	ISNULL((SELECT SUM(item_cantidad) FROM Item_Factura
	JOIN Factura F2 ON item_numero + item_sucursal + item_tipo =
	F2.fact_numero + F2.fact_sucursal + F2.fact_tipo  
	WHERE item_producto = prod_codigo 
	AND YEAR(F2.fact_fecha) = YEAR(F1.fact_fecha) - 1
	AND MONTH(F2.fact_fecha) = MONTH(F1.fact_fecha)), 0) AS 'Cantidad vendida anterior',
	ISNULL(COUNT(*) , 0) AS 'Cantidad de facturas'
FROM Producto
JOIN Item_Factura ON prod_codigo = item_producto
JOIN Factura F1 ON item_numero + item_sucursal + item_tipo =
F1.fact_numero + F1.fact_sucursal + F1.fact_tipo
GROUP BY prod_codigo, prod_detalle, YEAR(F1.fact_fecha), MONTH(F1.fact_fecha)
ORDER BY 2,1

--------------------------18-------------------------
/*Escriba una consulta que retorne una estadística de ventas para todos los rubros.
DETALLE_RUBRO: Detalle del rubro
VENTAS: Suma de las ventas en pesos de productos vendidos de dicho rubro
PROD1: Código del producto más vendido de dicho rubro
PROD2: Código del segundo producto más vendido de dicho rubro
CLIENTE: Código del cliente que compro más productos del rubro en los últimos 30 días*/

select r.rubr_detalle as DETALLE_RUBRO,
       sum(i.item_cantidad * i.item_precio) as VENTAS,
	   (SELECT TOP 1 i1.item_producto from Item_Factura i1 inner join producto p on p.prod_codigo = i1.item_producto
	   where p.prod_rubro = r.rubr_id group by i1.item_producto order by sum(i1.item_cantidad) desc) as PROD1,
	   isnull((SELECT TOP 1 i2.item_producto from Item_Factura i2 inner join producto p on p.prod_codigo = i2.item_producto
	   where p.prod_rubro = r.rubr_id and i2.item_producto <>
	  (SELECT TOP 1 i1.item_producto from Item_Factura i1 inner join producto p on p.prod_codigo = i1.item_producto
	   where p.prod_rubro = r.rubr_id group by i1.item_producto order by sum(i1.item_cantidad) desc)
	   group by i2.item_producto order by sum(i2.item_cantidad) desc), '----') as PROD2,
	   ISNULL((SELECT top 1 F.fact_cliente FROM FACTURA F INNER JOIN Item_Factura ON item_numero + item_sucursal + item_tipo =
	   fact_numero + fact_sucursal + fact_tipo inner join producto p1 on p1.prod_codigo = item_producto WHERE 
			YEAR(cast(GETDATE() as date)) = YEAR(cast(fact_fecha as date)) AND
			MONTH(cast(GETDATE() as date)) = MONTH(cast(fact_fecha as date)) AND
			DAY(cast(GETDATE() as date)) - DAY(cast(fact_fecha as date)) < 5000
	   AND p1.prod_rubro = r.rubr_id group by fact_cliente
	   order by COUNT(DISTINCT item_producto)), '----')
	   AS CLIENTE
	   from Rubro r
	   inner join Producto p on p.prod_rubro = r.rubr_id
	   inner join Item_Factura i on i.item_producto = p.prod_codigo
	   group by r.rubr_detalle, r.rubr_id
	   order by COUNT(DISTINCT I.item_producto)

	   SELECT GETDATE()
	   SELECT CAST(FACT_fECHA AS DATE) - CAST(GETDATE() AS DATE) FROM FACTURA
	   
	SELECT 
	ISNULL(rubr_detalle, 'Sin descripcion') AS 'Rubro',
	ISNULL(SUM(item_cantidad * item_precio), 0) AS 'Ventas',
	ISNULL((SELECT TOP 1 item_producto
	FROM Producto
	JOIN Item_Factura ON prod_codigo = item_producto
	WHERE prod_rubro = rubr_id
	GROUP BY item_producto
	ORDER BY SUM(item_cantidad) DESC), 0) AS '1� Producto',
	ISNULL((SELECT TOP 1 item_producto FROM Producto
	JOIN Item_Factura ON prod_codigo = item_producto
	WHERE prod_rubro = rubr_id
	AND item_producto NOT IN
		(SELECT TOP 1 item_producto FROM Producto
		JOIN Item_Factura ON prod_codigo = item_producto
		WHERE prod_rubro = rubr_id
		GROUP BY item_producto
		ORDER BY SUM(item_cantidad) DESC) 
	GROUP BY item_producto
	ORDER BY SUM(item_cantidad) DESC), '--------') AS '2� Producto',
	ISNULL((SELECT TOP 1 fact_cliente
	FROM Producto
	JOIN Item_Factura ON prod_codigo = item_producto
	JOIN Factura ON item_numero + item_sucursal + item_tipo =
	fact_numero + fact_sucursal + fact_tipo
	WHERE fact_fecha >
	(SELECT DATEADD(DAY, -30, MAX(fact_fecha)) FROM Factura)
	AND prod_rubro = rubr_id
	GROUP BY fact_cliente
	ORDER BY SUM(item_cantidad) DESC), '--------') AS 'Cliente'
FROM Rubro
JOIN Producto ON rubr_id = prod_rubro
JOIN Item_Factura ON prod_codigo = item_producto
GROUP BY rubr_id, rubr_detalle
ORDER BY COUNT(DISTINCT prod_codigo)

---------------------------19-------------------------------------
/*En virtud de una recategorizacion de productos referida a la familia de los mismos se solicita que desarrolle una consulta sql que retorne para todos 
los productos:
Codigo de producto - Detalle del producto
 Codigo de la familia del producto - Detalle de la familia actual del producto
 Codigo de la familia sugerido para el producto - Detalla de la familia sugerido para el producto
La familia sugerida para un producto es la que poseen la mayoria de los productos cuyo
detalle coinciden en los primeros 5 caracteres.
En caso que 2 o mas familias pudieran ser sugeridas se debera seleccionar la de menor
codigo. Solo se deben mostrar los productos para los cuales la familia actual sea
diferente a la sugerida
Los resultados deben ser ordenados por detalle de producto de manera ascendente*/

select p.prod_codigo,
	   p.prod_detalle,
	   p.prod_familia as CodFamiActual,
	   f.fami_detalle as FamiliaActual,
	   (select top 1 p1.prod_familia from Producto p1 where SUBSTRING(p1.prod_detalle,0,6) = SUBSTRING(p.prod_detalle,0,6)
			group by p1.prod_familia
			order by count(p1.prod_codigo) desc, p1.prod_familia asc) as CodFamiSugerida,
	   (select top 1 f1.fami_detalle from Familia f1 inner join Producto p2 on f1.fami_id = p2.prod_familia
			where SUBSTRING(p2.prod_detalle,0,6) = SUBSTRING(p.prod_detalle,0,6)
			group by f1.fami_id, f1.fami_detalle,p2.prod_familia
			order by count(p2.prod_codigo) desc, p2.prod_familia asc) as FamiliaSugerida
	   from Producto p 
	   inner join Familia F on f.fami_id = p.prod_familia
	   order by 2 

	  select * from producto order by prod_detalle --ALF. CHOCOLATE X 50g. ALF. MILKA MOUSSE X 55g. deberia ser 81 y no 997 
	  select * from familia order by fami_detalle 
	  use GD2015C1
	   select p1.prod_familia from Producto p1 where SUBSTRING(p1.prod_detalle,0,6) = SUBSTRING('ALF. MILKA MOUSSE X 55g.      ',0,6)
			group by p1.prod_familia
			order by count(p1.prod_codigo) desc, p1.prod_familia asc

		select fami_detalle, fami_id from Familia inner join Producto p2 on fami_id = p2.prod_familia
			where SUBSTRING(p2.prod_detalle,0,6) = SUBSTRING('ALF. MILKA MOUSSE X 55g.      ',0,6)
			group by fami_id, fami_detalle,p2.prod_familia
			order by count(p2.prod_codigo) desc, p2.prod_familia asc
                
---------------------------------20----------------------------------------
/*Escriba una consulta sql que retorne un ranking de los mejores 3 empleados del 2012 Se debera retornar legajo, nombre y apellido, anio de ingreso,
puntaje 2011, puntaje 2012. El puntaje de cada empleado se calculara de la siguiente manera: para los que hayan vendido al menos 50 facturas el
puntaje se calculara como la cantidad de facturas que superen los 100 pesos que haya vendido en el año, para los que tengan menos de 50
facturas en el año el calculo del puntaje sera el 50% de cantidad de facturas realizadas por sus subordinados directos en dicho año.*/

select top 3 e.empl_codigo as LEGAJO,
			 e.empl_nombre,
			 e.empl_apellido,
			 year(e.empl_ingreso) as INGRESO,
			 (select case 
			 when COUNT(f.fact_numero + f.fact_sucursal + f.fact_tipo) >= 50 then (select count(*) from factura f1 
				where f1.fact_vendedor = e.empl_codigo AND year(F1.fact_fecha) = 2011 and f1.fact_total > 100 )
			 ELSE (select count(*)/2 from factura f2 where f2.fact_vendedor in (select e1.empl_codigo from empleado e1 where e1.empl_jefe = e.empl_codigo) 
			 and year(F2.fact_fecha) = 2011 )
			 end
			 from Factura f where f.fact_vendedor = e.empl_codigo AND year(F.fact_fecha) = 2011) AS PUNTAJE2011,
			 (select case 
			 when COUNT(f.fact_numero + f.fact_sucursal + f.fact_tipo) >= 50 then (select count(*) from factura f1 
				where f1.fact_vendedor = e.empl_codigo AND year(F1.fact_fecha) = 2012 and f1.fact_total > 100 )
			 ELSE (select count(*)/2 from factura f2 where f2.fact_vendedor in (select e1.empl_codigo from empleado e1 where e1.empl_jefe = e.empl_codigo) 
			 and year(F2.fact_fecha) = 2012)
			 end
			 from Factura f where f.fact_vendedor = e.empl_codigo AND year(F.fact_fecha) = 2012) AS PUNTAJE2012
			 from Empleado e
			 order by PUNTAJE2012 DESC, PUNTAJE2011 DESC
			 go
------------------------------------14t------------------------------------
/*Agregar el/los objetos necesarios para que si un cliente compra un producto compuesto a un precio menor que la suma de los
precios de sus componentes que imprima la fecha, que cliente, que productos y a qué precio se realizó la compra. No se deberá 
permitir que dicho precio sea menor a la mitad de la suma de los componentes.*/
SELECT * FROM Item_Factura
GO

CREATE TRIGGER T14 ON Item_Factura FOR insert 
AS
BEGIN
	DECLARE NUEVOS cursor for select * from inserted i
	DECLARE @PRECIOCOMBO DECIMAL(12,2)
	DECLARE @ITEMCANT DECIMAL(12,2)
	DECLARE @PRODUCTOID CHAR(8)
	DECLARE @FACTURAID CHAR(8)
	DECLARE @TIPO CHAR(1)
	DECLARE @SUCURSAL CHAR(4)
	DECLARE @FECHA SMALLDATETIME
	DECLARE @CLI CHAR(100)
	DECLARE @PRECIO DECIMAL(12,2)
	
	OPEN NUEVOS
	FETCH NEXT FROM NUEVOS INTO @TIPO, @SUCURSAL, @FACTURAID, @PRODUCTOID, @ITEMCANT, @PRECIOCOMBO

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF(EXISTS(SELECT 1 FROM COMPOSICION WHERE comp_producto = @PRODUCTOID))
		BEGIN
		 SET @FECHA = (SELECT fact_fecha FROM FACTURA WHERE fact_numero = @FACTURAID AND fact_tipo = @TIPO AND fact_sucursal = @SUCURSAL)
		 SET @CLI = (SELECT clie_razon_social FROM FACTURA INNER JOIN CLIENTE ON clie_codigo = fact_cliente				
						WHERE fact_numero = @FACTURAID AND fact_tipo = @TIPO AND fact_sucursal = @SUCURSAL)
		 
			IF(@PRECIOCOMBO < (SELECT SUM(PROD_PRECIO * comp_cantidad)/2 FROM COMPOSICION INNER JOIN PRODUCTO ON prod_codigo = comp_componente WHERE comp_producto =  @PRODUCTOID ))

				DELETE FROM Item_Factura WHERE item_producto = @PRODUCTOID AND item_numero = @FACTURAID  AND item_tipo = @TIPO
					AND item_sucursal = @SUCURSAL
			ELSE
				IF((SELECT SUM(PROD_PRECIO * comp_cantidad) FROM COMPOSICION INNER JOIN PRODUCTO ON prod_codigo = comp_componente WHERE comp_producto =  @PRODUCTOID) > @PRECIOCOMBO)
					PRINT('FECHA: ' + @FECHA + 'DEL CLIENTE ' + @CLI + 'AL PRECIO: ' + @PRECIOCOMBO )
				END
			
		END

		FETCH NEXT FROM NUEVOS INTO @TIPO, @SUCURSAL, @FACTURAID, @PRODUCTOID, @ITEMCANT, @PRECIOCOMBO
	END
	CLOSE NUEVOS
	DEALLOCATE NUEVOS
END
