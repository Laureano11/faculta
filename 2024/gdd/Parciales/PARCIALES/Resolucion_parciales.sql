
SELECT 
(c.fname +' '+c.lname) cliente,

COALESCE(SUM(i.quantity * i.unit_price),0) as TOTALCOMPRA,

COALESCE((c2.fname + ' ' + c2.lname), 'no tiene referido') AS Referido,

COALESCE(SUM(i2.quantity * i2.unit_price),0) as TOTALCOMPRA,

SUM(i2.quantity * i2.unit_price)*0.05 as  comisiones

FROM customer c
LEFT JOIN orders o ON o.customer_num = c.customer_num
LEFT JOIN items i ON i.order_num = o.order_num
LEFT JOIN customer c2 ON c.customer_num_referedBy = c2.customer_num 
LEFT JOIN orders o2 ON o2.customer_num = c2.customer_num_referedBy 
LEFT JOIN items i2 ON i2.order_num  = o2.order_num and i2.stock_num IN (1,4,5,6,9)

GROUP BY c.fname, c.lname , c2.fname, c2.lname

-- STORED PROCEDURES

CREATE PROCEDURE insertar_productos 
(@stock_num INT,
@manu_code VARCHAR(3),
@unit_price INT,
@unit_code INT,
@description VARCHAR(15))
AS
BEGIN
IF EXISTS ( SELECT manu_code from products 
			WHERE manu_code = @manu_code)	
	
		UPDATE products
		SET unit_price = @unit_price,
			unit_code = @unit_code
		WHERE manu_code = @manu_code
ELSE IF NOT EXISTS (SELECT manu_code from manufact
			   WHERE manu_code = @manu_code)
			   THROW 50000, 'No existe manu CODE', 1
	ELSE
	INSERT INTO products
	values (@stock_num, @manu_code, @unit_price, @unit_code)

	IF NOT EXISTS (SELECT stock_num from product_types
			   WHERE stock_num= @stock_num)
			   THROW 50000, 'No existe manu STOCK_NUM', 1
	ELSE	
		UPDATE product_types
		SET description = @description
		WHERE stock_num = @stock_num
	
	END;



-- TRIGGERs

CREATE VIEW v_Productos
(codCliente, nombre, apellido, codProvincia, fechaLlamado, usuarioId,
codTipoLlamada, descrLlamada, descrTipoLlamada)
		
		SELECT c.customer_num, fname, lname, state, call_dtime,
				user_id, cc.call_code, call_descr, code_descr
		FROM customer c 
		JOIN cust_calls cc ON (c.customer_num=cc.customer_num)
		JOIN call_type ct ON (cc.call_code=ct.call_code)
		
		WHERE ct.call_code IN ('B','D','I','L','O')

		AND state IN (SELECT code FROM state)


WITH CHECK OPTION



 -- Trigger 

CREATE TRIGGER dbo.customerTrigger
	ON dbo.v_products

INSTEAD OF INSERT AS
BEGIN
	declare @codCliente SMALLINT
	declare @nombre VARCHAR(50)
	declare @apellido VARCHAR(50)
	declare @CODPROVINCIA VARCHAR(2)
	declare @FechaLlamado DATETIME
	declare @usuarioID char(32)
	declare @codTipoLlamada char(1)
	declare @descLlamada varchar(40)
	declare @descTipoLlamada varchar(30)

	DECLARE view_cursor CURSOR FOR select * from inserted;
	open view_cursor 

	FETCH NEXT FROM view_cursor
	INTO @codCliente,@nombre,@apellido,@CODPROVINCIA, @FechaLlamado, @usuarioId, @codTipoLlamada, @descLlamada, @descTipoLlamada

	WHILE @@FETCH_STATUS = 0
	BEGIN	BEGIN TRY	BEGIN TRANSACTION		IF NOT EXISTS (select customer_num from customer
						where customer_num = @codCliente)
		INSERT INTO customer
		values (@codCliente,@nombre,@apellido,@CODPROVINCIA)

		if not exists (select 1 from call_type ct
						where ct.call_code = @codTipoLlamada)
		insert into call_type (call_code,code_descr)
		values (@codTipoLlamada, @descTipoLlamada)	END TRY


	begin catch
		rollback tran;
			print 'Nro. Error:' + cast(ERROR_NUMBER() as varchar);
			print 'mensaje:' + ERROR_MESSAGE();
	end catch

FETCH NEXT FROM view_cursor
INTO @codCliente, @nombre, @apellido, @codProvincia, @fechaLlamado,
@usuarioId, @codTipoLlamada, @descrLlamada, @descrTipoLlamada;END
close VIEW_CURSOR
deallocate view_cursor
END





---- PARCIAL 2

Create view mejores_provincias
AS

SELECT  TOP 3 s.sname nombre_provincia, 
			COUNT(c.customer_num) cantidad_Clientes, 
			SUM(i.quantity * i.unit_price) totalComprado,
			(fname + lname) MejorCliente
			FROM orders o
	JOIN customer c ON  SL
						
	JOIN items i ON i.order_num = o.order_num
	JOIN state s ON c.state = s.state


	GROUP by s.sname, fname,lname
	ORDER BY totalComprado DESC




