#!/bin/bash

#set -x

RIGHT_NOW=$(date +"%x %r %Z")
TIME_STAMP="Updated on $RIGHT_NOW by $USER"
#PAYLOAD="/tmp/samples/payload"
PAYLOAD="/opt/mysql"
PAYLOAD_ORG=/var/lib/mysql-files
MYSQL_DOCKER_NAME="mysqldb"
D=docker


##### Functions

__loadMySQLDocker()
{
   $D images > /dev/null 2>&1; rc=$?;
   if [[ $rc != 0 ]]; then
                echo "Docker Not Installed. Are you on ICP4D cluster environment ?"
                exit 1
   fi
   
   if [[ ! `docker images --quiet mysql/mysql-server:latest` ]]; then
        echo -e "\nLoading Docker $MYSQL_DOCKER_NAME ..."
        #$D run --name=mysqldb -p 3306:33060 -e MYSQL_ROOT_HOST=%  -d mysql/mysql-server:latest
        $D run --name=mysqldb -e MYSQL_ROOT_PASSWORD=password -d mysql/mysql-server:latest
        #Wait couple of minutes to make sure Mysql instance started and online
        sleep 120
   fi

   echo -e "\nMaking some space for data"
   #make a sample directory
   $D   exec $MYSQL_DOCKER_NAME bash -c  "mkdir -p $PAYLOAD"

   echo -e "\nMoving Payload to MySQL"
   #push the payload
   $D cp data  $MYSQL_DOCKER_NAME:$PAYLOAD
   $D cp load.sh  $MYSQL_DOCKER_NAME:$PAYLOAD/data
   $D cp data/table_schema.sql  $MYSQL_DOCKER_NAME:$PAYLOAD
   $D cp data/Mortgage_Customer.csv  $MYSQL_DOCKER_NAME:$PAYLOAD
   $D cp data/Mortgage_Default.csv  $MYSQL_DOCKER_NAME:$PAYLOAD
   $D cp data/Mortgage_Property.csv $MYSQL_DOCKER_NAME:$PAYLOAD
   $D exec -it $MYSQL_DOCKER_NAME cp -r $PAYLOAD/* $PAYLOAD_ORG

   echo -e "\nMySQL being loaded with data for you to try out"

   #run setup the payload
   $D exec $MYSQL_DOCKER_NAME  bash -c "cd $PAYLOAD_ORG/; ./data/load.sh"


}

__loadMySQLDocker
