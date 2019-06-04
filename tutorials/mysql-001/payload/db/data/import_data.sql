LOAD DATA INFILE '/var/lib/mysql-files/Mortgage_Customer.csv' replace INTO TABLE mortgage_customer FIELDS TERMINATED BY ',';
LOAD DATA INFILE '/var/lib/mysql-files/Mortgage_Property.csv' replace INTO TABLE mortgage_property FIELDS TERMINATED BY ',';
LOAD DATA INFILE '/var/lib/mysql-files/Mortgage_Default.csv' replace INTO TABLE mortgage_default FIELDS TERMINATED BY ',';
