#!/bin/bash

#job2

echo "<<Enter the ip >>:"
read IP
echo "<<Change host-name to slave, Enter the name >>:"
read HOST
echo $HOST > host.txt
scp host.txt guy@193.168.1.2:/home/guy/Desktop/host.txt

sshpass -p 'rootroot' ssh root@$IP '\\
cat /home/guy/Desktop/host.txt > /etc/hostname
echo "<< Installation >>"
apt-get install net-tools -y
apt-get install python3.7 -y
apt-get install trace-route -y
apt-get install sshpass -y
echo "<< Make python3.7 default >>"
alias python=python3
echo "<< Updating and upgrading >>"
sudo apt update
sudo apt upgrade
echo "<< install CURL >>"
sudo apt install curl
echo "<< install java >>"
apt install openjdk-8-jdk
echo "<< install nmap >>"
apt-get install nmap
echo 'auto lo
iface lo inet loopback
auto enp0s3
iface enp0s3 inet dhcp
auto enp0s8
iface enp0s8 inet dhcp
		address 193.168.1.2
		netmask 255.255.255.0
		network 193.168.1.0
		broadcast 193.168.1.255">/etc/network/interfaces
echo "PermitRootLogin yes'>/etc/ssh/sshd_config
reboot '
