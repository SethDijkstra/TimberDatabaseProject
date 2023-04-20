To populate tables in a load.sql script we first can delete all existing data from the columns in our
tables(if there was any) and then we can use the 'INSERT INTO' statement and the table name we want 
to access like 'INSERT INTO tim_category' and then using the 'values' statement like:
values (data1, data2, data3); in the order you created the columns.