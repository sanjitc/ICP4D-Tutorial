LOAD DATA 
INFILE '/tmp/samples/payload/data/Mortgage_Default.csv'
REPLACE INTO TABLE mortgage_default
fields terminated by ","
(id, mortgagedefault)
