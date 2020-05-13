#!/bin/bash


function Dockerui(){
echo "<< Pulling DokcerUI >>"
sleep 1
sudo docker pull abh1nav/dockerui:latest
sudo docker run -d -p 9000 -v /var/run/docker.sock:/docker.sock \--name dockerui abh1nav/dockerui:latest -e=/docker.sock
sleep 1
echo "Your ip address saved in  /var/log/dockerui.log"
sudo touch /var/log/dockerui.log ; sudo chown 0644 /var/log/dockerui.log
ip -4 -o addr show  | awk '{print $4}' > /var/log/dockerui.log
echo "<< Check the port that opens and enter the site >>"
}


function Containers(){
echo -e "(1) | Show all Containers Names/IP\n(2) | Enter container ID\nYour Choice >:"
read F
if [ $F == "1" ]
then
        echo "All the ips and names of the containers that you have >>"
        sudo docker inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress }}' $(docker ps -aq)

elif [ $F == "2" ]
then
        echo "Enter Container Name/ID :"
        read CONT
        echo "Container IP :"
        docker inspect $CONT | grep  'IPAddress'  | awk 'NR==2 {print $2}' | cut -d '"' -f2

fi
}

function Install(){
echo "Install Docker"
echo -e "(1) | Install docker on this computer\n(2) | Install docker on another computer\nYour Choice >>:"
read c
if [ $C == "1" ]
then
        sudo apt-get update ; sudo apt-get install curl ; bash get - docker.sh
        curl - fsSL https: // get.docker.com - o get - docker.sh
        echo "<<< Docker Installation is Done >>>"
        docker --version ; sudo systemctl status docker
elif [ $C == "2" ]
then
        echo "Enter The IP >>:"
        read IP
        echo "Enter the Password >>:"
        read PASS
        sshpass -p $PASS ssh root@$IP
        sudo apt-get update ; sudo apt-get install curl ; bash get - docker.sh
        curl - fsSL https: // get.docker.com - o get - docker.sh
        echo "<<< Docker Installation is Done >>>"
        docker --version ; sudo systemctl status docker
fi
}

function Pullimages(){
echo "Enter The image name that you want to pull >>:"
read S
sudo docker pull $S
echo -e "Your image >>:", $S ,"\n<< Pulling Successfully >>"
sudo docker images

}

function Deploy(){
echo -e "Those the images :\n-------------"
sudo docker imgaes
#echo -e #(1) | Create containers without ports\n(2) | Create containers with ports\n Your Choice >:"
read CHOOSE
if [ $CHOOSE == "1" ]
then
echo "Enter the image that you want to deploy >>:"
read I
echo "How much Containers do you want? >:"
read H

	for i in $H
	do
   	   sudo docker run -d $I
   	   sudo docker ps -a
	done


elif [ $CHOOSE == "2" ]
then
echo "Write the port and image name that you want, for example: 9000:9010 [Image_name] >>:"
read P
echo "How much Containers do you want? >:"
read O

	for i in $O
	do
   	   sudo docker run -d -p $P
   	   sudo docker ps -a
	done

fi
}

function Show(){
echo "---Showing All Containers and images---"
echo "------Images------"
sudo docker images
echo "------Containers------"
sudo docker ps -a
}

function Delete(){
echo "<<< Those the containers >>> "
sudo docker ps -a
echo -e "(1) | Remove Container\n(2) | Remove all containers\n(3) | Remove Images\n(4) | Remove all Images\nYour choice >>:"
read R
if [ $R == "1" ]
then
	    echo "Enter the container id that you want to delete"
	    read A
	    sudo docker rm -f $A
	    echo "Container :",$A ,"Deleted Successfully"

elif [ $R == "2" ]
then

	    echo "Delete the containers..."
	    sudo docker rm -f $(Docker ps -a -q)

elif [ $R == "3" ]
then
	    sudo docker images
	    echo "Enetr the Image (Name) or Image (id) to delete >>:"
	    read IMAGE
	    sudo docker rmi $IMAGE
	    echo "Image >>:",image ,"<<Deleted Successfully>>"
	    sudo docker images

elif [ $R == "4" ]
then
        echo "Delete The Images .."
        sudo docker rmi -f `docker images -a -q`
fi
}

function Nginx(){
echo "Pulling nginx image and run 2 nginx containers with mount..."
for i in {1..2}
do

   sudo docker pull nginx ; sudo docker run -d -p 80 nginx
   sudo docker run -d -p 80 -v /home/guy/Desktop/web:/usr/share/nginx/html nginx

done
}

function Menu(){
clear
docker --version
echo "----Docker Menu----:
(1) | Install Docker
(2) | Pull Images
(3) | Deploy Images
(4) | Show all Images and containers
(5) | Delete containers and images
(6) | Pull DockerUI
(7) | Containers IP
(8) | Nginx
(9) | exit
Your Choice >>:"
read CHOICE
if [ $CHOICE == "1" ]
then
Install

if [ $CHOICE == "2" ]
then
Pullimages

if [ $CHOICE == "3" ]
then
Deploy

if [ $CHOICE == "4" ]
then
Show

if [ $CHOICE == "5" ]
then
Delete

if [ $CHOICE == "6" ]
then
Dockerui

if [ $CHOICE == "7" ]
then
Containers

if [ $CHOICE == "8" ]
then
Nginx

if [ $CHOICE == "9" ]
then
echo "Bye Bye"


fi
}

Menu
