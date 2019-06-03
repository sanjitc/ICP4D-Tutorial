#!/bin/bash

#set -x

RIGHT_NOW=$(date +"%x %r %Z")
TIME_STAMP="Updated on $RIGHT_NOW by $USER"
PAYLOAD="/tmp/samples/payload"
ORCL_DOCKER_NAME="oracle-tutorial"
D=docker


##### Functions

__loadOracleDocker()
{


   $D images > /dev/null 2>&1; rc=$?;
   if [[ $rc != 0 ]]; then
                echo "Docker Not Installed. Are you on ICP4D cluster environment ?"
                exit 1
   fi
   
   echo "You need to login to docker.com to download Oracle docker image."
   $D login docker.com
   if [[ $rc != 0 ]]; then
                echo "Docker Login Failed !!"
                exit 1
   fi


   if [[ ! `docker images --quiet store/oracle/database-enterprise:12.2.0.1` ]]; then
        echo -e "\nLoading Docker $ORCL_DOCKER_NAME ..."
        $D run -d -it --name $ORCL_DOCKER_NAME -p 32710:1521 -p 55000:5500 store/oracle/database-enterprise:12.2.0.1
        #Wait couple of minutes to make sure Oracle instance started and online
        sleep 120
   fi

   echo -e "\nMaking some space for data"
   #make a sample directory
   $D   exec $ORCL_DOCKER_NAME bash -c  "mkdir -p $PAYLOAD"

   echo -e "\nMoving Payload to Oracle"
   #push the payload
   $D cp data  $ORCL_DOCKER_NAME:$PAYLOAD
   $D cp load.sh  $ORCL_DOCKER_NAME:$PAYLOAD/data
   $D cp data/Mortgage_Customer.csv  $ORCL_DOCKER_NAME:$PAYLOAD
   $D cp data/Mortgage_Default.csv  $ORCL_DOCKER_NAME:$PAYLOAD
   $D cp data/Mortgage_Property.csv $ORCL_DOCKER_NAME:$PAYLOAD
   $D cp data/mortgage_customer.ctl $ORCL_DOCKER_NAME:$PAYLOAD
   $D cp data/mortgage_default.ctl  $ORCL_DOCKER_NAME:$PAYLOAD
   $D cp data/mortgage_property.ctl $ORCL_DOCKER_NAME:$PAYLOAD

   echo -e "\nOralce being loaded with data for you to try out"

   #run setup the payload
   $D exec $ORCL_DOCKER_NAME  bash -c "cd $PAYLOAD/; ./data/load.sh"


}

__loadOracleDocker
