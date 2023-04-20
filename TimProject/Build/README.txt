To create the proper tables in your build.sql script you must first drop all tables in reverse order
starting with the child tables and ending with the parent tables. Then you can build the tables by 
using the SQL statement 'CREATE TABLE' in order from parent tables to child tables. Then you fill in
all neccessary attributes or columns and datatypes. Most of this information is on the physical model.