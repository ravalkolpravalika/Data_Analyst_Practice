"Easy-Level"
"1. Show the category_name and description from the categories table sorted by category_name."
select category_name,description
from categories
order by category_name;

"2. Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'"
select contact_name,address,city
from customers
where country not in ('Germany', 'Mexico', 'Spain');

"3. Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26"
select order_date,shipped_date,customer_id,freight
from orders
where order_date='2018-02-26'

"4. Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date"
select employee_id,order_id,customer_id,required_date,shipped_date
from orders
where shipped_date>(required_date);

"5. Show all the even numbered Order_id from the orders table"
select order_id
from orders
where order_id%2=0;

"6. Show the city, company_name, contact_name of all customers from cities which contains the letter 'L' in the city name, sorted by contact_name"
select city,company_name,contact_name
from customers
where city like '%L%'
order by contact_name;

"7.Show the company_name, contact_name, fax number of all customers that has a fax number. (not null) "
select company_name,contact_name,fax
from customers
where fax is not null;

"8. Show the first_name, last_name. hire_date of the most recently hired employee."
select first_name,last_name,hire_date
from employees
where hire_date=(select max(hire_date) from employees);

"9.Show the average unit price rounded to 2 decimal places, the total units in stock, total discontinued products from the products table. "
select round(avg(unit_price),2),sum(units_in_stock),sum(discontinued)
from products;


"Medium-Level"
"10. Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table"
select products.product_name,suppliers.company_name,categories.category_name
from products
join suppliers
on products.supplier_id=suppliers.supplier_id
join categories
on products.category_id=categories.category_id;

"11. Show the category_name and the average product unit price for each category rounded to 2 decimal places."
select categories.category_name,round(avg(products.unit_price),2) as average_unit_price
from categories
join products
on categories.category_id=products.category_id
group by category_name;

"12. Show the city, company_name, contact_name from the customers and suppliers table merged together.
Create a column which contains 'customers' or 'suppliers' depending on the table it came from."
select city,company_name,contact_name,'customers' as relationship
from customers 
union
select city,company_name,contact_name,'suppliers' as relationship
from suppliers;

"13. Show the total amount of orders for each year/month."
select year(order_date) as order_year,
month(order_date) as order_month,
count(order_date) as no_of_orders
from orders
group by year(order_date),month(order_date);

"Hard-Level"
"14. Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column called "Shipped" that displays "On Time" if the order shipped_date is less or equal to the required_date, "Late" if the order shipped late, "Not Shipped" if shipped_date is null.
Order by employee last_name, then by first_name, and then descending by number of orders."
select employees.first_name,employees.last_name,count(orders.order_id) as num_orders,
case when orders.shipped_date<=orders.required_date then 'On Time'
     when orders.shipped_date>orders.required_date then 'Late'
     when orders.shipped_date is null then 'Not Shipped'
     end as Shipped 
from employees
join orders
on employees.employee_id=orders.employee_id
group by employees.last_name,employees.first_name,Shipped
order by employees.last_name,employees.first_name,count(orders.order_id) desc;

"15. Show how much money the company lost due to giving discounts each year, order the years from most recent to least recent. Round to 2 decimal places"
select year(orders.order_date) as order_year,
round(sum(products.unit_price*order_details.quantity*order_details.discount),2) as discount_amount
from orders
join order_details
on orders.order_id=order_details.order_id
join products
on order_details.product_id=products.product_id
group by year(orders.order_date)
order by year(orders.order_date) desc;
