#!/usr/bin/env python3
import sys
import miniupnpc

def configure_upnp(action):
    # Create UPnP object
    upnp = miniupnpc.UPnP()
    
    # Discover available UPnP routers
    upnp.discoverdelay = 200
    upnp.discover()

    # Select the first available IGD (Internet Gateway Device)
    if not upnp.selectigd():
        print("No UPnP-enabled router found.")
        return

    # Get the local machine's IP on the network
    internal_ip = upnp.lanaddr
    ports = [80]  # Ports to manage, orig: ports = [80, 443]
    protocol = "TCP"   # Change to "UDP" if needed

    if action == "open":
        for port in ports:
            upnp.addportmapping(port, protocol, internal_ip, port, f"Port {port} Forwarding", "")
            print(f"Opened port {port} -> {internal_ip}:{port} via UPnP")
    elif action == "close":
        for port in ports:
            upnp.deleteportmapping(port, protocol)
            print(f"Closed port {port} via UPnP")
    else:
        print("Invalid argument. Use 'open' to open ports or 'close' to close ports.")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <on|close>")
    else:
        configure_upnp(sys.argv[1])
