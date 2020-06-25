#!/bin/bash

echo "
(1) | Key exchange
(2) | Execute sudo without Password
(3) | Change host-name to client
(4) | Show local IP
(5) | Create a folder with details inside a file and send to client
(6) | PermitRootLogin
(7) | Turn on/off service
(8) | Kill processes
(9) | Update and upgrade

(10) | Exit
Your choice :"

read choose

if [ $choose == "1" ]
then
	echo "< Create ssh-keygen >"
	ssh-keygen
	sleep 0.5
	echo "Enter the client ip >:"
	read IP
	ssh-copy-id guy@$IP

elif [ $choose == "2" ]
then

	echo "Execute sudo without Password.."
	sleep 0.5
	echo "Enter your username >:"
	read USER
	echo ""$USER" ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
	echo "Done"


elif [ $choose == "3" ]
then

        echo "Change host-name to slave, Enter the name >:"
        read HOST
        echo $HOST > host.txt
        scp host.txt guy@$IP:/home/guy/Desktop/host.txt
        sshpass -p 'rootroot' ssh root@$IP '\\
        cat /home/guy/Desktop/host.txt > /etc/hostname
        reboot'

elif [ $choose == "4" ]
then
	echo "--- Your Ip address ---"
	sleep 0.5
	ip addr show enp0s3 |egrep 'inet '| awk '{print $2}'| cut -d '/' -f1

elif [ $choose == "5" ]
then
	echo "Enter the folder name >:"
	read FOLDER
	mkdir $FOLDER
	cd $FOLDER

	echo "Create Details file >:"
	touch details.txt
	
	echo "Enter your details :"
	echo "Full Name :"
	read NAME
	echo "Age :"
	read AGE
	echo "Phone Number :"
	read PHONE
	echo "Address :"
	read ADD

	echo "Full Name :" $NAME > details.txt
	echo "Age :"  $AGE >> details.txt
	echo "Phone number :" $PHONE >> details.txt
	echo "Adress :" $ADD >> details.txt
	
	echo "Enter the IP >:"
	read IP
	scp details.txt guy@$IP:/home/guy/Desktop/details.txt
	
	
elif [ $choose == "6" ]
then
	echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

elif [ $choose == "7" ]
then
echo "Do you want to :
(1) | Start service
(2) | Stop service
(3) | Restart service
(4) | Check service status
Your choice :"
read CHOICE

if [ $CHOICE == "1" ]
then
	echo "Enter the service name >:"
	read NAME
	sudo systemctl start $NAME

elif [ $CHOICE == "2" ]
then
	echo "Enter the service name >:"
	read NAME
	sudo systemctl stop $NAME

elif [ $CHOICE == "3" ]
then
	echo "Enter the service name >:"
	read NAME
	sudo systemctl restart $NAME

elif [ $CHOICE == "4" ]
then
	echo "Enter the service name >:"
	read NAME
	sudo systemctl status $NAME

fi

elif [ $choose == "8" ]
then
	echo "All the process"
	sudo ps aux

	echo "How much Process do you want to kill? >:"
	read NUM

	for i in $NUM
	do
		echo "Enter the Process PID that you want to kill >:"
	        read PID
		sudo kill -9 $PID
	done

elif [ $choose == "9" ]
then
	echo "Update & upgrade the machine"
	sleep 0.5
	sudo apt-get update
	sudo apt-get upgrade

elif [ $choose == "10" ]
then
	echo "ByeBye"


fi
