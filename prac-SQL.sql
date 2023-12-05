SELECT 
	last_name,
    first_name, 
    points,
    (points + 10) * 100 as "discount factor"
FROM customers;

select distinct state 
from customers;

select name, unit_price, unit_price * 1.1 as "new price"
from products;

select *
from customers
where birth_date > "1990-01-01"; 

-- >
-- >= 
-- <
-- <=
-- =
-- != , (same as)<>

select * 
from orders 
where order_date >= "2019-01-01";
----------------------------------------------------------
-- the AND, OR and NOT operators: 

select *
from customers
where birth_date > "1990-01-01" or points > 1000 and state = "va";

select * 
from order_items 
where order_id = 6 and (quantity * unit_price > 30);
 ---------------------------------------------------------
select *
from customers
where state = 'va' or state = 'ga' or state = 'fl';

select *
from customers
where state not in ('va', 'ga', 'fl');

select * 
from products
where quantity_in_stock in (49,38,72);

-----------------------------------------------------------------------
-- between operator
 
select *
from customers
where birth_date between '1990/01/01' and '2000/01/01';
 
 --------------------------------------------------------------
-- the like operator
 
select * 
from customers
where last_name like "b__y";

 -- % any number of charaters 
-- _ single character

 select * 
 from customers
 where address like "%trail%" or address like "%avenue%";
 
 select*
 from customers
 where phone like "%9"; 
 
 -- ^ beginning 
 -- $ end 
 -- | logical or 
 -- [abcd]
 -- [a-f]
 
 select *
 from customers
 where first_name regexp "elka|ambur";
 
 select *
 from customers
 where last_name regexp "ey$|on$";
 
 select *
 from customers
 where last_name regexp "se|^my";
 
select *
from customers
where last_name regexp "b[ru]";
 --------------------------------------------
 -- the is null operator
 
select * 
from customers
where phone is not null;

select * 
from orders
where shipped_date is null;

--------------------------------------
-- order by operator

select * 
from customers
order by first_name desc;

select first_name, last_name, 10 as points 
from customers
order by points, first_name;

select *, quantity * unit_price as total_price
from order_items
where order_id = 2
order by total_price desc;
------------------------------------------------------------
select * 
from customers
limit 6, 3;

select *
from customers
order by points desc
limit 3;

-----------------------------------------------
-- inner join 

select * 
from orders
inner join customers on orders.customer_id = customers.customer_id;

select ORDER_ID,O.product_id, name, quantity, O.unit_price
from order_items O
join products P
		on O.product_id = P.product_id;
        
---------------------------------------------------------
use sql_store;

select * 
from order_items oi
join sql_inventory.products p 
	on oi.product_id = p.product_id;
    
use sql_hr;

select e.employee_id, e.first_name, m.first_name as manager 
from employees e
join employees m on e.reports_to = m.employee_id;
use sql_store;

select 
	o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name as status
from orders o 
join customers c 
	on o.customer_id = c.customer_id
join order_statuses os
	on o.status = os.order_status_id
;

use sql_invoicing;

select 
    p.invoice_id,
    p.date,
    p.amount,
	c.name,
    pm.name
from payments p
join clients c 
	on p.client_id = c.client_id
join payment_methods pm
	on p.payment_method = pm.payment_method_id
;

use sql_store;

select *
from order_items oi
join order_item_notes oin
	on oi.order_Id = oin.order_Id
    and oi.product_id = oin.product_id
;

------------------------------------------------------------------
-- outer joins

select 
	c.customer_id,
    c.first_name,
    o.order_id
from customers c
left join orders o 
	on o.customer_id = c.customer_id
order by c.customer_id
;

select 
	p.product_id,
    p.name,
    oi.quantity
from products p
left join order_items oi
	on p.product_id = oi.product_id
order by p.product_id
;

select 
	o.order_date,
    o.order_id,
    c.first_name as customer,
    sh.name as shipper,
    os.name as status
from orders o
join customers c
	on o.customer_id = c.customer_id
join order_statuses os
	on o.status = os.order_status_id
left join shippers sh
	on o.shipper_id = sh.shipper_id
;

use sql_hr;

select 
	e.employee_id,
    e.first_name,
    m.first_name as manager
from employees e
left join employees m
	on e.reports_to = m.employee_id;

use sql_store;

select 
	o.order_id,
    c.first_name,
    sh.name as shipper
from orders o 
join customers c 
	using (customer_id)
left join shippers sh
	using (shipper_id)
;

-- using is used onley when the name of the columns is the exactly the same. 
---------------------------------------------------------------------------------------
select * 
from order_items oi
join order_item_notes oin
	using (order_id, product_id);
    
use sql_invoicing;

select 
	p.date,
    c.name as client,
    p.amount,
    pm.name as name
from payments p 
join payment_methods pm
	on p.payment_method = pm.payment_method_id
join clients c 
	using(client_id)
;

-- cross joins
use sql_store;

select 
	c.first_name as customer,
    p.name as product
from customers c
cross join products p 
order by c.first_name
;

select *
from products p
cross join shippers sh 
;

select 
	order_id,
    order_date,
    "active" as status
from orders
where order_date >= '2019/01/01'
union
select 
	order_id,
    order_date,
    "archived" as status
from orders
where order_date < '2019/01/01'
;

select 
	customer_id,
    first_name,
    points,
    "Bronz" as type
from customers
where points < 2000 
union
select 
	customer_id,
    first_name,
    points,
    "Silver" as type
from customers
where points between 2000 and 3000 
union
select 
	customer_id,
    first_name,
    points,
    "Gold" as type
from customers
where points > 3000
order by first_name
; 

-------------------------------------------------
insert into customers (
	last_name,
    first_name,
    birth_date,
    address,
    city,
    state
)
values (
    "chris",
    "cour",
	"1999-01-01",
    "address",
    "city",
	"ca"
    )
;
















 

 
 






      
