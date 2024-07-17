/*
Estadistica de ventas especiales.
La factura es especial si tiene mas de 1 producto con composicion vendido.
Year, cant_fact, total_facturado_especial, porc_especiales, max_factura, monto_total_vendido
porc_especiales, monto_total_vendido
Order: cant_fact DESC, monto_total_vendido DESC
*/
SELECT YEAR(fact_fecha) AS yr,
	   COUNT(fact_tipo+fact_sucursal+fact_numero) as CANT_FACT_ESPECIALES,
	   SUM(fact_total) AS TOTAL_FACTURADO_ESP,
	   (
			SELECT SUM(G.fact_total) 
			FROM Factura G
			WHERE YEAR(G.fact_fecha)=YEAR(A.fact_fecha)
	   ) AS TOTAL_FACTURADO_YEAR,
	   (
			SUM(fact_total) * 100
			/
			(
				SELECT SUM(G.fact_total) 
				FROM Factura G
				WHERE YEAR(G.fact_fecha)=YEAR(A.fact_fecha)
			)
	   ) AS PORC_ESPECIALES,
	   MAX(fact_total) AS MAX_MONTO_FACTURA
FROM Factura A
WHERE fact_tipo+fact_sucursal+fact_numero IN (
		SELECT fact_tipo+fact_sucursal+fact_numero
		FROM Factura G
		JOIN Item_Factura ON G.fact_tipo+G.fact_sucursal+G.fact_numero=item_tipo+item_sucursal+item_numero
		JOIN Producto ON item_producto=prod_codigo
		JOIN Composicion ON comp_producto=item_producto
		GROUP BY fact_tipo+fact_sucursal+fact_numero
		HAVING COUNT(DISTINCT(comp_producto)) > 1
)
GROUP BY YEAR(fact_fecha)
ORDER BY 2 DESC, 4 DESC