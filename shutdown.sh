#!/bin/sh
port=`cat var/running | grep debug_console_port | awk  '{print $2}'`
serv_addr=9

exist_port=$(netstat -ant |grep -i listen | awk '{print $4}' | cut -d ':' -f 2  | grep -w $port)

if [ "$exist_port"x = "$port"x ]; then
	echo "python shutdown_expect.py $port $serv_addr"
	python shutdown_expect.py $port $serv_addr
fi
