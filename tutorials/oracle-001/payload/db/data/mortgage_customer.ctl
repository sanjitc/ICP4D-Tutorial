LOAD DATA 
INFILE '/tmp/samples/payload/data/Mortgage_Customer.csv'
REPLACE INTO TABLE mortgage_customer
fields terminated by ","
(id, income, appliedonline, residence, yrscurrentadd, yrscurrentemp, noofcards, carddebt, currentloans, loanamount)
