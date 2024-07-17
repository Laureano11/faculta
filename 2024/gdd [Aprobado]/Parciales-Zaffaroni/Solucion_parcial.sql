-- Trigger 
CREATE TRIGGER auditcs ON customer
AFTER DELETE, UPDATE
AS
BEGIN
    DECLARE 
        @customer_num INT,
        @apeynomNew VARCHAR(40), 
        @stateNew CHAR(2),
        @customer_num_refered_byNew INT,
        @apeynomOld VARCHAR(40), 
        @stateOld CHAR(2),
        @customer_num_refered_byOld INT;

    DECLARE auditcr CURSOR FOR
    SELECT 
        d.customer_num, 
        i.lname + '' + i.fname, 
        i.state,
        i.customer_num_referedby, 
        d.lname + '' + d.fname, 
        d.state,
        d.customer_num_referedby
    FROM 
        deleted d
    LEFT JOIN 
        inserted i ON i.customer_num = d.customer_num;

    OPEN auditcr;

    FETCH NEXT FROM auditcr INTO 
        @customer_num,
        @apeynomNew, 
        @stateNew, 
        @customer_num_refered_byNew,
        @apeynomOld, 
        @stateOld, 
        @customer_num_refered_byOld;

    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION;

            IF NOT EXISTS(SELECT 1 FROM inserted)
            BEGIN
                INSERT INTO customer_audit (
                    customer_num, 
                    update_Date, 
                    apeynom_OLD,
                    state_Old, 
                    customer_num_referedby_OLD, 
                    update_user
                )
                VALUES (
                    @customer_num, 
                    GETDATE(), 
                    @apeynomOld, 
                    @stateOld,
                    @customer_num_refered_byOld, 
                    SYSTEM_USER
                );
            END
            ELSE
            BEGIN
                IF NOT EXISTS(SELECT 1 FROM customer WHERE customer_num = @customer_num_refered_byNew)
                    THROW 50001, 'Referente inexistente', 1;

                IF NOT EXISTS (SELECT 1 FROM state WHERE state = @stateNEW)
                    THROW 50002, 'Estado inexistente', 1;

                INSERT INTO customer_audit (
                    customer_num, 
                    update_Date, 
                    apeynom_NEW,
                    state_NEW, 
                    customer_num_referedby_NEW, 
                    apeynom_OLD,
                    state_Old, 
                    customer_num_referedby_OLD,
                    update_user
                )
                VALUES (
                    @customer_num, 
                    GETDATE(),
                    @apeynomNew, 
                    @stateNew, 
                    @customer_num_refered_byNew,
                    @apeynomOld, 
                    @stateOld, 
                    @customer_num_refered_byOld,
                    SYSTEM_USER
                );
            END

            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
        END CATCH;

        FETCH NEXT FROM auditcr INTO 
            @customer_num,
            @apeynomNew, 
            @stateNew, 
            @customer_num_refered_byNew,
            @apeynomOld, 
            @stateOld, 
            @customer_num_refered_byOld;
    END

    CLOSE auditcr;
    DEALLOCATE auditcr;
END;




-- Procedure

CREATE TABLE cuentaCorriente (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    fechaMovimiento DATETIME,
    customer_num SMALLINT REFERENCES customer,
    order_num INT REFERENCES orders,
    importe DECIMAL(12,2)
);

CREATE PROCEDURE procedure_cuenta_corriente
AS
BEGIN
    INSERT INTO cuentaCorriente (fechaMovimiento, customer_num, order_num, importe)
    SELECT o.order_date, o.customer_num, o.order_num,
           SUM(quantity * unit_price)
    FROM orders o
    JOIN items i ON o.order_num = i.order_num
    GROUP BY o.order_num, o.order_date, o.customer_num

    UNION

    SELECT o.paid_date, o.customer_num, o.order_num,
           SUM(quantity * unit_price - 1)
    FROM orders o
    JOIN items i ON o.order_num = i.order_num
    WHERE o.paid_date IS NOT NULL
    GROUP BY o.order_num, o.paid_date, o.customer_num
END;


-- Query

SELECT 
    c.state, 
    c.customer_num, 
    c.fname, 
    c.lname,
    SUM(i.quantity * i.unit_price) / COUNT(DISTINCT o.order_num) AS promedioXOrden,
    SUM(i.quantity * i.unit_price) AS montoXCliente,
    (
        SELECT SUM(i2.quantity * i2.unit_price)
        FROM customer c2
        JOIN orders o2 ON c2.customer_num = o2.customer_num
        JOIN items i2 ON o2.order_num = i2.order_num
        WHERE state = c.state
    ) AS montoXEstado
FROM 
    customer c
JOIN 
    orders o ON c.customer_num = o.customer_num
JOIN 
    items i ON i.order_num = o.order_num
WHERE 
    c.state IN (
        SELECT TOP 3 c3.state
        FROM customer c3
        JOIN orders o3 ON c3.customer_num = o3.customer_num
        JOIN items i3 ON o3.order_num = i3.order_num
        GROUP BY c3.state
        ORDER BY SUM(i3.quantity * i3.unit_price) DESC
    )
GROUP BY 
    c.state, 
    c.customer_num, 
    c.fname, 
    c.lname;


-- Query complejo 2

SELECT  SUM(i.quantity * i.unit_price) MontoFabricante, m.manu_name,  FROM orders o
		JOIN items i ON i.order_num = o.order_num
		JOIN manufact m ON m.manu_code = i.manu_code

		JOIN (
		SELECT TOP 3 s.sname, sum(i.unit_price * i.quantity) totalProvincia FROM items i
		JOIN orders o ON (i.order_num = o.order_num)
		LEFT JOIN customer c ON (o.customer_num= c.customer_num)
		JOIN state s ON (c.state = s.state)
		GROUP by s.sname
		HAVING SUM(i.quantity * i.unit_price) > SUM(i.quantity * i.unit_price)*0.15
		ORDER BY sum(i.unit_price * i.quantity) DESC) topProvincias on s.state = c.state

		GROUP BY m.manu_name
		
		Order by s.sname




-- 

SELECT 
    s.sname, 
    lj.montoTotal, 
    m.manu_code, 
    m.manu_name, 
    SUM(i.quantity * i.unit_price) AS montoFabricante
FROM manufact m 
JOIN items i ON i.manu_code = m.manu_code
JOIN state s ON s.state = m.state
JOIN (
    SELECT TOP 3 
        m.state, 
        SUM(i.quantity * i.unit_price) AS montoTotal
    FROM items i 
    JOIN manufact m ON m.manu_code = i.manu_code
    GROUP BY m.state
    ORDER BY SUM(i.quantity * i.unit_price) DESC
) lj ON lj.state = s.state
GROUP BY 
    m.manu_code, 
    m.manu_name, 
    s.sname, 
    lj.montoTotal
HAVING 
    SUM(i.quantity * i.unit_price) > (0.15 * lj.montoTotal)
ORDER BY 
    lj.montoTotal DESC, 
    SUM(i.quantity * i.unit_price) DESC;





		