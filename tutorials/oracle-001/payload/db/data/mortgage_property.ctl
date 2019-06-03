LOAD DATA 
INFILE '/tmp/samples/payload/data/Mortgage_Property.csv'
REPLACE INTO TABLE mortgage_property
fields terminated by ","
(id, saleprice, location)
