#!/bin/bash

# Pass the 2 arguments to the script
REDIS_PORT_NUMBER="${1}"
MAX_MEMORY="${2}"

# Find and replace the corresponding values inside the redis.conf file
sed -i -e 's/REDIS_PORT_NUMBER/'"${REDIS_PORT_NUMBER}"'/g' /usr/local/etc/redis/redis.conf
if [[ $? -ne 0 ]]; then
  echo "Something went wrong while trying to change the port number!"
  return 1
fi 

sed -i -e 's/MAX_MEMORY/'"${MAX_MEMORY}"'/g' /usr/local/etc/redis/redis.conf
if [[ $? -ne 0 ]]; then
  echo "Something went wrong while trying to change the max memory!"
  return 1
fi 

# Start Redis Server by utilizing the updated redis.conf file
redis-server /usr/local/etc/redis/redis.conf