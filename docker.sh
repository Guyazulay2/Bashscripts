#!/bin/bash


function Dockerui(){
echo "<< Pulling DokcerUI >>"
sudo docker pull abh1nav/dockerui:latest
sudo docker run -d -p 80 -v /var/run/docker.sock:/docker.sock \--name dockerui abh1nav/dockerui:latest -e=/docker.sock
echo "<< Check the port that opens and enter the site >>"

}

function Install(){
echo "Install Docker"
curl - fsSL https: // get.docker.com - o get - docker.sh
sudo bash get - docker.sh
echo "<<< Docker Installation is Done >>>"

}

function Pullimages(){
echo "Enter The image name that you want to pull >>:"
read S
sudo docker pull $S
echo -e "Your image >>:", $S ,"\n<< Pulling Successfully >>"
sudo docker images

}

function Deploy(){
echo "Those the images"
sudo docker imgaes
echo -e "(1) | Create containers without ports\n(2) | Create containers with ports\n Your Choice >>:"
read CHOOSE
if [ $CHOOSE == "1" ]
then
	echo "Enter the image that you want to deploy >>:"
	read B
	sudo docker run -d + $B
	sudo docker ps -a

elif [ $CHOOSE == "2"]
then
	echo "Write the port and image name that you want, for example: 9000:9010 [Image_name] >>:"
	read C
	sudo docker run -d -p + $C
	sudo docker ps -a

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
echo "(1) | Remove Container\n(2) | Remove all containers\n(3) | Remove Images\nYour choice >>:"
read C
if [ $C == "1" ]
then
	echo "Enter the container id that you want to delete"
	read A
	sudo docker stop + $A
	sudo docker rm + $A
	echo "Container :",$A ,"Deleted Successfully"

elif [ $C == "2" ]
then
	echo "Stop the containers..."
	sudo docker stop $(docker ps -a -q)
	echo "Delete the containers..."
	sudo docker rm $(docker ps -a -q)


elif [ $C == "3" ]
then
	sudo docker images
	echo "Enetr the Image (Name) or Image (id) to delete >>:"
	read IMAGE
	sudo docker rmi + $IMAGE
	echo "Image >>:",image ,"<<Deleted Successfully>>"
	sudo docker images

fi
}

function Menu(){
sudo apt-get install curl
clear
docker --version
echo "----Docker Menu----:
(1) | Install Docker
(2) | Pull Images
(3) | Deploy Images
(4) | Show all Images and containers
(5) | Delete containers and images
(6) | Pull DockerUI
(7) | Exit
Your Choice >>:"
read CHOICE
if [ $CHOICE == "1" ]
then
Install

elif [ $CHOICE == "2" ]
then
Pullimages

elif [ $CHOICE == "3" ]
then
Deploy

elif [ $CHOICE == "4" ]
then
Show

elif [ $CHOICE == "5" ]
then
Delete

elif [ $CHOICE == "6" ]
then
Dockerui

elif [ $CHOICE == "7" ]
then
echo "Bye Bye"



fi

}

Menu
