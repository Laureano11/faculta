-- Ejercicio 1

select c.customer_num , company, order_num from orders o join customer c ON o.customer_num=c.customer_num
where c.customer_num between 106 and 120
order by customer_num