CREATE VIEW vistaRecup AS

	SELECT TOP 3 s.sname,
		COUNT(DISTINCT c.customer_num) cantClientes,
		SUM(i.quantity * i.unit_price) totalComprado,
		(SELECT TOP 1 c1.fname + ', ' + c1.lname apeYnom
			FROM customer c1 JOIN orders o1 ON (c1.customer_num = o1.customer_num)
						     JOIN items i1 ON (o1.order_num = i1.order_num)
		WHERE c1.state = s.state
		GROUP BY c1.fname, c1.lname, c1.state
		ORDER BY SUM(i1.quantity * i1.unit_price) DESC)

FROM state s JOIN customer c ON (s.state = c.state)
		JOIN orders o ON (c.customer_num = o.customer_num)
		JOIN items i ON (o.order_num = i.order_num)
GROUP BY s.sname,
		 s.state
ORDER BY 3 DESC


-- Trigger 

Create TABLE TotalesClienteProducto 
(customer_num INT NOT NULL ,
manu_code char(3) NOT NULL,
stock_num SMALLINT,
countItems SMALLINT,
sumQuantity SMALLINT,
sumTotalPrice SMALLINT,
PRIMARY KEY (customer_num, manu_code,stock_num))

CREATE TRIGGER totales_trigger
	ON dbo.TotalesClienteProducto
	INSTEAD OF INSERT AS
	BEGIN
	DECLARE @customer_num INT
	DECLARE @manu_code CHAR(3)
	DECLARE @stock_num SMALLINT
	DECLARE @countItems SMALLINT
	DECLARE @sumQuantity SMALLINT
	DECLARE @sumTotalPrice SMALLINT

	DECLARE cliente_cursor CURSOR FOR select * from inserted;
	open cliente_cursor  

	FETCH NEXT FROM cliente_cursor 
	INTO @customer_num, @manu_code, @stock_num, @countItems, @sumQuantity, @sumTotalPrice
	WHILE @@FETCH_STATUS = 0
	 IF NOT EXISTS (SELECT customer_num from TotalesClienteProducto
					WHERE customer_num = @customer_num)
		INSERT INTO TotalesCLienteProducto
		VALUES(@customer_num, @manu_code, @stock_num, @countItems, @sumQuantity, @sumTotalPrice)
	ELSE
		UPDATE TotalesClienteProducto
		SET countItems= @countItems, sumQuantity= @sumTotalPrice, sumTotalPrice=@sumTotalPrice

	FETCH NEXT FROM cliente_cursor 
	INTO @customer_num, @manu_code, @stock_num, @countItems, @sumQuantity, @sumTotalPrice

	END




	-- Parcial 2k20 Zaffaroni

	-- Trigers

Create TABLE tabla_auditoria(
customer_num smallint NOT NULL ,
update_date datetime NOT NULL ,
ApeyNom_NEW varchar(40),
State_NEW char(2),
customer_num_referedBy_NEW smallint,
ApeyNom_OLD varchar(40),
State_OLD char(2),
customer_num_referedBy_OLD smallint,
update_user varchar(30) not null,
PRIMARY KEY ( customer_num, update_date))

/* */



create trigger audit_cambios ON customer
AFTER delete, update AS
Begin
DECLARE @customer_num INT
DECLARE @update_date DATETIME
DECLARE @ApeyNom_NEW VARCHAR(40)
DECLARE @State_new CHAR(2)
DECLARE @customer_num_referedBy_NEW INT
DECLARE @ApeyNom_OLD VARCHAR(40)
DECLARE @State_OLD CHAR(2)
DECLARE @customer_num_referedBy_OLD INT
DECLARE @update_user varchar(30)


/*
Ante deletes y updates de los campos :
- lname
- fname
- state 
- customer_num_refered

De la tabla CUSTOMER, auditar los cambios colocando en los campos NEW los valores nuevos 
guardar en los campos OLD los valores que tenían antes de su borrado/modificación.

* En los campos ApeyNom se deben guardar los nombres y apellidos concatenados respectivos.
* En el campo update_date guardar la fecha y hora actual 
* En el  update_user el usuario que realiza el update.
Verificar en las modificaciones la validez de las claves foráneas ingresadas y en caso
de error informarlo y deshacer la operación.


Notas: Asumir que ya existe la tabla de auditoría. Las modificaciones pueden ser
masivas y en caso de error sólo se debe deshacer la operación actual.
*/

DECLARE cliente_cursor CURSOR FOR
	SELECT d.customer_num, i.lname + '' + i.fname, i.state,
	i.customer_num_referedby, d.lname + '' + d.fname, d.state,
	d.customer_num_referedby
	FROM deleted d
	FULL JOIN inserted i ON i.customer_num = d.customer_num;
	open cliente_cursor  
	FETCH NEXT FROM cliente_cursor 
	INTO @customer_num, @ApeyNom_NEW, @State_new, @customer_num_referedBy_NEW

	WHILE @@FETCH_STATUS = 0
		BEGIN TRY
		BEGIN TRANSACTION 
		SET @update_date = GETDATE();
			IF NOT EXISTS (select 1 from deleted)
			BREAK;
			ELSE (select customer_num from DELETED
				 where customer_num = @customer_num)
				 BEGIN
				 
				UPDATE tabla_auditoria SET update_date= @diaHoy
										 



