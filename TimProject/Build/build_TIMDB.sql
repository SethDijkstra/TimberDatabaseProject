--Create Timber Database
--Mar 19, Group 2: Jesse Taylor, Seth Dijkstra, Marcus Vuorinen, Carter Sarney

set echo on

--Spool output to load.txt file
spool C:\cprg250s\TimProject\Build\buildOutput.txt

--drop child tables first then parent
drop table tim_order_item;
drop table tim_availability;
drop table tim_orders;
drop table tim_customer_reviews;
drop table tim_product;
drop table tim_customer;
drop table tim_suppliers;
drop table tim_category;


--create parent tables followed by child
create table tim_category(
    category_no number(4,2) constraint sys_category_no_pk Primary Key,
    category_name varchar2(25) not null,
    parent_category_no number,
    constraint sys_category_no_fk foreign key (parent_category_no)
        references tim_category(category_no)
);

create table tim_suppliers(
    supplier_no number,
    supplier_name varchar2(20) not null,
    supplier_email varchar2(25) not null,
    supplier_city varchar2(25) not null,
    supplier_province char(2) not null constraint sys_tim_supplier_province_ck 
        check (supplier_province in ('BC', 'AB', 'SK', 'MB', 'ON', 'QC', 'NB', 'NS', 'NL' ,'NT', 'NU', 'PE', 'YT' ))
);

alter table tim_suppliers
    add constraint sys_supplier_no_pk primary key(supplier_no);
alter table tim_suppliers
    add constraint sys_suppler_email_ck check (supplier_email like '%__@%.%');

create table tim_customer(
    customer_no number constraint sys_customer_no_pk2 Primary Key,
    customer_address varchar2(25) not null,
    customer_city varchar2(15) not null,
    customer_province varchar2(2) not null constraint sys_tim_customer_province_ck2 
        check (customer_province in ('BC', 'AB', 'SK', 'MB', 'ON', 'QC', 'NB', 'NS', 'NL' ,'NT', 'NU', 'PE', 'YT' )),
    postal_code varchar2(6) constraint sys_postal_code_ck2 check (REGEXP_LIKE(postal_code, '^[A-Za-z]\d[A-Za-z]\d[A-Za-z]\d$')),
    customer_phone_no varchar2(14) not null constraint sys_customer_phone_ck2 CHECK (REGEXP_LIKE(customer_phone_no, '[0-9]{3}-[0-9]{3}-[0-9]{4}')),
    customer_email varchar2(30) not null constraint sys_customer_email_ck2 check (customer_email like '%__@%.%'),
    customer_is_timber_member number(1) not null check (customer_is_timber_member in (0,1))
);

create table tim_product(
    product_no number constraint sys_product_no_pk Primary Key,
    product_name varchar2(25) not null,
    product_desc varchar2(40) not null,
    product_price number(8,2) not null,
    product_weight number(4,2) not null,
    tax_exempt number(1) not null,
    product_category number(3),
    supplier_no number(1),
    constraint sys_product_category_fk foreign key (product_category)
        references tim_category(category_no),
    constraint sys_product_supplier_no_fk foreign key (supplier_no)
        references tim_suppliers(supplier_no)
);

create table tim_customer_reviews(
    review_no number constraint sys_review_no_pk Primary Key,
    customer_no number,
    product_no number,
    rating number not null constraint sys_rating_ck check (rating BETWEEN 1 AND 5),
    review_comment varchar2(55) not null,
    review_date DATE not null,
    constraint sys_customer_no_fk foreign key (customer_no)
        references tim_customer(customer_no),
    constraint sys_product_no_fk foreign key (product_no)
        references tim_product(product_no)
);

create table tim_orders(
    order_no number constraint sys_orders_no_pk Primary Key,
    customer_no number,
    order_date DATE not null,
    estimated_delivery_date date,
    shipping_cost number(8,2) not null,
    order_tax number(4,2) not null,
    order_province varchar2(2) not null constraint sys_tim_order_province_ck2
        check (order_province in ('BC', 'AB', 'SK', 'MB', 'ON', 'QC', 'NB', 'NS', 'NL' ,'NT', 'NU', 'PE', 'YT' )),
    constraint sys_order_customer_no_fk foreign key (customer_no)
        references tim_customer(customer_no)
);

create table tim_availability(
    supplier_no number,
    product_no number,
    quantity_on_hand number not null constraint sys_quantity_ck check (quantity_on_hand >= 0),
    estimated_delivery_days number check (estimated_delivery_days >= 0),
    constraint sys_tim_availability_pk primary key (supplier_no, product_no),
    constraint sys_supplier_no_fk foreign key (supplier_no) references tim_suppliers(supplier_no),
    constraint sys_product_no_fk2 foreign key (product_no) references tim_product(product_no)
);

create table tim_order_item(
    order_no number,
    product_no number,
    order_quantity number not null constraint sys_order_quantity_ck check (order_quantity > 0),
    constraint sys_tim_order_item_pk primary key (order_no, product_no),
    constraint sys_order_no_fk foreign key (order_no) references tim_orders(order_no),
    constraint sys_product_id_fk3 foreign key (product_no) references tim_product(product_no)
);

spool off