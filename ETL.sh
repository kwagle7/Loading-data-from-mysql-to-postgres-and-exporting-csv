#!/bin/sh

## Write your code here to load the data from sales_data table in Mysql server to a sales.csv.
## Select the data which is not more than 4 hours old from the current time.
mysql -u root -p'MTM4MTQta3NoaXRp' -e "SELECT * FROM sales_data WHERE timestamp >= NOW() - INTERVAL 4 HOUR INTO OUTFILE '/home/project/sales.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" sales

export PGPASSWORD=MjMxODUta3NoaXRp;
psql --username=postgres --host=localhost --dbname=sales_new -c "TRUNCATE TABLE sales_data;"
psql --username=postgres --host=localhost --dbname=sales_new -c "TRUNCATE TABLE factsales;"
psql --username=postgres --host=localhost --dbname=sales_new -c "TRUNCATE TABLE dimdate;"

 psql --username=postgres --host=localhost --dbname=sales_new -c "\COPY sales_data(rowid,product_id,customer_id,price,quantity,timestamp) FROM '/home/project/sales.csv' delimiter ',' csv header;" 
 
 ## Delete sales.csv present in location /home/project

 sudo rm -f /home/project/sales.csv

 ## Write your code here to load the DimDate table from the data present in sales_data table

psql --username=postgres --host=localhost --dbname=sales_new -c "
    INSERT INTO public.dimdate(dateid, day, month, year)
    SELECT 
        TO_CHAR(timestamp, 'YYYYMMDD')::INTEGER AS dateid,
        EXTRACT(DAY FROM timestamp) AS day,
        EXTRACT(MONTH FROM timestamp) AS month,
        EXTRACT(YEAR FROM timestamp) AS year
    FROM sales_data;
"
## Write your code here to load the FactSales table from the data present in sales_data table
psql --username=postgres --host=localhost --dbname=sales_new -c "
        INSERT INTO public.factsales (rowid, product_id, custome_id, price, total_price) 
         SELECT 
            rowid, product_id,customer_id,price,(quantity*price) as total_price
         FROM sales_data;
"

 ## Write your code here to export DimDate table to a csv
psql --username=postgres --host=localhost --dbname=sales_new -c "\COPY public.dimdate TO '/home/project/dimdate.csv' DELIMITER ',' CSV HEADER;"

 ## Write your code here to export FactSales table to a csv
psql --username=postgres --host=localhost --dbname=sales_new -c "\COPY public.factsales TO '/home/project/factsales.csv' DELIMITER ',' CSV HEADER;"
