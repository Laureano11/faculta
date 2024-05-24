-- Ejercicio 1

SELECT * Into #clientes from customer


-- Ejercicio 2

insert into #clientes (customer_num,fname,lname,company,city,state) VALUES (144,'Agustin','Creevy','Jaguares SA','Los Angeles','CA')

-- Ejercicio 3
SELECT * Into #clientesCalifornia from customer
where state = 'CA'

-- Ejercicio 4 
SELECT * into #clientes2 from customer
where customer_num=103

UPDATE #clientes2
set customer_num=144 
where customer_num = 103;


select * into #clientes from customer
drop table #clientes

delete #clientes
where zipcode > 94000 and zipcode < 94050 and city like 'M%';


-- Ejercicio 6
UPDATE #clientes
set state = 'AK' , address1='Barrio las heras'
where state = 'CO'


--Ejercicio 7
select * from #clientes
UPDATE #clientes
set phone = '1'+phone

