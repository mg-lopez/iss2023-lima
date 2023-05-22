#!/bin/bash

# Change directory to 'dbserver'
cd /home/csc/iss2023-lima/dbserver

# Runs the database container
docker run -d --net iss2023/lima_n --ip 198.51.100.150 --hostname db.iss.cyber23.test -e MYSQL_ROOT_PASSWORD="CorrectHorseBatteryStaple-xkcd" -e MYSQL_DATABASE="iss2023db" --name iss2023-lima-db_c --security-opt seccomp=$PWD/database-container.json --security-opt label:type:iss2023-lima-db_c_t iss2023/lima-db_i

# Wait for 10 seconds
sleep 10

# Imports the database configurations
docker exec -i iss2023-lima-db_c mysql -uroot -pCorrectHorseBatteryStaple-xkcd < sqlconfig/iss2023db.sql

# Change directory to 'webserver'
cd /home/csc/iss2023-lima/webserver

# Runs the webserver container
docker run -d --net iss2023/lima_n --ip 198.51.100.149 --hostname www.iss.cyber23.test --add-host db.iss.cyber23.test:198.51.100.150 -p 8080:80 --name iss2023-lima-web_c --security-opt seccomp=$PWD/webserver-container.json --security-opt label:type:iss2023-lima-web_c_t iss2023/lima-web_i
