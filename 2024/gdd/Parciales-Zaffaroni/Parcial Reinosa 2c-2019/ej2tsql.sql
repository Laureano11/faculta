/*
Recalcular precios de prods con composicion
Nuevo precio: suma de precio compontentes * 0,8 
*/
IF OBJECT_ID('precio_compuesto') IS NOT NULL
	DROP FUNCTION precio_compuesto
GO 

CREATE FUNCTION precio_compuesto(@producto CHAR(8))
RETURNS DECIMAL(12, 2)
AS
BEGIN
	/*
		If a product has no componentes, its price is its own price.
		If it has N componentes, its price is the sum of its components
	*/
	DECLARE @precio DECIMAL(12, 2)=0.0
	IF NOT EXISTS (SELECT * FROM Composicion WHERE comp_producto=@producto)
		BEGIN
			SET @precio = (SELECT prod_precio FROM Producto WHERE prod_codigo=@producto)
			RETURN @precio
		END

	-- Si estamos acá al menos hay un componente que compone a mi producto
	DECLARE @componente CHAR(8)
	DECLARE @componente_cant DECIMAL(12, 2)

	DECLARE C2 CURSOR FOR 
	SELECT comp_componente, comp_cantidad FROM Composicion WHERE comp_producto=@producto
	OPEN C2

	FETCH NEXT FROM C2 INTO @componente, @componente_cant 
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @precio = @precio + dbo.precio_compuesto(@componente) * @componente_cant * 0.8  -- El 80% del costo del componente
			FETCH NEXT FROM C2 INTO @componente, @componente_cant
		END

	CLOSE C2
	DEALLOCATE C2
	RETURN @precio
END
GO

IF OBJECT_ID('NUEVO_PRECIO') IS NOT NULL
	DROP PROCEDURE NUEVO_PRECIO
GO


CREATE PROCEDURE NUEVO_PRECIO
AS
BEGIN
	DECLARE @prod_codigo CHAR(8)

	-- Obtengo productos con composicion
	DECLARE C1 CURSOR FOR 
	SELECT prod_codigo
	FROM Producto
	JOIN Composicion ON comp_producto=prod_codigo

	OPEN C1
	FETCH NEXT FROM C1 INTO @prod_codigo
	WHILE @@FETCH_STATUS = 0
		BEGIN
			UPDATE Producto
			SET prod_precio = dbo.precio_compuesto(@prod_codigo)
			WHERE prod_codigo=@prod_codigo
			FETCH NEXT FROM C1 INTO @prod_codigo
		END

	CLOSE C1
	DEALLOCATE C1

END