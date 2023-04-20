set echo on
set verify off
set feedback off
set linesize 80
set pagesize 66
clear columns
clear breaks
clear computes


spool C:\cprg250s\TimProject\Selecting\selectScripts.txt


--Show all products available
select product_name
from tim_product join tim_availability using(product_no)
where quantity_on_hand >0;


--Show all customer information
column customer_no format A11
column 'Address' format A40
column 'Phone #' format A20
column 'Email' format A25
column 'Timber Member' format A15
select customer_no "Customer #", customer_address || ', ' || customer_city || ' ' || customer_province || ' ' || c.postal_code "Address",
       customer_phone_no "Phone #", customer_email "Email", 
       case
       when customer_is_timber_member = 1 then 'Yes'
       else 'No'
       end as "Timber Member"
from tim_customer c;

clear columns

--Show all customer reviews for a given product (Input a product ID)

--Show all orders
column 'Product' format A17
column 'Delivered By' format A12
select order_no "Order #", product_name "Product", estimated_delivery_date "Delivered By"
from tim_orders join tim_order_item using(order_no)
     join tim_product using(product_no);
clear columns

--Show all suppliers of a product

select supplier_name
from tim_suppliers
where supplier_no in
    (select product_supplier_no
     from tim_product);

--Show a sorted list of the most popular products based on order history

select product_name "Product Name", count(order_date) "Times Ordered"
from tim_product join tim_order_item using(product_no)
     join tim_orders using(order_no)
group by product_name
order by 2 desc;


--Show the number of products ordered by each customer
select customer_no "Customer #", count(product_no) "Number Of Orders"
from tim_product join tim_order_item using(product_no)
     join tim_orders using (order_no)
where product_name in
    (select product_name
     from tim_product join tim_order_item using(product_no))
group by customer_no
order by customer_no;

--Output all the details on an order, including shipping and appropriate provincial and federal taxes
column 'Order Date' format A15
column 'Province' format A10
column 'Product Price' format '$9,999.00'
column 'Shipping Cost' format '$9,999.00'
column 'Tax' format '$9,999.00'
column 'Total Cost' format '$9,999.00'
select order_no "Order #", customer_no "Customer #", order_date "Order Date",
       estimated_delivery_date "Delivery Date", product_price "Product Price", shipping_cost "Shipping Cost",
       order_tax "Tax", order_province "Province", order_tax + shipping_cost + product_price "Total Cost"
from tim_orders join tim_order_item using(order_no)
     join tim_product using (product_no);
clear columns

--Difficult: Given a customer name, find “recommended products” for the customer

--just need to add user input to find reccomended. It is hard coded rn

accept customer_no number prompt 'Enter Customer number: '
select distinct product_name "Recommended Products"
from tim_customer join tim_orders using(customer_no)
     join tim_order_item using(order_no)
     join tim_product using(product_no)
where product_no in
    (select product_no
    from tim_customer join tim_orders using(customer_no)
        join tim_order_item using(order_no)
        join tim_product using(product_no)
    where customer_no like (&customer_no)) and product_name not in
     (select product_name
      from tim_customer join tim_orders using(customer_no)
           join tim_order_item using(order_no)
           join tim_product using(product_no)
      where customer_no!= &customer_no);


set linesize 75
set pagesize 60
ttitle center 'Supplier Report' Skip 2
btitle off
break on "Supplier" skip 1 on Report
compute sum Label 'Supplier Total Value' of ovalue on "Supplier"
compute sum Label 'Timber Total Sales' of ovalue on Report
column ovalue format $9,999.00 heading 'Order|Value'
column product_price format $9,999.00 heading 'Product|Price'
select supplier_name "Supplier", product_name "Product",
       count(order_no) "Times Ordered", 
       sum(product_price + order_tax + shipping_cost) ovalue
from tim_suppliers join tim_availability using(supplier_no)
     join tim_product using(product_no)
     join tim_order_item using(product_no)
     join tim_orders using (order_no)
group by supplier_name, product_name;
clear breaks
clear columns
clear computes





spool off