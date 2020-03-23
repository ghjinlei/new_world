#!/bin/bash
port=$(cat var/running | grep debug_console_port | awk '{print $2}')
rlwrap socat - tcp-connect:localhost:$port
