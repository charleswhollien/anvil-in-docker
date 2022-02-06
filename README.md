# anvil-in-docker

# Anvil running in docker. 

# Run a anvil container

docker run -p 3030:3030 -d anvil

This will create a new blank app in /app/current. To run your own app bind mount or copy in your downloaded code to /app/current

# Finding your uplink key: 
To find your uplink key look at the output of the container logs. The initial run will generate a uplink key. Probably best to create a bind mount of your config for production. 
 
