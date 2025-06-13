#!/bin/bash

#first stop the containers
docker compose down

#delete the current certificates to enforce a new challenge from letsencrypt
rm -rf ./letsencrypt

#modify the nsupdate.info domains to point to the global public IP 
./nsupdate-global.sh

#open the ports 80 and 443 on the router
./port-upnp.py open


#make sure the change goes through the internet
sleep 180

#start the containers, which will trigger a certificate renewal
docker compose up -d

sleep 180
#change back to local IP address after the renewal
./nsupdate-local.sh 192.168.10.12

#close the ports on the router
./port-upnp.py close
