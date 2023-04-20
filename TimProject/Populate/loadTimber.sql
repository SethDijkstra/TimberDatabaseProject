--Populate Timber Database
--Mar 19, Group 2: Jesse Taylor, Seth Dijkstra, Marcus Vuorinen, Carter Sarney

set echo on
set linesize 200
set pagesize 50

--Spool output to load.txt file
spool C:\cprg250s\TimProject\Populate\loadOutput.txt

--Delete existing date from tables, children followed by parents.
delete tim_order_item;
delete tim_availability;
delete tim_orders;
delete tim_customer_reviews;
delete tim_product;
delete tim_customer;
delete tim_suppliers;
delete tim_category;

-- SET DEFINE OFF to avoid the prompt for input caused by the '&' in sports
set define off

--insert the data.. Parents followed by child tables.
--At least 5 categories nested 2 levels deep
insert into tim_category(category_no, category_name, parent_category_no)
    values(1, 'Electronics', null);
insert into tim_category values(2, 'Books', null);
insert into tim_category values(3, 'Sports & Outdoors', null);
insert into tim_category values(4, 'Laptops', 1);
insert into tim_category values(5, 'Tablets', 1);
insert into tim_category values(6, 'Children''s Books', 2);
insert into tim_category values(7, 'History', 2);
insert into tim_category values(8, 'Cycling', 3);
insert into tim_category values(9, 'Golf', 3);

--At least 3 suppliers
insert into tim_suppliers(supplier_no, supplier_name, supplier_email, supplier_city, supplier_province) 
    values(1, 'Apple', 'apple@buyme.ca', 'Toronto', 'ON');
insert into tim_suppliers values(2, 'Dell', 'dell@buyme.ca', 'Toronto', 'ON');
insert into tim_suppliers values(3, 'Indigo', 'indigo@buyme.ca', 'Calgary', 'AB');
insert into tim_suppliers values(4, 'Nike', 'nike@buyme.ca', 'Calgary', 'AB');
insert into tim_suppliers values(5, 'BikesRFun', 'bikesrfun@buyme.ca', 'Saskatoon', 'SK');

--At least 5 customers, some with orders some without
--Customers should be from 3 diff provinces
insert into tim_customer(customer_no, customer_address, customer_city, customer_province, postal_code, customer_phone_no, customer_email, customer_is_timber_member)
    values(32, '123 Main St', 'Vancouver', 'BC', 'V6A1C5', '555-123-4567', 'john.doe@gmail.com', 1);
insert into tim_customer values(54, '474 2nd Ave', 'Edmonton', 'AB', 'T1A3T5', '555-252-4667', 'john.jeffery@gmail.com', 0);
insert into tim_customer values(62, '987 Flower Rd', 'Yellowknife', 'NT', 'X1A2P5', '888-425-5325', 'george.jery@outloook.com', 0);
insert into tim_customer values(10, '474 2nd Ave', 'Montreal', 'QC', 'T1A3T5', '984-123-4144', 'ned-bucannon@hotmail.com', 1);
insert into tim_customer values(93, '1442 81st St', 'Winnipeg', 'MB', 'R3B0P8', '403-555-1234', 'ben-stiller@icloud.ca', 0);
insert into tim_customer values(23, '587 Clover St', 'Regina', 'SK', 'S4S0S4', '843-231-4156', 'kate-cloud@shaw.ca', 1);
insert into tim_customer values(12, '111 9th Ave', 'St. John''s', 'NL', 'A1C6H9', '888-614-9892', 'peanut-butter@sait.ca', 1);

--7+ products
insert into tim_product(product_no, product_name, product_desc, product_price, product_weight, tax_exempt, product_category, supplier_no)
    values(1133, 'Dell 15" Laptop', 'A 15" Laptop made by Dell.', 1029.99, 3.5, 0, 4, 2);
insert into tim_product values(1564, 'Ipad Pro', 'Apple''s top of the line tablet.', 899.99, 2, 0, 5, 1);
insert into tim_product values(1923, 'Mountain Bike', 'A bike...for the mountains...', 699.99, 15, 1, 8, 5);
insert into tim_product values(945, 'Sapiens', 'A brief history of humankind.', 23.00, 0.1, 0, 7, 3);
insert into tim_product values(1020, 'Harry Potter', 'Yer a wizard Harry.', 10.99, 0.09, 0, 6, 3);
insert into tim_product values(1150, 'E-Bike', 'A fast electric bicylce.', 1600.00, 20, 1, 8, 5);
insert into tim_product values(999, '50 Golfballs', 'Balls you golf with.', 39.99, 5, 0, 9, 4);



--5 with customer reviews
insert into tim_customer_reviews(review_no, customer_no, product_no, rating, review_comment, review_date)
    values(9234, 54, 1923, 1, 'I fell off. 1 star.', '15-MAR-21');
insert into tim_customer_reviews values(1394, 32, 945, 5, 'My brain grew 3 sizes.', '20-FEB-20');
insert into tim_customer_reviews values(2103, 93, 1020, 4, 'An amazing book, not my favourite Harry Potter though.', '05-SEP-15');
insert into tim_customer_reviews values(4742, 12, 999, 3, 'Fine balls. Golf game hasn''t improved.', '15-APR-18');
insert into tim_customer_reviews values(3132, 23, 1150, 5, 'A tesla but the wind in your hair.', '29-DEC-22');

--6 orders
insert into tim_orders(order_no, customer_no, order_date, estimated_delivery_date, shipping_cost, order_tax, order_province)
    values(234, 62, '12-OCT-22', '14-OCT-22', 4.99, 2.99, 'NT');
insert into tim_orders values(391, 12, '09-SEP-21', '12-SEP-21', 0, 1.99, 'NL');
insert into tim_orders values(450, 93, '25-APR-22', null, 4.99, 2.99, 'MB');
insert into tim_orders values(99, 10, '03-JAN-23', '06-JAN-23', 0, 20.99, 'QC');
insert into tim_orders values(123, 54, '12-FEB-23', '16-FEB-23', 4.99, 11.99, 'AB');
insert into tim_orders values(742, 32, '30-DEC-22', null, 0, 5.99, 'BC');
insert into tim_orders values(102, 10, '12-OCT-21', '20-OCT-21' , 15, 7.99, 'NL');

insert into tim_availability(supplier_no, product_no, quantity_on_hand, estimated_delivery_days)
    values(2,1133, 8, 3);
insert into tim_availability values(1, 1564,3, 2);
insert into tim_availability values(5, 1923, 12, 3);
insert into tim_availability values(3, 945, 0, null);
insert into tim_availability values(3, 1020, 1, 3);
insert into tim_availability values(5, 1150, 4, 4);
insert into tim_availability values(4, 999, 0, null);


insert into tim_order_item(order_no, product_no, order_quantity)
    values(234, 1133, 2);
insert into tim_order_item values(391,1564, 1);
insert into tim_order_item values(450, 1923, 7);
insert into tim_order_item values(99, 945, 2);
insert into tim_order_item values(123, 1020,1);
insert into tim_order_item values(742, 1150,2);
insert into tim_order_item values(102, 999,6);

commit;

spool off