--SELECT P.prod_codigo, P.prod_precio, comp_componente, comp_cantidad, Q.prod_precio as PRECIO_COMP,
--	   (comp_cantidad * Q.prod_precio) AS PRECIO_X_COMP

--FROM PRODUCTO P
--JOIN Composicion ON comp_producto=prod_codigo
--JOIN Producto Q ON Q.prod_codigo=comp_componente

-- EXEC NUEVO_PRECIO
---- SELECT dbo.precio_compuesto('00001718')

--SELECT P.prod_codigo, P.prod_precio, comp_componente, comp_cantidad, Q.prod_precio as PRECIO_COMP,
--	   (comp_cantidad * Q.prod_precio) AS PRECIO_X_COMP

--FROM PRODUCTO P
--JOIN Composicion ON comp_producto=prod_codigo
--JOIN Producto Q ON Q.prod_codigo=comp_componente

-- SELECT dbo.precio_compuesto('00006402') -- Este es recursivo! 86.02= 68.82+ el de de 6411 que es 5.86
--00006411	5.86	00005703	2.00	1.34	2.6800
--00006411	5.86	00001516	2.00	2.32	4.6400

SELECT P.prod_codigo, P.prod_precio, comp_componente, comp_cantidad, Q.prod_precio as PRECIO_COMP,
	   (comp_cantidad * Q.prod_precio) AS PRECIO_X_COMP
FROM PRODUCTO P
JOIN Composicion ON comp_producto=prod_codigo
JOIN Producto Q ON Q.prod_codigo=comp_componente

SELECT dbo.precio_compuesto('00006402')
