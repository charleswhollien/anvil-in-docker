#!/bin/bash

#Create uplink key if needed. 

CHECKCONFIG=`cat baseconfig.yml |grep ^uplink |wc -l`
if [ $CHECKCONFIG -eq 0 ]
then
  KEY=$(echo $RANDOM | md5sum | head -c 20; echo;) && echo "uplink-key: ${KEY}" >> /app/baseconfig.yml
  echo "Config Settings:"
  cat /app/baseconfig.yml
else 
  echo "Uplink key already set. Config is:"
  cat /app/baseconfig.yml
fi


#Figure out if there is an app in /app/current

if [ "$(ls -A /app/current)" ]; then
echo "App installed in /app/current"
else
/home/anvil/.local/bin/create-anvil-app blank current
fi

cd /app/current/
/home/anvil/.local/bin/anvil-app-server --config-file /app/baseconfig.yml

