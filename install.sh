#!/bin/bash

if [[ $EUID -ne 0 ]]
then
    echo -e "${RED}RUN AS SUDO"
    exit
fi

apt install python3 -y
apt install python3-pip -y
pip3 install flask
pip3 install flask_cors
apt install -y mitmproxy
apt install nano
git submodule init
git submodule update
chmod +x dhcp_snooping/DNS-Rogue-Server/dnsserver.py
chmod +x dhcp_snooping/DHCP-Server/dhcpserver.py
chmod +x dhcp_snooping/DHCP-Server/starvation.py
chmod +x dhcp_snooping/Simply-HTTP-sniffer/sniffer.py
chmod +x Netattack/mon.py
chmod +x Netattack/nattack.py
chmod +x Netattack/nscan.py
chmod +x injection/injector.sh
chmod +x injection/injecthtml.py
chmod +x server/flaskserver.py
pip3 install -r dhcp_snooping/Simply-HTTP-sniffer/requirements.txt
pip3 install -r dhcp_snooping/DHCP-Server/requirements.txt
pip3 install -r dhcp_snooping/DNS-Rogue-Server/requirements.txt
pip3 install -r Netattack/requirements.txt
