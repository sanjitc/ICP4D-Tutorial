#!/bin/sh

export PAYLOAD=/tmp/samples/payload

export INFORMIXDIR=/opt/ibm/informix
export ONCONFIG=onconfig
export INFORMIXSERVER=informix
export INFORMIXSQLHOSTS=/opt/ibm/informix/etc/sqlhosts
export PATH=$INFORMIXDIR/bin:$PATH

basedir=$(dirname `which $0`)

dbaccess << ESQL
  CREATE DATABASE MORTGAGEDB;
  DATABASE MORTGAGEDB;
  CREATE TABLE MORTGAGE_DEFAULT (ID INTEGER, MORTGAGE_DEFAULT CHAR(10));
  Load from '$PAYLOAD/data/mortgage_default.txt' delimiter ',' insert into MORTGAGE_DEFAULT; 
ESQL

## Check status of Informix instance 
echo "Status of Informix instance "
onstat -
