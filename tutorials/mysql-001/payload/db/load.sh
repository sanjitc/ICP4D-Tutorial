#!/bin/sh
#set -x 
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
export PAYLOAD=/var/lib/mysql-files

#basedir=$(dirname `which $0`)

# Create Database
mysql -u root -ppassword -e "CREATE DATABASE mortgage"

# Create Tables
mysql -u root -ppassword mortgage < $PAYLOAD/data/table_schema.sql

# Load Data to Tables
mysql -u root -ppassword mortgage < $PAYLOAD/data/import_data.sql

## Check status of Informix instance 

echo "Status of MySQL instance "
mysql -u root -ppassword -e "status"
