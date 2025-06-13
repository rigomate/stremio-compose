#!/bin/bash
# nsupdate credentials and URL

# Check if an IP address is provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

NSUPDATE_URL="https://funkyurl.nsupdate.info:password@ipv4.nsupdate.info/nic/update"

# Desired IP address
NEW_IP="$1"

# Send the update request with curl
response=$(curl -s -o /dev/null -w "%{http_code}" "$NSUPDATE_URL?myip=$NEW_IP")

# Check if the request was successful
if [[ "$response" == "200" ]]; then
    echo "IP update successful: $NEW_IP"
elif [[ "$response" == "nochg" ]]; then
    echo "IP is already set to $NEW_IP"
else
    echo "Failed to update IP. Response code: $response"
fi
