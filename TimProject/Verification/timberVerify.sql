--Verify Timber Database
--Mar 19, Group 2: Jesse Taylor, Seth Dijkstra, Marcus Vuorinen, Carter Sarney

set echo on

spool C:\cprg250s\ProjectNew\Verification\timberVerify.txt

--Use select statements to grab data from all tables.
select * from tim_category;
select * from tim_suppliers;
select * from tim_customer;
select * from tim_product;
select * from tim_customer_reviews;
select * from tim_orders;
select * from tim_availability;
select * from tim_order_item;

spool off