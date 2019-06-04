CREATE TABLE mortgage_customer (
id              INT,
income          INT,
appliedonline   CHAR(5),
residence       CHAR(35),
yrscurrentadd   INT,
yrscurrentemp   INT,
noofcards       INT,
carddebt        INT,
currentloans    INT,
loanamount      INT
);

CREATE TABLE mortgage_default (
id              INT,
mortgagedefault CHAR(10)
);

CREATE TABLE mortgage_property (
id              INT,
saleprice       INT,
location        INT
);
