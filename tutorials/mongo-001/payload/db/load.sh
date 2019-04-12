#!/bin/sh

export PAYLOAD=/tmp/samples/payload

#Create database and user
mongo << EOF
use icpd_mongo
db.createUser( { user: "mongodbuser", pwd: "password", roles: [ { role: "readWrite", db: "icpd_mongo" } ] })
quit()
EOF

#Load traffic data
mongoimport -u mongodbuser -p password -d icpd_mongo -c traffic_crash --type CSV --file $PAYLOAD/data/Traffic_Crashes_3000.csv --headerline

#Load mortgage data
mongoimport -u mongodbuser -p password -d icpd_mongo -c mortgage_customer --type CSV --file $PAYLOAD/data/Mortgage_Customer.csv --headerline
mongoimport -u mongodbuser -p password -d icpd_mongo -c mortgage_default --type CSV --file $PAYLOAD/data/Mortgage_Default.csv --headerline
mongoimport -u mongodbuser -p password -d icpd_mongo -c mortgage_property --type CSV --file $PAYLOAD/data/Mortgage_Property.csv --headerline
