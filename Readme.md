# Sets up stremio with stremio-ncore

Traefik acts as a https proxy, which reveices letsencrypt certificate.
The certificate itself is force renewd with a cronjob:

`
0 5 1 * * cd /home/pi/stremio/ && /bin/bash /home/pi/stremio/enforce-encryption-renew.sh >> /var/log/stremio.log 2>&1
`

Traefik needs to be exposed to the internet, so using python upnp the ports are opened in the router, then a challenge is forced by deleting the certificate files and then restarting docker compose.

Once it is finished the ports are closed again.

Nevertheless traefik is told to only forward queries to the stremio containers with a ip whitelist.

If you wish to use this, make sure to fill out the passwords and urls correctly.

Be sure to register to nsupdate.info