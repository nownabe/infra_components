#!/bin/bash

echo "* influxdb-dev-1"
# ssh root@210.140.193.91 netstat -tunlap | grep -v ssh | grep 210.168.36.157
ssh root@210.140.193.91 netstat -tunlap | egrep '8083|8086|8088|8091' | wc -l
echo -e "\n* influxdb-dev-2"
# ssh root@210.140.193.95 netstat -tunlap | grep -v ssh | grep 210.168.36.157
ssh root@210.140.193.95 netstat -tunlap | egrep '8083|8086|8088|8091' | wc -l
echo -e "\n* influxdb-dev-3"
# ssh root@210.140.193.96 netstat -tunlap | grep -v ssh | grep 210.168.36.157
ssh root@210.140.193.96 netstat -tunlap | egrep '8083|8086|8088|8091' | wc -l
