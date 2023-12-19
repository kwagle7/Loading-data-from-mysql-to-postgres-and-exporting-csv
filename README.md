# Objective
Create a shell script to:

- Extract the data from the MySQL database and load it into the PostgreSQL Staging warehouse
- Transform the data and load in DimDate and FactSales table
- Export the tables as CSV files for loading into the production warehouse.
- Schedule a cron job to automate these tasks

# Overview:
You need to keep data synchronized between different databases/data warehouses as a part of your daily routine. One task that is routinely performed is the sync up of the transactional database and staging data warehouse. Automating this sync-up will save you time and standardize your process.

The Data Warehouse gets information from several sources including the transactional (OLTP) database. Transactional data from the OLTP database (in this case MySQL) needs to be propagated to the warehouse on a frequent basis. This data movement can be updated using ETL processes.

In this project, you will set up an ETL process using a shell script to extract new transactional data for each day from the MySQL database and load it into the staging data warehouse in PostgreSQL. You will set up a Cron Job to schedule these tasks.

Later you will perform the transformation on the table in the staging warehouse to create a dimension table and a fact table.

You will then export these tables as CSV files to the production warehouse.

You will begin preparing the lab environment by starting the MySQL server. You will then create a sales database in MySQL and load two csv files sales_old_data.csv which has an old timestamp and the sales_new_data.csv with the current timestamp incrementally in sales_data table. You will be executing a setup shell script which will automate the process of creating the database, table and loading the table.

Next, you will start your staging warehouse PostgreSQL server. You will then execute another setup script to create tables in PostgresSQL.

The final task requires you to automate the extraction of data from the sales database present in the transactional database (MySQL) and load it in the Staging Warehouse (PostgreSQL) using a cron job. You will download the shell script from the link provided in the lab and use it as a template. After performing each task, you will need to take a screenshot of the command you used and its output, and name the screenshot.

# Solution:

- Step 1: Download all the files in your working project(if you are downloading from server you can use wget www.yoururl.com)
- Step 2: Start mysql server
- Step 3: Start postgres server
- Step 4: update username and password and run `bash setupmysqldb.sh`, and ignore warnings.
- Step 5: Similarly run `bash setuppostgresqldb.sh`
- Step 6: run `bash ETL.sh` - this is the step to extract the data from the MySQL database, transform and load it into the PostgreSQL Staging Warehouse, and export the database tables into csv files (this CSV files can be used for production warehouse)
- Step 7: Schedule a corn job to automate these tasks
      - start the crontab> write a command in the crontab editor to automate the tasks in the ETL.sh file every 24 hours. > start the cron service.

  DONE.


