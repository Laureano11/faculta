use GD2015C1
/*Armar una consulta que muestre para todos los productos:

Producto

Detalle del producto

Detalle composición (si no es compuesto un string “SIN COMPOSICION”,, si es compuesto un string “CON COMPOSICION”

Cantidad de Componentes (si no es compuesto, tiene que mostrar 0)

Cantidad de veces que fue comprado por distintos clientes

Nota: No se permiten sub select en el FROM.*/

select p.prod_codigo, 
       p.prod_detalle,
	   (SELECT CASE 
		WHEN ((SELECT comp_producto FROM COMPOSICION inner join Producto p1 on comp_producto = p1.prod_codigo where comp_producto = p.prod_codigo) <> NULL) THEN 'CON COMPOSICIÓN'
		ELSE 'SIN COMPOSICIÓN'
		END) AS DetalleComposicion,
		ISNULL((select count(comp_componente) from Composicion where comp_producto = p.prod_codigo), 0) AS CantidadComponentes,
		COUNT(DISTINCT fact_cliente) AS CantidadCompradores
	   from Producto p
	   INNER JOIN Item_Factura ON item_producto = p.prod_codigo 
	   INNER JOIN FACTURA ON fact_numero + fact_sucursal + fact_tipo = item_numero + item_sucursal + item_tipo
	   group by p.prod_codigo, p.prod_detalle