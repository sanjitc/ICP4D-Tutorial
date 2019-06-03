#!/bin/sh

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
export ORACLE_HOME=/u01/app/oracle/product/12.2.0/dbhome_1
export OH=/u01/app/oracle/product/12.2.0/dbhome_1
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/u01/app/oracle/product/12.2.0/dbhome_1/bin
export TNS_ADMIN=/u01/app/oracle/product/12.2.0/dbhome_1/admin/ORCLCDB
export ORACLE_SID=ORCLCDB;

export PAYLOAD=/tmp/samples/payload

#basedir=$(dirname `which $0`)

# Create Database User
sqlplus / as sysdba <<EOF
alter session set "_ORACLE_SCRIPT"=true;
create user icpduser identified by password;
GRANT CONNECT,RESOURCE,DBA TO icpduser;
GRANT CREATE SESSION TO icpduser;
EOF

sleep 60

# Create Tables
sqlplus icpduser/password@ORCLCDB <<EOF
CREATE TABLE mortgage_customer (
id		NUMBER,
income		NUMBER,
appliedonline	CHAR(5),
residence	CHAR(35),
yrscurrentadd	NUMBER,
yrscurrentemp	NUMBER,
noofcards	NUMBER,
carddebt	NUMBER,
currentloans	NUMBER,
loanamount	NUMBER
);

CREATE TABLE mortgage_default (
id		NUMBER,
mortgagedefault CHAR(10)
);

CREATE TABLE mortgage_property (
id		NUMBER,
saleprice	NUMBER,
location	NUMBER
);
EOF

# Load Data to Tables
sqlldr icpduser/password control=$PAYLOAD/mortgage_customer.ctl
sqlldr icpduser/password control=$PAYLOAD/mortgage_default.ctl
sqlldr icpduser/password control=$PAYLOAD/mortgage_property.ctl

## Check status of Informix instance 
echo "Status of Oracle instance "
lsnrctl status
