/*1. Escribir una sentencia SELECT que devuelva el número de orden, fecha de orden y el nombre del
día de la semana de la orden de todas las órdenes que no han sido pagadas.
Si el cliente pertenece al estado de California el día de la semana debe devolverse en inglés, caso
contrario en español. Cree una función para resolver este tema.
Nota: SET @DIA = datepart(weekday,@fecha)
Devuelve en la variable @DIA el nro. de día de la semana , comenzando con 1 Domingo hasta 7
Sábado.  */

CREATE FUNCTION dbo.NombreDiaSemana (@fecha DATE, @estado NVARCHAR(50))
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @DIA INT;
    DECLARE @NombreDia NVARCHAR(20);
    
    -- Obtener el número del día de la semana
    SET @DIA = DATEPART(WEEKDAY, @fecha)
    
    IF @estado = 'California'
    BEGIN
        -- Días de la semana en inglés
        SET @NombreDia = CASE @DIA
                            WHEN 1 THEN 'Sunday'
                            WHEN 2 THEN 'Monday'
                            WHEN 3 THEN 'Tuesday'
                            WHEN 4 THEN 'Wednesday'
                            WHEN 5 THEN 'Thursday'
                            WHEN 6 THEN 'Friday'
                            WHEN 7 THEN 'Saturday'
                         END;
    END
    ELSE
    BEGIN
        -- Días de la semana en español
        SET @NombreDia = CASE @DIA
                            WHEN 1 THEN 'Domingo'
                            WHEN 2 THEN 'Lunes'
                            WHEN 3 THEN 'Martes'
                            WHEN 4 THEN 'Miércoles'
                            WHEN 5 THEN 'Jueves'
                            WHEN 6 THEN 'Viernes'
                            WHEN 7 THEN 'Sábado'
                         END;
    END
    RETURN @NombreDia;
END;


alter PROCEDURE suma
@var1 INT,
@var2 INT,
@var3 INT OUT
AS
SET @var3 = @var1+ @var2;
return @var3;




Declare @resultado int;
set @resultado=10;
execute suma 15, 13, @resultado OUT
select @resultado

CREATE FUNCTION dbo.calcularTotal (@var1 INT, @var2 dec(12,2))
RETURNS INT
AS
BEGIN
	DECLARE @var3 int;
	SET @var3 = @var1* @var2;
	RETURN @var3
END


select stock_num, manu_code, quantity, unit_price, (unit_price * quantity) total
FROM items
WHERE dbo.calcularTotal (quantity,unit_price) > 500
order by total


select * from sys.objects
where type = 'U'
order by create_date DESC




Create TABLE CustomerStatistics (
	customer_num INT Primary Key,
	ordersQty INT,
	maxdate DATE,
	uniqueProducts INT )

drop Table CustomerStatistics


create Procedure actualizarEstadisticas_SP @customerSince INT, @customerUntil INT AS
BEGIN
	DECLARE customerCursor CURSOR FOR 
		SELECT customer_num from customer 
		WHERE customer_num between @customerSince and @customerUntil
	
	DECLARE @customer_num INT, @ordersqty INT, @maxdate DATE, @uniqueProducts INT; 
	-- Variables auxiliares para hacer calculos

	-- Este cursor estaria apuntado al select que hicimos mas arriba
	-- Es decir solo recorrera los CUstomer_num de aquellos que esnte entre el SINCE y el UNTIL

	OPEN customerCursor
	FETCH NEXT FROM customerCursor INTO @customer_num 
	WHILE @@FETCH_STATUS = 0
	BEGIN

	-- ACCION 1
		SELECT @ordersqty=count(*) , @maxdate=(max(order_date))
		FROM orders
		WHERE customer_num = @customer_num
	-- ACCION 2 
		SELECT @uniqueProducts = count(distinct stock_num)
		FROM items I join orders o on o.order_num = i.order_num
		where o.customer_num= @customer_num

		IF NOT EXISTS ( SELECT customer_num FROM CustomerStatistics
						where customer_num = @customer_num)
		insert into CustomerStatistics 
		VALUES (@customer_num,@ordersqty,@maxdate,@uniqueProducts)

		ELSE 
		UPDATE CustomerStatistics
		SET ordersqty = @ordersqty, maxdate=@maxdate, uniqueProducts=@uniqueProducts
		WHERE customer_num = @customer_num;
	FETCH NEXT FROM CustomerCursor Into @customer_num
	END
	Close CustomerCursor;
	DEALLOCATE CustomerCursor;
