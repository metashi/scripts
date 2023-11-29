#!/bin/bash

echo "Data i godzina wykonania skryptu: $(date)"

# Load average z topa
echo -e "\nLoad Average:"
top -b -n 1 | grep "load average"

# Free memory w megabajtach
echo -e "\nWolna pamiec RAM w MB:"
free -m

# Miejsce na dyskach
echo -e "\nMiejsce na dyskach:"
df -h

# Zliczanie taskow
tasks_info=$(top -b -n 1 | awk '/Tasks/ {print $2, $4, $6, $8, $10}')
read -r total_tasks running_tasks sleeping_tasks stopped_tasks zombie_tasks <<< "$tasks_info"

echo -e "\nStatystyki taskow:"
echo "Total: $total_tasks"
echo "Running: $running_tasks"
echo "Sleeping: $sleeping_tasks"
echo "Stopped: $stopped_tasks"
echo "Zombie: $zombie_tasks"

echo -e "\n5 najbardziej obciazajacych procesow pod wzgledem memory:"
ps aux --sort=-%mem | head -n 6

echo -e "\n5 najbardziej obciazających procesow pod wzgledem CPU:"
ps aux --sort=-%cpu | head -n 6

# Adresy
echo -e "\nAdresy IP i MAC interfejsow sieciowych:"
ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*|ether ([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}'

# Trasy routingu
echo -e "\nTrasy routingu:"
route -n

# Aktywne połączenia
echo -e "\nAktywne połączenia:"
netstat -tunapl

#Ping
host_to_ping="8.8.8.8"
echo -e "\nPing do $host_to_ping:"
ping -c 4 $host_to_ping

echo -e "\nAnaliza zakończona."
