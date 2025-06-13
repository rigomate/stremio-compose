#!/bin/bash
# nsupdate credentials and URL


NSUPDATE_URL="https://funkyurl.nsupdate.info:password@ipv4.nsupdate.info/nic/update"

# Send the update request with curl
response=$(curl -s -o /dev/null -w "%{http_code}" "$NSUPDATE_URL")

# Check if the request was successful
if [[ "$response" == "200" ]]; then
    echo "IP update successful:"
elif [[ "$response" == "nochg" ]]; then
    echo "IP is already set to global IP"
else
    echo "Failed to update IP. Response code: $response"
fi