END; 








/* CREATE TABLE clientesCalifornia (
	customer_num smallint NOT NULL,
 fname   varchar (15),
 lname   varchar (15),
 company   varchar (20),
 address1 varchar (20),
 address2 varchar (20),
 city   varchar (15) ,
 state   char (2) ,
 zipcode   char (5),
 phone   varchar (18))

 CREATE TABLE clientesNoCaAlta(
	customer_num smallint NOT NULL,
 fname   varchar (15),
 lname   varchar (15),
 company   varchar (20),
 address1 varchar (20),
 address2 varchar (20),
 city   varchar (15) ,
 state   char (2) ,
 zipcode   char (5),
 phone   varchar (18)) 

  CREATE TABLE clientesNoCaBaja(
	customer_num smallint NOT NULL,
 fname   varchar (15),
 lname   varchar (15),
 company   varchar (20),
 address1 varchar (20),
 address2 varchar (20),
 city   varchar (15) ,
 state   char (2) ,
 zipcode   char (5),
 phone   varchar (18)) 
*/

	/* Crear un procedimiento ‘migraClientes’ que reciba dos parámetros
customer_numDES y customer_numHAS y que dependiendo el tipo de cliente y la
cantidad de órdenes los inserte en las tablas clientesCalifornia, clientesNoCaBaja,
clienteNoCAAlta.
	• El procedimiento deberá migrar de la tabla customer todos los
clientes de California a la tabla clientesCalifornia, los clientes que no
son de California pero tienen más de 999u$ en OC en
clientesNoCaAlta y los clientes que tiene menos de 1000u$ en OC en
la tablas clientesNoCaBaja.
	• Se deberá actualizar un campo status en la tabla customer con valor
‘P’ Procesado, para todos aquellos clientes migrados.
	• El procedimiento deberá contemplar toda la migración como un lote,
en el caso que ocurra un error, se deberá informar el error ocurrido y
abortar y deshacer la operación. 
*/





Create PROCEDURE migraClientes_SP (@customer_numDes INT, @customer_numHAS INT)
AS
BEGIN
	DECLARE customer_cursor CURSOR FOR
	SELECT customer_num from customer
	WHERE customer_num between @customer_numDes and @customer_numHAS

	DECLARE 
 @fname   varchar (15),
 @lname   varchar (15),
 @company   varchar (20),
 @address1 varchar (20),
 @address2 varchar (20),
 @city   varchar (15) ,
 @state   char (2) ,
 @zipcode   char (5),
 @phone   varchar (18),
 @total INT,
 @customernum INT
	
		OPEN customerCursor
	FETCH NEXT FROM customerCursor INTO @customernum 
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
	--ACCION 1
	SELECT  @total= (i.quantity * i.unit_price) from orders o
		JOIN items i ON i.order_num = o.order_num	
	
	
	--ACCION 2
	
	IF (SELECT state from customer
		where customer_num = @customernum) = 'CA'
		insert INTO clientesCalifornia 
		SELECT * from customer
		where customer_num = @customernum;


	ELSE IF @total > 999
	insert INTO clientesNoCaAlta 
	SELECT * from customer
	  where customer_num = @customernum
	  UPDATE customer set STATUS = 'p'
	  where customer_num = @customernum;

	IF @total < 1000
	insert INTO clientesNoCaBaja 
	SELECT * from customer
	  where customer_num = @customernum
	FETCH NEXT FROM CustomerCursor
 INTO @customernum
 end;
Close customerCursor
deallocate customerCursor
end;




-- EJericio 3
drop table listaPrecioMenor
create table listaPrecioMayor(
stock_num INT Primary KEY,
manu_code VARCHAR(3),
unit_price INT,
unit_code INT
)
create table listaPrecioMenor(
stock_num INT Primary KEY,
manu_code VARCHAR(3),
unit_price INT,
unit_code INT
)


ALTER procedure actualizar_precios_sp (@manu_codeDES VARCHAR(3), @manu_codeHAS VARCHAR(3), @porcActualizacion dec(5,3) )
AS
BEGIN
	DECLARE manu_CodeCursor CURSOR FOR
	SELECT stock_num, manu_code, unit_price, unit_code, status FROM products
	where manu_code between @manu_codeDES and @manu_codeHAS
	order by manu_code

-- Se declaran las variables auxiliares aca
	DECLARE 
	@manu_code VARCHAR(3),
	@stock_num int,
	@unit_price DEC(5,3),
	@unit_code INT
	

	open manu_CodeCursor 
	FETCH NEXT FROM manu_CodeCursor 
	INTO @stock_num, @manu_code, @unit_price, @unit_code 
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	-- Aca comienzan las condiciones y acciones
	IF (SELECT sum(i.quantity) from orders o
		JOIN items i ON o.order_num = i.order_num
		where i.stock_num = @stock_num) >= 500
		BEGIN
	INSERT INTO listaPrecioMayor
	values (@manu_code, @stock_num, @unit_price * @porcActualizacion * 0.80 , @unit_code)
		END

	ELSE IF (SELECT sum(i.quantity) from orders o
		JOIN items i ON o.order_num = i.order_num
		where i.stock_num = @stock_num) < 500
		BEGIN
		INSERT INTO listaPrecioMenor
		values (@manu_code, @stock_num, @unit_price * @porcActualizacion  , @unit_code)
		END

		UPDATE products set status = 'A'
		where stock_num = @stock_num and manu_code = @manu_code
	
	FETCH NEXT FROM manu_CodeCursor 
		INTO @stock_num, @manu_code, @unit_price, @unit_code
	END
	close manu_CodeCursor
	deallocate manu_CodeCursor

END

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ALTER PROCEDURE actualizar_precios_sp (@manu_codeDES VARCHAR(3), @manu_codeHAS VARCHAR(3), @porcActualizacion DEC(5,3) )
AS
BEGIN
	DECLARE manu_CodeCursor CURSOR FOR
	SELECT stock_num, manu_code, unit_price, unit_code FROM products
	WHERE manu_code BETWEEN @manu_codeDES AND @manu_codeHAS
	ORDER BY manu_code

	-- Se declaran las variables auxiliares acá
	DECLARE 
		@manu_code VARCHAR(3),
		@stock_num INT,
		@unit_price DEC(5,3),
		@unit_code INT

	OPEN manu_CodeCursor 
	FETCH NEXT FROM manu_CodeCursor 
	INTO @stock_num, @manu_code, @unit_price, @unit_code
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Acá comienzan las condiciones y acciones
		IF (SELECT SUM(i.quantity) FROM orders o
			JOIN items i ON o.order_num = i.order_num
			WHERE i.stock_num = @stock_num AND i.manu_code = @manu_code) >= 500
		BEGIN
			INSERT INTO listaPrecioMayor
			VALUES (@manu_code, @stock_num, @unit_price * @porcActualizacion * 0.80, @unit_code)
		END
		ELSE 
		BEGIN
			INSERT INTO listaPrecioMenor
			VALUES (@manu_code, @stock_num, @unit_price * @porcActualizacion, @unit_code)
		END

		UPDATE products 
		SET status = 'A'
		WHERE stock_num = @stock_num AND manu_code = @manu_code
	
		FETCH NEXT FROM manu_CodeCursor 
		INTO @stock_num, @manu_code, @unit_price, @unit_code
	END

	CLOSE manu_CodeCursor
	DEALLOCATE manu_CodeCursor
END

select * from products




